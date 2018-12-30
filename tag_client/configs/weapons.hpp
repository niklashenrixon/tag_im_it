class cfgWeapons {

	class ItemCore;
	class ItemInfo;
	class UniformItem;
	class HeadgearItem;

	class H_Cap_red;
	class U_C_Poor_1;
	class U_C_WorkerCoveralls;

	// Base class
	class TAG_U_BASE : U_C_WorkerCoveralls {
		author = "NIXON";
		scope = 0;														// Only used as an inherit class (private)
		hiddenSelections[] = {"camo"};
	};

	// Uber Admin NIXON clothing
	class TAG_U_NIXON : U_C_Poor_1 {
		author = "NIXON";
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		displayName = "NIXON Costume";                                   // Uniform name in game
		picture = "\tag_client\objects\ui\nixon_ui.paa";                 // Uniform image in inventory
		hiddenSelections[] = {"camo"};                                   // What texture to replace
		hiddenSelectionsTextures[] = {"\tag_client\objects\nixon.paa"};  // Uniform texture

		class ItemInfo : UniformItem {
			uniformModel = "-";                                            // Dunno
			uniformClass = "TAG_C_NIXON";                              // Use equivelent character from cfgVehicles
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// Default clothing
	class TAG_U_DEFAULT : TAG_U_BASE {
		displayName = "Default Costume";                                    // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\default_ui.paa";                // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\default.paa"}; // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_DEFAULT";                      // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// Han Yolo clothing
	class TAG_U_HAN : TAG_U_BASE {
		displayName = "Han Yolo Costume";                                   // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\han_ui.paa";                    // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\hanyolo.paa"}; // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_HAN";                           // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// P-Vakt clothing
	class TAG_U_PVAKT : TAG_U_BASE {
		displayName = "P-Vakt Costume";                                     // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\pvakt_ui.paa";                  // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\cberry.paa"};  // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_PVAKT";                        // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// Crash Test Dummy clothing
	class TAG_U_DUMMY : TAG_U_BASE {
		displayName = "Crash Test Dummy Costume";                           // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\dummy_ui.paa";                  // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\dummy.paa"};   // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_DUMMY";                         // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// TAG Man clothing
	class TAG_U_HERO : TAG_U_BASE {
		displayName = "TAGMAN Costume";                                    // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\hero_ui.paa";                   // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\hero.paa"};    // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_HERO";                          // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// I'm with stupid clothing
	class TAG_U_STUPID : TAG_U_BASE {
		displayName = "I'm with stupid Costume";                            // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\stupid_ui.paa";                 // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\stupid.paa"};  // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_STUPID";                        // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// Supporter clothing
	class TAG_U_SUPPORT : TAG_U_BASE {
		displayName = "Supporter Costume";                                  // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\supporter_ui.paa";                  // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\supporter.paa"};   // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_SUPPORT";                           // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// Target clothing
	class TAG_U_TARGET : TAG_U_BASE {
		displayName = "Target Costume";                                  // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\target_ui.paa";                     // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\target.paa"};      // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_TARGET";                            // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// Girltummy clothing
	class TAG_U_TUMMY : TAG_U_BASE {
		displayName = "Girltummy Costume";                                      // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\target_ui.paa";                     // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\tummy.paa"};       // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_TUMMY";                             // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// V.I.P clothing
	class TAG_U_VIP : TAG_U_BASE {
		displayName = "VIP Costume";                                      // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\vip_ui.paa";                        // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\vip.paa"};         // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_VIP";                               // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

	// Slav clothing
	class TAG_U_SLAV : TAG_U_BASE {
		displayName = "Slav Bling";                                      // Uniform name in game
		scope = 2;															// Any classes declared public are CamCreateabale, and selectable via the Editor. (public)
		picture = "\tag_client\objects\ui\slav_ui.paa";                        // Uniform image in inventory
		hiddenSelectionsTextures[] = {"\tag_client\objects\slav.paa"};         // Uniform texture

		class ItemInfo : UniformItem {
			uniformClass = "TAG_C_SLAV";                               // Use equivelent character from cfgVehicles
			uniformModel = "-";                                            // Dunno
			containerClass = Supply400;                                    // How much it can carry
			mass = 10;                                                     // How much it weights
		};
	};

 	// TAG HELMET
	class TagHelmet : ItemCore {
		author = "NIXON";
		weaponPoolAvailable = 1;
		displayName = "Helmet for special people";
		picture = "\tag_client\objects\ui\tag_helmet_ui.paa";
		model = "\A3\Characters_F\BLUFOR\headgear_b_helmet_plain";
		hiddenSelections[] = {"camo"};
		hiddenSelectionsTextures[] = {"\tag_client\objects\headgear\taghelmet.paa"};
		scope = 2;

		class ItemInfo : HeadgearItem {
			mass = 1;
			uniformModel = "\A3\Characters_F\BLUFOR\headgear_b_helmet_plain";
			modelSides[] = {3,1};
			hiddenSelections[] = {"camo"};
			author = "NIXON";
			_generalMacro = "HeadgearItem";
			allowedSlots[] = {901,605};
			type = 605;
			scope = 2;
		};
	};

	// NIXON CAP
	class NIXON_CAP : H_Cap_red {
		author = "NIXON";
		_generalMacro = "NIXON_CAP";
		displayName = "NIXON's Lucky Cap";
		picture = "\tag_client\objects\ui\nixon_cap_ui.paa"; // In game UI picture
		model = "\A3\Characters_F\common\capb";            // CAP model
		hiddenSelections[] = {"camo"};
		hiddenSelectionsTextures[] = {"\tag_client\objects\headgear\nixon_cap.paa"};  // CAP texture
		scope = 2;

		class ItemInfo : ItemInfo {
			mass = 4;
			uniformModel = "\A3\Characters_F\common\capb.p3d";
			allowedSlots[] = {801,901,701,605};
			modelSides[] = {6};
			hiddenSelections[] = {"camo"};
			author = "NIXON";
			scope = 2;
			_generalMacro = "HeadgearItem";
		};
	};
};