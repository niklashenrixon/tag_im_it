/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_roundMilitary.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Start round
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

tag_ejectVehicle = TRUE;
publicVariable "tag_ejectVehicle"; // Eject all players from Vehicle

{ [_x] spawn tiis_fnc_joinTheFight; } forEach playableUnits; // Move all players to playground

// Make sure we can continue
waitUntil {
	_jpc = count tag_playerList;
	_pc = 0;

	{   _j = _x getVariable "tag_unitPlaying";
		if(_j) then { _pc = _pc + 1; };
	} forEach tag_playerList;

	if (_jpc == _pc && _pc >= tag_minPlayersToStart) exitWith { TRUE };
	// Maybe some message like "Still waiting for players to join.."
	sleep 1;
};

_theOne = call tiig_fnc_selectRandom;

waitUntil {
	_itIsReady = _theOne getVariable "tag_unitPlaying";
	sleep 1;
	if (_itIsReady) exitWith {
		missionNamespace setVariable ["tag_playerIt", _theOne, true];
		missionNamespace setVariable ["tag_firstIt", _theOne, true];
		_theOne setVariable ["tag_unitTimeITBegin", round(time), true];
		TRUE
	};
};

// Remove "loading loot" message
["", 1, 0, 0.8, 0.5, 1338, "noCiv", nil, "mp"] call tiig_fnc_messanger;

sleep 4;

_msgLooting = format ["<t color='%1'>Start looting! Someone will be tagged as IT in 30 seconds</t>", TAG_COLOR_RED];
[_msgLooting, 1, 0, 0.7, 8, 1337, "noCiv", nil, "mp"] call tiig_fnc_messanger;

sleep 9;

_timesM = ["30","29","28","27","26","25","24","23","22","21","20","19","18","17","16","15","14","13","12","11","10","9","8","7","6","5","4","3","2","1"];

{
	_countMessage = _x;
	["Round starts in " + _countMessage, 0.7, 0, 0.9, 2, 3010, "noCiv", nil, "mp"] call tiig_fnc_messanger;
	sleep 1;
} forEach _timesM;

tag_ItTime = round(time); publicVariable "tag_ItTime";

missionNamespace setVariable ["tag_gameLoading", false, true];
missionNamespace setVariable ["tag_gameInProgress", true, true];

[_theOne] joinSilent (createGroup east);
_theOne setVariable ["tag_unitIsIT", true, true];

_msgHunt = format ["<t color='%1'>LET THE HUNT BEGIN!</t>", TAG_COLOR_RED];
[_msgHunt, 1.2, 0, 0.6, 5, 9027, "exclude", _theOne, "mp"] call tiig_fnc_messanger;

_msgIT = format ["<t color='%1'>YOU'RE IT!</t>", TAG_COLOR_RED];
[_msgIT, 1.2, 0, 0.6, 5, 9027, "specific", _theOne, "mp"] call tiig_fnc_messanger;

// Load watchdog
execVM "\tag_server\scripts\tag_watchDog.sqf";

// Spawn hintsystem on IT
execVM "\tag_server\scripts\tag_itHint.sqf";

["tag_startRound.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;