/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_addToCargo.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Empty out given cargo container globally
*
*	Example(s):
*		["_cargo","_list","_type"] call tiig_fnc_addToCargo;
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

params ["_cargo","_list","_type"];
if (isNull _cargo) exitWith { ["tiig_fnc_addToCargo: provide a cargo to use this function"] call tiig_fnc_log; };

switch (_type) do {
	case "item": 	 { { _cargo addItemCargoGlobal 	   _x; } forEach _list; };
	case "ammo": 	 { { _cargo addMagazineCargoGlobal _x; } forEach _list; };
	case "weapon":   { { _cargo addWeaponCargoGlobal   _x; } forEach _list; };
	case "backpack": { { _cargo addBackpackCargoGlobal _x; } forEach _list; };
};