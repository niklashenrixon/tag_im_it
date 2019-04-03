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

// Game settings
tag_minPlayersToStart  = 4;         // Minimum number of players
tag_maxPlayers 		   = 32;        // Maximum number of players
tag_worldName 		   = worldName; // Name of loaded map
tag_debugMode          = getMissionConfigValue ["tag_c_debugmode", 0]; // Debugmode 
tag_cmdPass            = getMissionConfigValue ["tag_c_cmdPassword", "password"]; // Get password to use for servercommands

// Score
TAG_SCORE_BASE = 100;  // Base score for 1 kill
TAG_SCORE_HS = 200;    // Headshot score per headshot
TAG_SCORE_FIRST = 500; // Score if players won and was the first IT

// Circle settings
TAG_CIRCLE_MIN = 100;  // Minimum size of circle

// Colors
TAG_COLOR_RED = "#d9534f"; // Red from TAG logo
