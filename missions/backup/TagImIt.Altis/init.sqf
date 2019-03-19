/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ '-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: init.sqf
*	@Location: {missionFolder}\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Initialization of the mod
*
*	3rd party:
*		@Files / Functions
*			mapSwitchTextures.sqf
*			tag_fn_cameraSystem.sqf
*			real_weather.sqf
*			player_markers.sqf
*			tag_vaultAnimation.sqf
*
*		@Author:
*			mapSwitchTextures.sqf = DnA (http://steamcommunity.com/id/dna_uk)
*			tag_fn_cameraSystem.sqf = Bohemia Interactive Studio
*			real_weather.sqf = code34 nicolas_boiteux@yahoo.fr
*			player_markers.sqf = aeroson
*			tag_vaultAnimation.sqf = ProGamer (http://www.armaholic.com/page.php?id=24323)
*
*		@Description:
*			mapSwitchTextures.sqf = Removes Satellite Image from Map (Breifing)
*			tag_fn_cameraSystem.sqf = Original debug camera
*			real_weather.sqf = Dynamic Weather System
*			player_markers.sqf = Show map markers for unit on same side
*			tag_vaultAnimation.sqf = Running Vault Mod
*
*		@Usage : 
*			mapSwitchTextures.sqf = call compile preprocessFileLineNumbers "\path\to\mapSwitchTextures.sqf";
*			tag_fn_cameraSystem.sqf = _cameraSystem = compile preprocessFileLineNumbers "\path\to\tag_fn_cameraSystem.sqf";
*			real_weather.sqf = [] execVM "\path\to\real_weather.sqf";
*			player_markers.sqf = [] execVM "\path\to\player_markers.sqf";
*			tag_vaultAnimation.sqf = [] execVM "\path\to\tag_vaultAnimation.sqf";
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

diag_log "/////////////////////////////////////////////////////////////////////////////////////////////////////////";
diag_log "                 ______   ______     ______        __     __    __        __     ______                  ";
diag_log "                /\__  _\ /\  __ \   /\  ___\      /\ \   /\ '-./  \      /\ \   /\__  _\                 ";
diag_log "                \/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/                 ";
diag_log "                   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\                 ";
diag_log "                    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/                 ";
diag_log "                                                                                                         ";
diag_log "                        --------------------  A Mod by NIXON  --------------------                       ";
diag_log "                                                                                                         ";
diag_log "/////////////////////////////////////////////////////////////////////////////////////////////////////////";

/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*
*	GLOBAL CODE
*	
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

tag_minPlayersToStart  = getNumber (missionConfigFile >> "TagImItSettings" >> "playerSettings" >> "minPlayersToStart");
tag_debugMode 		   = getNumber (missionConfigFile >> "TagImItSettings" >> "developmentSettings" >> "debugMode");
tag_maxPlayers 		   = getNumber (missionConfigFile >> "Header" >> "maxPlayers");

tag_allPlayersIsWest = FALSE;
tag_roundStarted	 = FALSE;
tag_roundIsDraw		 = FALSE;
tag_roundComplete    = FALSE;
alreadyFired		 = FALSE;
tag_worldName 		 = worldName;

// Set friendlys
west setFriend [east, 0];
west setFriend [west, 1];

// Disable ability to save in-game
enableSaving [FALSE, FALSE];

// Compile global functions
call compile preprocessFile "\tag_client\functions\tag_globalFunctions.sqf";

// Compile game variables
0 spawn { call compile preProcessFileLineNumbers "\tag_client\data\tag_variables.sqf" };

// Load Weather
0 execVM "\tag_client\functions\real_weather.sqf";

/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*
*	SERVER SIDE CODE
*	
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

if (isDedicated) then {

	// Load server
	call compile preprocessFile "\tag_server\scripts\tag_loadServer.sqf";

};

/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*
*	CLIENT SIDE CODE
*	
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

if (!isDedicated) then {

	// Load client
	call compile preprocessFile "\tag_client\scripts\tag_loadClient.sqf";

};