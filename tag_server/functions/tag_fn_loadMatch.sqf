/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_fn_loadMatch.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Determine what round-type to laod
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

#define waitTimerValue 60

waitTimer = waitTimerValue;

tag_mCountReached = FALSE;
tag_readyToPlay   = FALSE;

/*
*	Display waiting for players message
*/
tag_waitingForPlayers = 0 spawn {
	
	while{!tag_readyToPlay} do {

		tag_playerCount1 = count playableUnits;

		if (tag_playerCount1 <= 1 && !tag_mCountReached) then {
			[str(tag_playerCount1) + tag_m_waitingForPlayer, 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;
		};

		if (tag_playerCount1 >= 2 && !tag_mCountReached) then {
			[str(tag_playerCount1) + tag_m_waitingForPlayers, 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;
		};

		if (tag_playerCount1 >= tag_minPlayersToStart && tag_mCountReached) then {
			["Minimum player count reached, waiting for more players.", 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;
			[str(waitTimer) + " seconds remaining until a round starts.", 0.6, 0, 0.9, 5, 3010, "all", nil, "mp"] call tiig_fnc_messanger;
		};

		sleep 15;
	};
};

/*
*	- Start timer countdown when enough players joined
*	- Terminate waiting message
*/
waitUntil {

	tag_playerCount2 = count playableUnits;
	[["Wait timer: %1", waitTimer], "DEEPDEBUG", "CHAT"] call tiig_fnc_log;

	if (tag_playerCount2 >= tag_minPlayersToStart && !tag_mCountReached) then { tag_mCountReached = TRUE; };
	if (tag_playerCount2 >= tag_minPlayersToStart && tag_mCountReached)  then { waitTimer = waitTimer - 1; };
	if (tag_playerCount2 < tag_minPlayersToStart && tag_mCountReached)  then { tag_mCountReached = FALSE; waitTimer = waitTimerValue; };
	if (tag_playerCount2 >= tag_minPlayersToStart && waitTimer <= 0 && tag_mCountReached) exitWith { tag_readyToPlay = TRUE; terminate tag_waitingForPlayers; TRUE };

	sleep 1;
};

/*
*	Set global variables to "Round started" and make sure all players are in west
*/
tag_roundInProgress = true;	publicVariable "tag_roundInProgress";
tag_deadSpawnLock = true; publicVariable "tag_deadSpawnLock";

waitUntil {
	{
		if (side _x != west) then {
			[_x] joinSilent (createGroup west);
		};
	} forEach playableUnits;

	if (({side _x == west} count playableUnits) >= tag_minPlayersToStart) exitWith { tag_allPlayersIsWest = true; TRUE };

	sleep 1;
};

/* Load map */
_joinMessage = format ["Round starting with %1 players", tag_playerCount2];
[_joinMessage, 1, 0, 0.7, 5, 1337, "noCiv", nil, "mp"] call tiig_fnc_messanger;

/* Load loot message */
["Loading loot..", 1, 0, 0.8, 20, 1338, "noCiv", nil, "mp"] call tiig_fnc_messanger;

/* Start setting up for a round */
0 execVM "\tag_server\scripts\tag_setupRound.sqf";

/* Remove eventhadler that adds waiting time to countdown */
["tagPlayerConnected", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

/* Log new round */
[["NEW_MATCH_STARTED: Round ID: %1 | Map: %2 | Nr of Players: %3", tag_roundID, tag_worldName, tag_playerCount2], "DEBUG"] call tiig_fnc_log;

/* Load watchdog script when round has started */
waitUntil {
	if (tag_roundStarted) exitWith {
		0 execVM "\tag_server\scripts\tag_watchDog.sqf";
		TRUE
	};
	sleep 1;
};

// Spawn hintsystem on IT
0 execVM "\tag_server\scripts\tag_itHint.sqf";

["tag_fn_loadMatch loaded", "DEEPDEBUG"] call tiig_fnc_log;