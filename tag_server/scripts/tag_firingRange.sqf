/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_firingRange.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Load firing range
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*
*	ADD WEAPONRY
*	
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

// Check if there's any loot boxes at spawn
if(!isNil "tag_rangeLoot1") then {
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
};

["tag_firingRange.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;