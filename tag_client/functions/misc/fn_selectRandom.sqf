/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_selectRandom.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		When called, a player gets randomly selected. Does not include civilians
*		NOTE: Nothing is truly random but we can pretend
*
*	Example(s):
*		_randomPlayer = call tiig_fnc_selectRandom;
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

private ["_selectedPlayer","_allPlayers"];

_allPlayers = []; {
	if (!isNull _x) then {
		if (((_x isKindOf "Man") && (str(side _x) != "CIV")) && (getPlayerUID _x != "")) then {
			_allPlayers pushBack _x;
		};
	};
} forEach playableUnits;

_selectedPlayer = [_allPlayers] call tiig_fnc_randomArray;
_selectedPlayer