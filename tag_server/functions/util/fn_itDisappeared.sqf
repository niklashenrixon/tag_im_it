/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_itDisappeared.sqf
*	@Location: {@mod\addons}\tag_server\functions\util\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Selects new unit to play as IT if current IT disappeared somehow
*
*	Example(s):
*		0 spawn tiis_fnc_itDisappeared;
*
*	Parameter(s):
*		none
*
*	Returns:
*		none
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_newIt"];

_msgNew = format ["<t color='%1'>IT disappeared.. A new IT will be selected in 20 seconds</t>", TAG_COLOR_RED];
[_msgNew, 1.2, 0, 0.6, 5, 9026, 'noCiv', nil, 'mp'] call tiig_fnc_messanger;

sleep 20;

_newIt = call tiig_fnc_selectRandom;

[_newIt] joinSilent (createGroup east);

missionNamespace setVariable ["tag_playerIt", _newIt, true];
_newIt setVariable ["tag_unitIsIT", true, true];
_newIt setVariable ["tag_unitTimeITBegin", round(time), true];

_msgIT = format ["<t color='%1'>YOU'RE IT!</t>", TAG_COLOR_RED];
[_msgIT, 1.2, 0, 0.6, 5, 9026, "specific", _newIt, "mp"] call tiig_fnc_messanger;

if (tag_playerCount >= 3) then {
	_msgIT = format ["<t color='%1'>There's a new IT</t>", TAG_COLOR_RED];
	[_msgIT, 1.2, 0, 0.6, 5, 9026, 'exclude', _newIt, 'mp'] call tiig_fnc_messanger;
};

terminate _thisScript;