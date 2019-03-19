/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_firingRange.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Load firing range
*
*	Example(s):
*		call tiis_fnc_firingRange;
*
*	Parameter(s):
*
*	Returns:
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

["OUTSIDE RANGE LOOT"] call tiig_fnc_log;

// Make sure we have enough players on west
waitUntil {
	if (!isNil "tag_rangeLoot1") exitWith {
		// Weapon classname, amount of each weapon
		_ammoList = [];

		{	
			_object = _x;
		 	_weapon = _object select 0;
		 	_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
			_magazineClass = _magazines call bis_fnc_selectRandom;

			_ammoList pushBack [_magazineClass, 5];

		} forEach tag_lootWeaponsQ;

		// Start adding loot
		[[tag_rangeLoot1, tag_rangeLoot2, tag_rangeLoot3, tag_rangeLoot4]] call tiig_fnc_emptyCargo;

		[tag_rangeLoot1, tag_lootWeaponsQ, "weapon"] call tiig_fnc_addToCargo;
		[tag_rangeLoot2, tag_lootWeaponsQ, "weapon"] call tiig_fnc_addToCargo;

		[tag_rangeLoot3, _ammoList, "ammo"] call tiig_fnc_addToCargo;
		[tag_rangeLoot4, tag_lootAttachmentQ, "item"] call tiig_fnc_addToCargo;
		["INSIDE RANGE LOOT"] call tiig_fnc_log;
		
		TRUE
	};

	sleep 2;
};