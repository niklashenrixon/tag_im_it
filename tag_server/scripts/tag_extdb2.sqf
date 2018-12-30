/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ '-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_extdb2.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Initializes extDB, loads Protocol + options if any + Locks extDB
*
*	Parameters:
*		0: STRING Database name as in extdb-conf.ini
*		1: STRING Protocol to enable
*		2: STRING Optional Protocol Options i.e db_conf name for DB_CUSTOM
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

private["_database","_protocol","_protocol_options","_return","_result","_random_number","_extDB_SQL_CUSTOM_ID"];

_database = [_this,0,"",[""]] call BIS_fnc_param;
_protocol = [_this,1,"",[""]] call BIS_fnc_param;
_protocol_options = [_this,2,"",[""]] call BIS_fnc_param;

_return = false;

if ( isNil {uiNamespace getVariable "extDB_SQL_CUSTOM_ID"}) then {

	// extDB Version
	_result = "extDB2" callExtension "9:VERSION";

	if(_result == "") exitWith {
		"EXTDB2 [MySQL]: Failed to load extension" call tiig_fnc_log;
		false
	};

	// extDB Connect to Database
	_result = call compile ("extDB2" callExtension format["9:ADD_DATABASE:%1", _database]);

	if (_result select 0 isEqualTo 0) exitWith {
		[["EXTDB2 [MySQL]: Error Database: %1", _result]] call tiig_fnc_log;
		false
	};

	["EXTDB2 [MySQL]: Connected", "DEEPDEBUG"] call tiig_fnc_log;

	// Generate Randomized Protocol Name
	_random_number = round(random(999999));
	_extDB_SQL_CUSTOM_ID = str(_random_number);
	extDB_SQL_CUSTOM_ID = compileFinal _extDB_SQL_CUSTOM_ID;

	// extDB Load Protocol
	_result = call compile ("extDB2" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4", _database, _protocol, _extDB_SQL_CUSTOM_ID, _protocol_options]);
	
	if ((_result select 0) isEqualTo 0) exitWith {
		[["EXTDB2 [MySQL]: Error Database Setup: %1", _result]] call tiig_fnc_log;
		false
	};

	[["EXTDB2 [MySQL]: Initalized %1 Protocol", _protocol],"DEEPDEBUG"] call tiig_fnc_log;

	// extDB2 Lock
	"extDB2" callExtension "9:LOCK";

	["EXTDB2 [MySQL]: Locked", "DEEPDEBUG"] call tiig_fnc_log;

	// Save Randomized ID
	uiNamespace setVariable ["extDB_SQL_CUSTOM_ID", _extDB_SQL_CUSTOM_ID];
	_return = true;
	
} else {
	extDB_SQL_CUSTOM_ID = compileFinal str(uiNamespace getVariable "extDB_SQL_CUSTOM_ID");

	["EXTDB2 [MySQL]: Already setup (skipping initalization)", "DEEPDEBUG"] call tiig_fnc_log;

	_return = true;
};

_return