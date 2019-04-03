/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_moveToMarker.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Teleports player to map marker with given spacing
*
*	Example(s):
*		[player, marker1, 50] spawn tiig_fnc_moveToMarker; (Move player to marker 1 with 50 meter spacing from center of marker)
*
*	Parameter(s):
*		0 UNIT (Mandatory):
*			OBJECT (player to move)
*
*		1 MARKER (Mandatory):
*			STRING - Marker (Map marker)
*
*		2 SPACING (Mandatory):
*			NUMBER - Number in meters
*
*	Returns:
*		ARRAY - [x,y,z] where player was moved
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

params ["_u","_m","_s", "_safePos", "_sP"];

_mP = getMarkerPos _m;

waitUntil {
	_sP = [_s, _s, _mP # 0, _mP # 1] call tiig_fnc_rand2d;
	_safePos = _sP findEmptyPosition [0, _s, "B_CargoNet_01_ammo_F"];

	if(count _safePos > 0) exitWith { TRUE };
};

waitUntil {
	_u setPos _safePos;

	_uPos = position _u;
	_uDist = _uPos distance _safePos;

	sleep 0.5;

	if(_uDist <= 10) exitWith { TRUE };
};

terminate _thisScript;