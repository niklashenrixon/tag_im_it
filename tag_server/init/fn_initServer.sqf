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
if (!getRemoteSensorsDisabled) then { disableRemoteSensors true; };

// Initialize Database
missionNamespace setVariable ["tag_dbConn", false, true];
_initDB = ["tag", "SQL_CUSTOM"] call tiis_fnc_initDB;
if (_initDB) then {	missionNamespace setVariable ["tag_dbConn", true, true]; };

// Add mission eventhandlers
addMissionEventHandler ["PlayerConnected", { _this spawn tiis_fnc_onPlayerConnected; }];
addMissionEventHandler ["HandleDisconnect", { _this call tiis_fnc_onHandleDisconnect; }];
addMissionEventHandler ["EachFrame", { tag_playerCount = {side _x != resistance && side _x != civilian && alive _x} count playableUnits; tag_playerCountAll = count playableUnits; }];

// Add variable eventhandlers
"tag_checkVersion" addPublicVariableEventHandler { (_this select 1) spawn tiis_fnc_onCheckVersion; }; // Check connecting player version and kick if different
"tag_setBanned" addPublicVariableEventHandler {	(_this select 1) call tiis_fnc_onSetBanned; }; // Set unit to banned

// Game states
missionNamespace setVariable ["tag_gameReady",     false, true]; // True when server is ready to start a game. True until loading begins
missionNamespace setVariable ["tag_gameLoading",   false, true]; // True during round setup
missionNamespace setVariable ["tag_gameInProgress",false, true]; // True after loading is done (all players have been moved), true until game starts to unload
missionNamespace setVariable ["tag_gameEndgame",   false, true]; // True when round hits 2 players, true until game starts to unload
missionNamespace setVariable ["tag_gameUnloading", false, true]; // True during unloading phase
missionNamespace setVariable ["tag_gameFinished",  false, true]; // True after unloading is done

// Other
missionNamespace setVariable ["tag_playGroundSettings", [[0, 0, 0], 100], true];
missionNamespace setVariable ["tag_playerIt", objNull, true];
missionNamespace setVariable ["tag_firstIt", objNull, true];
missionNamespace setVariable ["tag_playerList", [], true];

missionNamespace setVariable ["tag_timeStarted", round(time), true];
missionNamespace setVariable ["tag_timeRoundBegin", 0, true];
missionNamespace setVariable ["tag_timeRoundEnd", 0, true];
missionNamespace setVariable ["tag_timeRoundDuration", 0, true];

// Generate new id number for the round thats going to be played
_rID = [32] call tiis_fnc_generateRoundId;
missionNamespace setVariable["tag_roundID", _rID, TRUE];

// Fetch alot of data from DB
0 spawn tiis_fnc_getData;

// Start weather system
0 spawn tiig_fnc_dynWeather;

// Start message system
0 spawn tiis_fnc_messageSystem;

// Load statistics module
// call compile preprocessFileLineNumbers "\tag_server\scripts\tag_statistics.sqf";

// Load the round
execVM "\tag_server\scripts\tag_loadMatch.sqf";

// Index loot location on loaded map
//["tag_indexLoot", FALSE] call tag_fn_getLootPos;

// Load firing range
0 spawn tiis_fnc_firingRange;