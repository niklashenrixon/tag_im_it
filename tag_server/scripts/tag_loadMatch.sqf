/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_loadMatch.sqf
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

/*
*	Display waiting for players message
*/
tag_waitingForPlayers = 0 spawn {
	
	while{true} do {

		_waitingPlayer  = format ["%1 player online right now. A minimum of %2 needed.", str(tag_playerCountAll), str(tag_minPlayersToStart)];
		_waitingPlayers = format ["%1 players online right now. A minimum of %2 needed.", str(tag_playerCountAll), str(tag_minPlayersToStart)];

		if (tag_playerCountAll <= 1 && !tag_mCountReached) then {
			[_waitingPlayer, 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;
		};

		if (tag_playerCountAll >= 2 && !tag_mCountReached) then {
			[_waitingPlayers, 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;
		};

		if (tag_playerCountAll >= tag_minPlayersToStart && tag_mCountReached) then {
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

	[["Wait timer: %1", waitTimer], "DEEPDEBUG", "ONLYCHAT"] call tiig_fnc_log;

	if (tag_playerCountAll >= tag_minPlayersToStart && !tag_mCountReached) then { tag_mCountReached = TRUE; };
	if (tag_playerCountAll >= tag_minPlayersToStart && tag_mCountReached)  then { waitTimer = waitTimer - 1; missionNamespace setVariable ["tag_gameLoading", true, true]; };
	if (tag_playerCountAll < tag_minPlayersToStart && tag_mCountReached)  then { tag_mCountReached = FALSE; waitTimer = waitTimerValue; missionNamespace setVariable ["tag_gameLoading", false, true]; };

	// Triggered when player count is reached and countdown has ended (Game starts now)
	if (tag_playerCountAll >= tag_minPlayersToStart && waitTimer <= 0 && tag_mCountReached) exitWith {
		terminate tag_waitingForPlayers;
		missionNamespace setVariable ["tag_timeRoundBegin", round(time), true];
		[tag_roundID, tag_playerCountAll] call tiis_fnc_insertServerStats;
		TRUE
	};

	sleep 1;
};

/* Load map */
_joinMessage = format ["Round starting with %1 players", tag_playerCountAll];
[_joinMessage, 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;

/* Load loot message */
["Loading loot..", 1, 0, 0.8, 60, 1338, "all", nil, "mp"] call tiig_fnc_messanger;

/* Start setting up for a round */
0 execVM "\tag_server\scripts\tag_setupRound.sqf";

/* Remove eventhandler that adds waiting time to countdown */
["tagPlayerConnected", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

/* Log new round */
[["NEW_MATCH_STARTED: Round ID: %1 | Map: %2 | Nr of Players: %3", tag_roundID, tag_worldName, tag_playerCountAll], "DEBUG"] call tiig_fnc_log;

["tag_fn_loadMatch loaded", "DEEPDEBUG"] call tiig_fnc_log;