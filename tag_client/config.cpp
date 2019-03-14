class CfgPatches {
	class tag_client {
		author = "NIXON";
		name = "Client";
		units[] = {};
		version = 1.0;
		authors[] = {"NIXON"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Characters_F","A3_Weapons_F"};
	};
};

class CfgMods {
	class tagimit {
		name = "TAG I'M IT";
		nameShort = "TAG";
		dir = "@TAG I'M IT";
		picture = "\tag_client\images\logo_big_dark.paa";
		author = "NIXON";
		hidePicture = "FALSE";
		hideName = "FALSE";

		logo = "\A3\Data_F_Argo\Logos\arma3_argo_logo_ca.paa";
		logoOver = "\A3\Data_F_Argo\Logos\arma3_argo_logoOver_ca.paa";
		logoSmall = "\A3\Data_F_Argo\Logos\arma3_argo_logo_small_ca.paa";
		tooltip = "";
		tooltipOwned = "Arma 3 Malden";
		action = "http://tagimit.eu";
		dlcColor[] = {0.760784,0.698039,0.501961,1};
		overview = "Everyone is invited to celebrate the 16th Armaversary on a modern re-imagination of the classic Malden terrain. Dive into the authentic and dynamic Combat Patrol multiplayer mode and complete tactical objectives on all vanilla terrains. This DLC is free for all players as token of appreciation to the best community in the world.";
		logoTitle = "\A3\Data_F_Argo\Logos\arma3_argo_logoTitle_ca.paa";
	};
};

// Configs
#include "\tag_client\configs\functions.hpp"
#include "\tag_client\configs\weapons.hpp"
#include "\tag_client\configs\vehicles.hpp"
#include "\tag_client\configs\faces.hpp"
#include "\tag_client\configs\identities.hpp"
#include "\tag_client\configs\heads.hpp"
#include "\tag_client\configs\uniforms.hpp"
#include "\tag_client\configs\commands.hpp"

// UI
#include "\tag_client\ui\tagDefines.hpp"
#include "\tag_client\ui\dialogs.hpp"
#include "\tag_client\ui\onTheFlyDialogs.hpp"