/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_joinTheFight.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Joins unit to the fight
*
*	Example(s):
*		[_unit] spawn tiis_fnc_joinTheFight;
*
*	Parameter(s):
*		none
*
*	Returns:
*		BOOLEAN - true if unit joined correctly
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_unit", objNull, [objNull]]];
if(!(_unit isEqualType objNull) || isNull _unit) exitWith { ["tiis_fnc_joinTheFight: cannot be used without an object"] call tiig_fnc_log; };

// Make unit join west
waitUntil {
	if (side _unit != west) then { [_unit] joinSilent (createGroup west); };
	sleep 0.5;
	if (side _unit == west) exitWith { TRUE };
};

// Move unit to play area
waitUntil {
	[_unit, "tag_startSpawn", (tag_playGroundSettings select 1)-10] call tiig_fnc_moveToMarker;
	sleep 0.5;
	if (_unit distance (getMarkerPos "tag_startSpawn") < (tag_playGroundSettings select 1)+100) exitWith { TRUE };
};

// Give unit "playing" status
_unit setVariable ["tag_unitPlaying", true, true];

// Populate player list with this unit
_pList = missionNamespace getVariable "tag_playerList";
_pList pushBack _unit;
missionNamespace setVariable ["tag_playerList", _pList, true];

[["%1 joined the fight", name _unit], "DEEPDEBUG", "CHAT"] call tiig_fnc_log;

terminate _thisScript;