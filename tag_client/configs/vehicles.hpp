class CfgVehicles {

	class C_man_w_worker_F;
	class C_man_p_fugitive_F;

	// Base class
	class TAG_C_BASE : C_man_w_worker_F {
		author = "NIXON";
		scope = 0;									// Only used as an inherit class (private)
		hiddenSelections[] = {"Camo"};
		weapons[] = {Throw, Put};                   // Which weapons the character has.
		respawnWeapons[] = {Throw, Put};            // Which weapons the character respawns with.
		Items[] = {};                               // Which items the character has.
		RespawnItems[] = {};                        // Which items the character respawns with.
		linkedItems[] = {ItemGPS};		            // Which items the character has.
		respawnLinkedItems[] = {ItemGPS};		    // Which items the character respawns with.
		class EventHandlers { init = ""; };
	};

	// Uber Admin NIXON character
	class TAG_C_NIXON : C_man_p_fugitive_F {
		author = "NIXON";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		_generalMacro = "TAG_C_NIXON";
		displayName = "NIXON";            									// The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_NIXON";             							// This links this soldier to a particular uniform.
		hiddenSelections[] = {"Camo"};              						// List of model selections which can be changed with hiddenSelectionTextures[] and hiddenSelectionMaterials[] properties. If empty, model textures are used.
		hiddenSelectionsTextures[] = {"\tag_client\objects\nixon.paa"};		// The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\nixon_preview.jpg"; // Image used in the editor preview of the character
		headgearList[] = {"NIXON_CAP",0.25,"",1};
		//headgearList[] = {"NIXON_CAP",0.25,"H_Cap_tan",0.25,"H_Cap_blk",0.25,"H_Cap_blk_CMMG",0.25,"H_Cap_brn_SPECOPS",0.25,"H_Cap_tan_specops_US",0.25,"H_Cap_khaki_specops_UK",0.25,"H_Cap_red",0.25,"H_Cap_grn",0.25,"H_Cap_blu",0.25,"H_Cap_grn_BI",0.25,"H_Cap_blk_Raven",0.25,"H_Cap_blk_ION",0.25,"H_Bandanna_khk",0.25,"H_Bandanna_sgg",0.25,"H_Bandanna_cbr",0.25,"H_Bandanna_gry",0.25,"H_Bandanna_camo",0.25,"H_Bandanna_mcamo",0.25,"H_Bandanna_surfer",0.25,"H_Beret_blk",0.25,"H_Beret_red",0.25,"H_Beret_grn",0.25,"H_TurbanO_blk",0.25,"H_StrawHat",0.25,"H_StrawHat_dark",0.25,"H_Hat_blue",0.25,"H_Hat_brown",0.25,"H_Hat_camo",0.25,"H_Hat_grey",0.25,"H_Hat_checker",0.25,"H_Hat_tan",0.25,"",1};
		weapons[] = {Throw, Put};                     // Which weapons the character has.
		respawnWeapons[] = {Throw, Put};              // Which weapons the character respawns with.
		Items[] = {};                        		  // Which items the character has. (GÖR OM TILL EN EGEN KEPS)
		RespawnItems[] = {NIXON_CAP};                 // Which items the character respawns with.
		linkedItems[] = {NIXON_CAP, ItemGPS};		  // Which items the character has.
		respawnLinkedItems[] = {NIXON_CAP, ItemGPS};  // Which items the character respawns with.
		class EventHandlers { init = ""; };
	};

	// Default character
	class TAG_C_DEFAULT : TAG_C_BASE {
		_generalMacro = "TAG_C_DEFAULT";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "TAG PLAYER";            							// The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_DEFAULT";             							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\default.paa"};		// The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\default_preview.jpg"; // Image used in the editor preview of the character
	};

	// Han Yolo character
	class TAG_C_HAN : TAG_C_BASE {
		_generalMacro = "TAG_C_HAN";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "Han Yolo";                   							// The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_HAN";                 							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\hanyolo.paa"};		// The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\han_preview.jpg"; // Image used in the editor preview of the character
	};

	// P-Vakt character
	class TAG_C_PVAKT : TAG_C_BASE {
		_generalMacro = "TAG_C_PVAKT";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "P-Vakten";                    							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_PVAKT";               							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\cberry.paa"};		 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\pvakt_preview.jpg";  // Image used in the editor preview of the character
	};

	// Crash Test Dummy character
	class TAG_C_DUMMY : TAG_C_BASE {
		_generalMacro = "TAG_C_DUMMY";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "Crash Test Dummy";           							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_DUMMY";               							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\dummy.paa"};		 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\dummy_preview.jpg";  // Image used in the editor preview of the character
	};

	// TAG Man character
	class TAG_C_HERO : TAG_C_BASE {
		_generalMacro = "TAG_C_HERO";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "TAGMAN";                    							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_HERO";                							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\hero.paa"};		 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\hero_preview.jpg";  // Image used in the editor preview of the character
	};

	// I'm with stupid character
	class TAG_C_STUPID : TAG_C_BASE {
		_generalMacro = "TAG_C_STUPID";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "I'm with stupid";            							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_STUPID";              							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\stupid.paa"};		 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\stupid_preview.jpg";  // Image used in the editor preview of the character
	};

	// Supporter character
	class TAG_C_SUPPORT : TAG_C_BASE {
		_generalMacro = "TAG_C_SUPPORT";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "Supporter";              							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_SUPPORT";             							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\supporter.paa"};		 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\supporter_preview.jpg";  // Image used in the editor preview of the character
	};

	// Target character
	class TAG_C_TARGET : TAG_C_BASE {
		_generalMacro = "TAG_C_TARGET";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "Target";              							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_TARGET";              							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\target.paa"};		 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\target_preview.jpg";  // Image used in the editor preview of the character
	};

	// Girltummy character
	class TAG_C_TUMMY : TAG_C_BASE {
		_generalMacro = "TAG_C_TUMMY";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "Girltummy";                  							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_TUMMY";               							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\tummy.paa"};		 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\target_preview.jpg";  // Image used in the editor preview of the character
	};

	// V.I.P character
	class TAG_C_VIP : TAG_C_BASE {
		_generalMacro = "TAG_C_VIP";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "VIP";                  							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_VIP";                 							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\vip.paa"};		 	 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\vip_preview.jpg";  // Image used in the editor preview of the character
	};

	// Slav character
	class TAG_C_SLAV : TAG_C_BASE {
		_generalMacro = "TAG_C_SLAV";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "Slav";                  							 // The name of the soldier, which is displayed in the editor.
		uniformClass = "TAG_U_SLAV";                 							// This links this soldier to a particular uniform.
		hiddenSelectionsTextures[] = {"\tag_client\objects\slav.paa"};		 	 // The textures for the selections defined above. If empty, no texture is used.
		editorPreview = "\tag_client\objects\3denpreview\slav_preview.jpg";  // Image used in the editor preview of the character
	};
};