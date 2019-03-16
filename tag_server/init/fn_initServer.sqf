/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_initServer.sqf
*	@Location: {@mod\addons}\tag_server\init\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*
*	Example(s):
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

// If client, be gone!
if (hasInterface) exitWith {};

// Improve server performance
if (!getRemoteSensorsDisabled) then { disableRemoteSensors true;};

// Add mission eventhandlers
addMissionEventHandler ["PlayerConnected", { _this spawn tiis_fnc_onPlayerConnected; }];
addMissionEventHandler ["HandleDisconnect", { _this spawn tiis_fnc_onHandleDisconnect; }];

// Add variable eventhandlers
"tag_checkVersion" addPublicVariableEventHandler { (_this select 1) spawn tiis_fnc_onCheckVersion; }; // Check connecting player version and kick if different
"tag_setBanned" addPublicVariableEventHandler {	(_this select 1) call tiis_fnc_onSetBanned; }; // Set unit to banned
"tag_addScore" addPublicVariableEventHandler { (_this select 1) call tiis_fnc_onAddScore; }; // Add score to unit

// Game states
missionNamespace setVariable ["tag_gameReady",     false, true]; // True when server is ready to start a game. True until loading begins
missionNamespace setVariable ["tag_gameLoading",   false, true]; // True during round setup
missionNamespace setVariable ["tag_gameInProgress",false, true]; // True after loading is done (all players have been moved), true until game starts to unload
missionNamespace setVariable ["tag_gameEndgame",   false, true]; // True when round hits 2 players, true until game starts to unload
missionNamespace setVariable ["tag_gameUnloading", false, true]; // True during unloading phase
missionNamespace setVariable ["tag_gameFinished",  false, true]; // True after unloading is done

// Other
missionNamespace setVariable ["tag_playGroundSettings", [[0, 0, 0], 100], true];

// Generate new id number for the round thats going to be played
_roundId = [32] call tiis_fnc_generateRoundId;
missionNamespace setVariable["tag_roundID", _roundId, TRUE];

// Start weather system
0 spawn tiig_fnc_dynWeather;

// Start message system
0 spawn tiis_fnc_messageSystem;

execVM "\tag_server\scripts\tag_loadServer.sqf";