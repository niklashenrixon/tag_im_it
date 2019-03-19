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