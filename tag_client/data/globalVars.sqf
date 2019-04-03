/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: globalVars.sqf
*	@Location: {@mod\addons}\tag_client\data\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Global variables, accessable too both server and client
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

// General
tag_worldName = worldName;                                               // Name of loaded map
tag_debugMode = getMissionConfigValue ["tag_c_debugmode", 0];            // Debugmode | Default: <NUMBER> 0
tag_cmdPass   = getMissionConfigValue ["tag_c_cmdPassword", "password"]; // Get password to use for servercommands | Default: <STRING> "password"

// Game settings
tag_minPlayersToStart  = getMissionConfigValue ["tag_c_minPlayers", 4];  // Minimum number of players | Default: <NUMBER> 4
tag_maxPlayers 		   = getMissionConfigValue ["tag_c_maxPlayers", 32]; // Maximum number of players | Default: <NUMBER> 32

// Score
TAG_SCORE_BASE  = getMissionConfigValue ["tag_c_base_score", 100];  // Base score for 1 kill | Default: <NUMBER> 100
TAG_SCORE_HS    = getMissionConfigValue ["tag_c_hs_score", 250];    // Headshot score per headshot | Default: <NUMBER> 250
TAG_SCORE_FIRST = getMissionConfigValue ["tag_c_first_score", 500]; // Score if players won and was the first IT | Default: <NUMBER> 500
TAG_DISTBONUS   = getMissionConfigValue ["tag_c_distbonus", 50];    // How many meters before giving distance bonus on kill | Default: <NUMBER> 50

// 1 vs 1
TAG_DANGERSOUND = getMissionConfigValue ["tag_c_sounddist", 50];    // How near the last 2 players have to be eachother for danger sound to start playing | Default: <NUMBER> 50

// Circle settings
TAG_CIRCLE_MIN = 100;  // Minimum size of circle

// Colors
TAG_COLOR_RED = "#ff0000"; // Bright red
