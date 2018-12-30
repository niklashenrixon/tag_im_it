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

_theOne = call tiig_fnc_selectRandom;
[_theOne] joinSilent (createGroup east);

_theOne setVariable ["tag_unitIsIT", true, true];

tag_removeGear = true; publicVariable "tag_removeGear";

{
	if (side _x != civilian) then {
		sleep 0.2;
		[_x, "tag_startSpawn", (tag_playGroundSettings select 1)-30] call tiig_fnc_moveToMarker;
		_x setVariable ["tag_unitPlaying", true, true];
	};
} forEach playableUnits;

/* Remove loot message */
["", 1, 0, 0.8, 0.5, 1338, "noCiv", nil, "mp"] call tiig_fnc_messanger;

tag_playersMoved = true; publicVariable "tag_playersMoved";

tag_playerIt = _theOne;	publicVariable "tag_playerIt";
tag_firstIT = _theOne; publicVariable "tag_firstIT";

sleep 4;

{
	if (side _x != civilian) then {
		if (_x distance (getMarkerPos "tag_startSpawn") > (tag_playGroundSettings select 1)+100) then {
			[_x, "tag_startSpawn", (tag_playGroundSettings select 1)-30] call tiig_fnc_moveToMarker;
			_x setVariable ["tag_unitPlaying", true, true];
		};
	};
} forEach playableUnits;

/* Remove loot message */
["", 1, 0, 0.8, 0.5, 1338, "noCiv", nil, "mp"] call tiig_fnc_messanger;

missionNamespace setVariable ["tag_gameInProgress", true, true];

["Start looting! Someone will be tagged as IT in 10 seconds.",  1, 0, 0.7, 8, 1337, "all", nil, "mp"] call tiig_fnc_messanger;

sleep 9;

["You are the chosen one",  1, 0, 0.7, 5, 1337, "specific", _theOne, "mp"] call tiig_fnc_messanger;

_timesM = ["30","29","28","27","26","25","24","23","22","21","20","19","18","17","16","15","14","13","12","11","10","9","8","7","6","5","4","3","2","1"];

{
	_countMessage = _x;
	["Round starts in " + _countMessage, 0.7, 0, 0.9, 2, 3010, "all", nil, "mp"] call tiig_fnc_messanger;
	sleep 1;
} forEach _timesM;

tag_roundStarted = true; publicVariable "tag_roundStarted";
tag_ItTime = round(time); publicVariable "tag_ItTime";

["LET THE HUNT BEGIN!", 1, 0, 0.7, 5, 1337, "noCiv", nil, "mp"] call tiig_fnc_messanger;

["tag_startRound.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;