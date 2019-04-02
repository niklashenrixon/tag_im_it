/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_circleShrink.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Shrink circle periodically
*
*	Example(s):
*		[_interval, _shrink, _smallest] spawn tiis_fnc_circleShrink;
*
*	Parameter(s):
*
*	Returns:
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

_par = params [["_interval", 30], ["_shrink", 10], ["_smallest", 40], "_size"];

if(!_par) then {
	_interval = getMissionConfigValue ["tag_c_interval", 60];
	_shrink = getMissionConfigValue ["tag_c_shrink", 10];
	_smallest = getMissionConfigValue ["tag_c_minSize", 30];
};

tag_updateCircle = true;

waitUntil { tag_gameInProgress }; // Wait for a round to start before updating circle size

// Make sure we have enough players on west
waitUntil {

	// Current values of playarea
	_pos = tag_playGroundSettings select 0;
	_size = tag_playGroundSettings select 1;
	_size = _size - _shrink;

	if(!tag_gameInProgress) exitWith { TRUE }; // Stop updating when game ends
	if(_size <= _smallest) exitWith { [["Shrinking circle: size: <%1>", _size]] call tiig_fnc_log; TRUE }; // Stop updating when we reach this size

	sleep 5; // Wait for value to be updated on every client

	missionNamespace setVariable ["tag_playGroundSettings", [_pos, _size], true];

	"tag_playArea" setMarkerSize [_size, _size];

	publicVariable "tag_updateCircle";

	[["Shrinking circle: size: <%1>", _size]] call tiig_fnc_log;

	sleep _interval;
};