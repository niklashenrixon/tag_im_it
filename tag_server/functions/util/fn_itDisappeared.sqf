/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_itDisappeared.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Returns true if anyone is currently "IT"
*
*	Example(s):
*		_itAlive = spawn tiis_fnc_itDisappeared;
*
*	Parameter(s):
*		none
*
*	Returns:
*		BOOLEAN - true if anyone is currently "IT"
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_newIt"];

_newIt = call tiig_fnc_selectRandom;

["""IT"" Disappeared somehow... Someone new will be selected to play as ""IT"" in 20 seconds", 1, 0, 0.7, 10, 1337, "exclude", _newIt, "mp"] call tiig_fnc_messanger;
["""IT"" Disappeared somehow... You have been selected to play as ""IT"", you have 20 seconds until you're ""IT""", 1, 0, 0.7, 10, 1337, "specific", _newIt, "mp"] call tiig_fnc_messanger;

sleep 20;

[_newIt] joinSilent (createGroup east);

_newIt setVariable ["tag_unitIsIT", true, true];

tag_ItTime = round(time);
publicVariable "tag_ItTime";

["You're ""IT"" now, good luck!", 1, 0, 0.7, 5, 1337, "specific", _newIt, "mp"] call tiig_fnc_messanger;

if (tag_playerCount >= 3) exitWith { ["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _newIt, "mp"] call tiig_fnc_messanger; };

terminate _thisScript;