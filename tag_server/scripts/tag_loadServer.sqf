/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_loadServer.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Load server-side
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

// Load Weather
0 spawn tiig_fnc_dynWeather;

// Compile server-side functions
call compile preprocessFile "\tag_server\functions\tag_serverFunctions.sqf";

// Load statistics module
call compile preprocessFileLineNumbers "\tag_server\scripts\tag_statistics.sqf";

// Starts
0 spawn tag_fn_messageSystem;

// Fuck off fog
0 setFog 0;
forceWeatherChange;
999999 setFog 0;

// Load firing range
0 execVM "\tag_server\scripts\tag_firingRange.sqf";

// Load eventhandlers
#include "\tag_server\scripts\tag_eventHandlers.sqf"

// Load the round
0 execVM "\tag_server\functions\tag_fn_loadMatch.sqf";

// Index loot location on loaded map
//["tag_indexLoot", FALSE] call tag_fn_getLootPos;

// Start player count watchdog
_watchdog = addMissionEventHandler ["EachFrame", {
	tag_playerCount = {side _x != civilian} count playableUnits;
}];

["tag_loadServer.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;