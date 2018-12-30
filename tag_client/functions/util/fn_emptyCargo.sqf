/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_emptyCargo.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Empty out given cargo container globally
*
*	Example(s):
*		["_cargoContainer"] call tiig_fnc_emptyCargo;
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

params ["_cargo"];

if (_cargo isEqualType []) then {
	{
		clearItemCargoGlobal _x;
		clearWeaponCargoGlobal _x;
		clearBackpackCargoGlobal _x;
		clearMagazineCargoGlobal _x;
	} forEach _cargo;
} else {
	clearItemCargoGlobal _cargo;
	clearWeaponCargoGlobal _cargo;
	clearBackpackCargoGlobal _cargo;
	clearMagazineCargoGlobal _cargo;
};