/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_lootSystem.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Spawns loot @ designated marker
*
*	Example(s):
*		[[exclusionList]] call tiis_fnc_lootSystem;
*
*	Parameter(s):
*		0 ARRAY (Mandatory):
*			Multi-dim array with positions to spawn loot at = [[_houseId, _houseType, _posX, _posY, _posZ], [_houseId, _houseType, _posX, _posY, _posZ]]
*
*		1 ARRAY (Optional):
*			Array with house types to exclude from loot spawning = ["Land_i_House_Small_01_V2_F", "Land_Pier_F"]
*
*	Returns:
*		id(string)
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [
	["_lootPositions", [], [[]] ],
	["_exclusionList", [], [[]] ],
	["_chanceCount0", 0],
	["_chanceCount1", 0],
	["_typeCount0", 0],
	["_typeCount1", 0],
	["_typeCount2", 0],
	["_typeCount3", 0],
	["_typeCount4", 0],
	["_typeCount5", 0],
	["_typeCount6", 0],
	["_lootArray", []]
];
if (count _lootPositions == 0) exitWith { ["tiis_fnc_lootSystem: No loot positions provided"] call tiig_fnc_log; };

/* Start choosing random positions to spawn loot inside */
for "_i" from 0 to (count _lootPositions)-1 do {

	_selectedNr = round(floor(random count _lootPositions));
	_selectedPos = _lootPositions select _selectedNr;
	_lootPositions deleteAt _selectedNr;

	_houseId	= _selectedPos select 0;
	_houseType  = _selectedPos select 1;
	_posX 		= parseNumber (_selectedPos select 2);
	_posY		= parseNumber (_selectedPos select 3);
	_posZ		= parseNumber (_selectedPos select 4);

	_itemSpawned = FALSE;

	if (!(_houseType in _exclusionList)) then {

		if (tag_spawnProbability > random 100) then {

			_chanceCount1 = _chanceCount1 + 1;

			_holder = createVehicle ["groundWeaponHolder", [_posX, _posY, _posZ], [], 0, "CAN_COLLIDE"];

			[["LOOT_SHUFFLED_ARRAY_COUNT: %1", count _lootPositions], "DEEPDEBUG"] call tiig_fnc_log;
			[["LOOT_SHUFFLED_ARRAY: %1", _lootPositions], "DEEPDEBUG"] call tiig_fnc_log;
			[["LOOT_SELECTED_NR: %1", _selectedNr], "DEEPDEBUG"] call tiig_fnc_log;
			[["LOOT_SELECTED_OBJECT: %1", _selectedPos], "DEEPDEBUG"] call tiig_fnc_log;
			[["LOOT_SPAWNING_HOUSE [ID]: %1", _houseId], "DEEPDEBUG"] call tiig_fnc_log;
			[["LOOT_SPAWNING_HOUSE [TYPE]: %1", _houseType], "DEEPDEBUG"] call tiig_fnc_log;
			[["LOOT_SPAWNING_POS: [X: %1] [Y: %2] [Z: %3]", _posX, _posY, _posZ], "DEEPDEBUG"] call tiig_fnc_log;

			while {!_itemSpawned} do {

				_selectedType = tag_lootTypeRatio call BIS_fnc_selectRandomWeighted;

				_lootType = "NULL";

				// Spawn Weapon
				if (_selectedType == "weapon" && !_itemSpawned && count tag_lootWeapons != 0) then {

					_itemSpawned = TRUE;
					_lootType = 0;
					_typeCount0 = _typeCount0 + 1;

					_loot = tag_lootWeapons call BIS_fnc_selectRandomWeighted;

					_magazines = getArray (configFile / "CfgWeapons" / _loot / "magazines");
					_magazineClass = _magazines call bis_fnc_selectRandom;

					_holder addWeaponCargoGlobal [_loot, 1];
					_holder addMagazineCargoGlobal [_magazineClass, 2];

					[["LOOT_SPAWNING_ITEM [WEAPON]: %1 | %2", _loot, _magazineClass], "DEEPDEBUG"] call tiig_fnc_log;
				};

				// Spawn Magazine
				if (_selectedType == "magazine" && !_itemSpawned && count tag_lootWeapons != 0) then {

					_itemSpawned = TRUE;
					_lootType = 1;
					_typeCount1 = _typeCount1 + 1;

					_weapon = tag_lootWeapons call BIS_fnc_selectRandomWeighted;

					_loot = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
					_magazineClass = _loot call bis_fnc_selectRandom;

					_holder addMagazineCargoGlobal [_magazineClass, 2];

					[["LOOT_SPAWNING_ITEM [MAGAZINE]: %1", _magazineClass], "DEEPDEBUG"] call tiig_fnc_log;
				};

				// Spawn Attachment
				if (_selectedType == "attachment" && !_itemSpawned && count tag_lootAttachment != 0) then {

					_itemSpawned = TRUE;
					_lootType = 2;
					_typeCount2 = _typeCount2 + 1;

					_loot = tag_lootAttachment call BIS_fnc_selectRandomWeighted;
					_holder addItemCargoGlobal [_loot, 1];

					[["LOOT_SPAWNING_ITEM [ATTACHMENT]: %1", _loot], "DEEPDEBUG"] call tiig_fnc_log;
				};

				// Spawn Medical
				if (_selectedType == "medical" && !_itemSpawned && count tag_lootMedical != 0) then {

					_itemSpawned = TRUE;
					_lootType = 3;
					_typeCount3 = _typeCount3 + 1;
					
					_loot = tag_lootMedical call BIS_fnc_selectRandomWeighted;
					_holder addItemCargoGlobal [_loot, 1];

					[["LOOT_SPAWNING_ITEM [MEDICAL]: %1", _loot], "DEEPDEBUG"] call tiig_fnc_log;
				};

				// Spawn Gadget
				if (_selectedType == "gadget" && !_itemSpawned && count tag_lootGadget != 0) then {

					_itemSpawned = TRUE;
					_lootType = 4;
					_typeCount4 = _typeCount4 + 1;
					
					_loot = tag_lootGadget call BIS_fnc_selectRandomWeighted;
					_holder addItemCargoGlobal [_loot, 1];

					[["LOOT_SPAWNING_ITEM [GADGET]: %1", _loot], "DEEPDEBUG"] call tiig_fnc_log;
				};

				// Spawn Clothes
				if (_selectedType == "clothes" && !_itemSpawned && count tag_lootClothes != 0) then {

					_itemSpawned = TRUE;
					_lootType = 5;
					_typeCount5 = _typeCount5 + 1;
					
					_loot = tag_lootClothes call BIS_fnc_selectRandomWeighted;
					_holder addItemCargoGlobal [_loot, 1];

					[["LOOT_SPAWNING_ITEM [CLOTHES]: %1", _loot], "DEEPDEBUG"] call tiig_fnc_log;
				};

				// Spawn Armor
				if (_selectedType == "armor" && !_itemSpawned && count tag_lootArmor != 0) then {

					_itemSpawned = TRUE;
					_lootType = 6;
					_typeCount6 = _typeCount6 + 1;
					
					_loot = tag_lootArmor call BIS_fnc_selectRandomWeighted;
					_holder addItemCargoGlobal [_loot, 1];

					[["LOOT_SPAWNING_ITEM [ARMOR]: %1", _loot], "DEEPDEBUG"] call tiig_fnc_log;
				};

				// Show marker on map if debug mode is enabled
				if (tag_debugMode >= 2 && _itemSpawned) then {
					_id = format ["%1", (getPos _holder)];
					_debug = createMarker [_id, getPos _holder];
					_debug setMarkerShape "ICON";
					_debug setMarkerType "hd_dot";
					_debug setMarkerColor "ColorRed";
					_txt = format ["%1", _lootType];
					_debug setMarkerText _txt;	
				};

			};

			["------------------------------------------------------", "DEEPDEBUG"] call tiig_fnc_log;

		} else {
			_chanceCount0 = _chanceCount0 + 1;

			["LOOT_SPAWNING_SKIPPED", "DEEPDEBUG"] call tiig_fnc_log;
			["------------------------------------------------------", "DEEPDEBUG"] call tiig_fnc_log;

		};
	};
};

[["LOOT_SPAWNING_PROBABILITY [NO]: %1", _chanceCount0], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_PROBABILITY [YES]: %1", _chanceCount1], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_TYPE [Weapon]: %1", _typeCount0], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_TYPE [Magazine]: %1", _typeCount1], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_TYPE [Attachment]: %1", _typeCount2], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_TYPE [Medical]: %1", _typeCount3], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_TYPE [Gadget]: %1", _typeCount4], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_TYPE [Clothes]: %1", _typeCount5], "DEBUG"] call tiig_fnc_log;
[["LOOT_SPAWNING_TYPE [Armor]: %1", _typeCount6], "DEBUG"] call tiig_fnc_log;
[["LOOT_TYPES PERCENTAGE: %1", _lootArray], "DEBUG"] call tiig_fnc_log;