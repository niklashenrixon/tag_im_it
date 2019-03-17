/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_itExists.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Returns true if anyone is currently "IT"
*
*	Example(s):
*		_itExists = call tiis_fnc_itExists;
*
*	Parameter(s):
*		none
*
*	Returns:
*		BOOLEAN - true if anyone is currently "IT"
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_itCount","_cnt"];

_itCount = [];

{
	if(side _x != civilian) then {
		if(_x getVariable "tag_unitIsIT") then {
			_itCount pushBack _x;
		};
	};
} forEach playableUnits;

private _returnThis = if (count _itCount >= 1) then { true; } else { false; };

_returnThis