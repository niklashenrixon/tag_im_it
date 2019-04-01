/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_getData.sqf
*	@Location: {@mod\addons}\tag_server\functions\db\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Fetch various data from database
*
*	Example(s):
*		0 spawn tiis_fnc_getData;
*
*	Parameter(s):
*
*	Returns:
*		none
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

if(tag_dbConn) then {

	tag_adminList       = [];
	tag_lootPositions   = [];

	tag_lootWeapons     = [];
	tag_lootAttachment  = [];
	tag_lootMedical     = [];
	tag_lootGadget      = [];
	tag_lootClothes     = [];
	tag_lootArmor       = [];

	tag_lootWeaponsQ    = [];
	tag_lootAttachmentQ = [];
	tag_lootMedicalQ    = [];
	tag_lootGadgetQ     = [];
	tag_lootClothesQ    = [];
	tag_lootArmorQ      = [];

	tag_lootAll         = [];

	tag_lootTypeRatio   = [];
	tag_spawnProbability = 0;

	/*
	*	Get playerUID from all admins in db
	*/
	_query = format ["getStatusLevel:%1", 2];
	_result = [_query, 2, true] call tiis_fnc_aSync;

	if ((_result select 0 select 0) != "") then {
		{
			tag_adminList = tag_adminList + _x;
		} forEach _result select 0 select 0;

		publicVariable "tag_adminList";

		[["GET_ADMIN_ACCESS: %1",tag_adminList], "DEBUG"] call tiig_fnc_log;
	};

	/*
	*	Get loot table
	*/
	_lootTypes = ["weapon", "attachment", "medical", "gadget", "clothes", "armor"];

	{
		_query = format ["getLootTable:%1", _x];
		_result = [_query, 2, true] call tiis_fnc_aSync;

		if ((_result select 0 select 0) != "") then {

			{
				_lootItem		  = _x select 0;
				_lootType		  = _x select 1;
				_lootQuantity	  = parseNumber(_x select 2);
				_lootAvailability = parseNumber(_x select 3) / 100;

				if (_lootAvailability > 0.0) then {

					switch (_lootType) do {
						case "weapon":     {
							tag_lootWeapons  = tag_lootWeapons + [_lootItem, _lootAvailability];
							tag_lootWeaponsQ = tag_lootWeaponsQ + [[_lootItem, _lootQuantity]];
						};
						case "attachment": { 
							tag_lootAttachment = tag_lootAttachment + [_lootItem, _lootAvailability];
							tag_lootAttachmentQ = tag_lootAttachmentQ + [[_lootItem, _lootQuantity]];
						};
						case "medical":    { 
							tag_lootMedical = tag_lootMedical + [_lootItem, _lootAvailability];
							tag_lootMedicalQ = tag_lootMedicalQ + [[_lootItem, _lootQuantity]];
						};
						case "gadget":     { 
							tag_lootGadget = tag_lootGadget + [_lootItem, _lootAvailability];
							tag_lootGadgetQ = tag_lootGadgetQ + [[_lootItem, _lootQuantity]];
						};
						case "clothes":    { 
							tag_lootClothes = tag_lootClothes + [_lootItem, _lootAvailability];
							tag_lootClothesQ = tag_lootClothesQ + [[_lootItem, _lootQuantity]];
						};
						case "armor":      { 
							tag_lootArmor = tag_lootArmor + [_lootItem, _lootAvailability];
							tag_lootArmorQ = tag_lootArmorQ + [[_lootItem, _lootQuantity]];
						};
					};

					tag_lootAll = tag_lootAll + [_lootItem, _lootAvailability];
				};

			} forEach _result select 0;
		};

	} forEach _lootTypes;

	[["GET_LOOT_WEAPON: %1", tag_lootWeapons], "DEBUG"]		   call tiig_fnc_log;
	[["GET_LOOT_ATTACHMENT: %1", tag_lootAttachment], "DEBUG"] call tiig_fnc_log;
	[["GET_LOOT_MEDICAL: %1", tag_lootMedical], "DEBUG"]	   call tiig_fnc_log;
	[["GET_LOOT_GADGET: %1", tag_lootGadget], "DEBUG"]		   call tiig_fnc_log;
	[["GET_LOOT_CLOTHES: %1", tag_lootClothes], "DEBUG"]	   call tiig_fnc_log;
	[["GET_LOOT_ARMOR: %1", tag_lootArmor], "DEBUG"]		   call tiig_fnc_log;
	[["GET_LOOT_ALL: %1", tag_lootAll], "DEBUG"]			   call tiig_fnc_log;

	/*
	*	Get loot type ratio
	*/
	_query = format ["getLootTypeRatio:%1", 0];
	_result = [_query, 2, true] call tiis_fnc_aSync;

	if ((_result select 0 select 0) != "") then {

		{ 
			if (_x select 0 == "spawnProb") then {
				tag_spawnProbability = parseNumber(_x select 1);
			} else {
				tag_lootTypeRatio = tag_lootTypeRatio + [_x select 0, parseNumber(_x select 1) / 100];
			};

		} forEach _result select 0;
	};

	missionNamespace setVariable ["tag_dataLoaded", true, true]; // Set to true since all data is loaded
};

terminate _thisScript;