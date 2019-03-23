/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ '-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_statistics.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Statistics module, logs everything to database
*
*	3rd party:
*		@Files / Functions
*			extension: extdb2
*		@Author:
*			extension/functions of extdb2 = Torndeco
*		@Description:
*			extension that enables database reading/writing
*		@Usage : 
*			See - https://github.com/Torndeco/extDB2
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////


if (tag_dbConn) then {


				// Register all players that has entered the round
				{
					if (side _x != civilian) then {
						_pUID  = getPlayerUID _x;
						_pName = name _x;

						_query = format["InsertPlayerRound:%1:%2:%3", tag_roundID, _pUID, _pName];
						[_query, 1, true] call tiis_fnc_aSync;

						_query = format["InsertPlayerStat:%1:%2", _pUID, _pName];
						[_query, 1, true] call tiis_fnc_aSync;


					};
					sleep 3.5;
				} foreach playableUnits;



	/*
	*	Load statistics eventhandlers
	*/
	#include "\tag_server\scripts\tag_statsEventHandlers.sqf"
};

["tag_statistics.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;