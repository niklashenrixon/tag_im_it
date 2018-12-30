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

tag_roundComplete = false;

/*
*	Initialize database connection : parse settingsfile extdb2_ini.sqf
*/
_initDB = ["tag","SQL_CUSTOM","extdb"] call compile PreprocessFileLineNumbers "\tag_server\scripts\tag_extdb2.sqf";

if (_initDB) then {

	[["EXTDB2 [MySQL]: Initialization successful: %1", _initDB], "DEEPDEBUG"] call tiig_fnc_log;

	tag_sqlLoaded = TRUE;
	publicVariable "tag_sqlLoaded";

	/*
	*	Log server stats
	*/
	0 spawn {
		waitUntil { // Wait for round to start before setting variables
			if (tag_gameInProgress) exitWith {

				_tag_roundID = [32] call tiis_fnc_generatetag_roundID;
				missionNamespace setVariable["tag_roundID", _roundId, TRUE];

				waitUntil {	if (tag_allPlayersIsWest) exitWith { TRUE }; sleep 0.3; };

				// Register all players that has entered the round
				{
					if (side _x != civilian) then {
						_pUID  = getPlayerUID _x;
						_pName = name _x;

						_query = format["InsertPlayerRound:%1:%2:%3", tag_roundID, _pUID, _pName];
						[_query, 1, true] call tiis_fnc_aSync;

						_query = format["InsertPlayerStat:%1:%2", _pUID, _pName];
						[_query, 1, true] call tiis_fnc_aSync;

						_query = format["InsertProfileData:%1:%2", _pUID, _pName];
						[_query, 1, true] call tiis_fnc_aSync;
					};
					sleep 3.5;
				} foreach playableUnits;

				waitUntil { if (tag_roundStarted) exitWith { roundStart	= round(time); TRUE }; sleep 0.2; };

				TRUE
			};
			sleep 2;
		};

		waitUntil { // Wait for round to finish before writing to DB
			if (tag_roundComplete) exitWith {
				roundDuration = round(time - roundStart);

				_query = format["InsertServerStats:%1:%2:%3", tag_roundID, roundDuration, tag_playerCount];
				[_query, 1, true] call tiis_fnc_aSync;
				TRUE
			};
			sleep 2;
		};
	};

	/*
	*	Load statistics eventhandlers
	*/
	#include "\tag_server\scripts\tag_statsEventHandlers.sqf"

	/*
	*	Load UID for camera access and admins
	*/
	#include "\tag_server\scripts\tag_getUIDS.sqf"

} else {
	[["EXTDB2 [MySQL]: Initialization failed: %1", _initDB]] call tiig_fnc_log;
};

["tag_statistics.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;