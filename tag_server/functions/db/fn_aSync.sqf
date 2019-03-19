/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_aSync.sqf
*	@Location: {@mod\addons}\tag_server\functions\db\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Commits an asynchronous call to extDB2
*
*	Example(s):
*		SQL Insert:
*			_query = format["PreConfiguredSQLinEXDBConf:%1:%2", _queryParam1, _queryParam2];
*			[_query, 1, true] call tiis_fnc_aSync;
*	
*		SQL Update:
*			_query = format ["PreConfiguredSQLinEXDBConf:%1:%2", _queryParam1, _queryParam2];
*			[_query, 1, true] call tiis_fnc_aSync;
*	
*		SQL Select:
*			_query = format ["PreConfiguredSQLinEXDBConf:%1", _queryParam1];
*			_result = [_query, 2, true] call tiis_fnc_aSync;
*
*	Parameter(s):
*		[
*		  "STRING" (Query to be ran) ,
*	  	  INTEGER (1 = ASYNC + no return (update/insert), 2 = ASYNC + return for query's) ,
*		  BOOL (False to return a single array, True to return multiple entries mainly for garage)
*		] call tiis_fnc_aSync;
*	Returns:
*		SQL Result or Nothing
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

private["_queryStmt","_queryResult","_key","_mode","_return","_loop"];

if (!params [["_queryStmt", "", [""]], ["_mode", 0, [0]]]) exitWith {};

_key = "extDB2" callExtension format["%1:%2:%3",_mode, (call extDB_SQL_CUSTOM_ID), _queryStmt];
if (_mode isEqualTo 1) exitWith { TRUE };

_key = call compile format["%1",_key];
_key = _key select 1;

sleep (random .03);

_queryResult = "";
_loop = true;
while{_loop} do {
	_queryResult = "extDB2" callExtension format["4:%1", _key];
	if (_queryResult isEqualTo "[5]") then {
		// extDB2 returned that result is Multi-Part Message
		_queryResult = "";
		while{true} do {
			_pipe = "extDB2" callExtension format["5:%1", _key];
			if(_pipe isEqualTo "") exitWith {_loop = false};
			_queryResult = _queryResult + _pipe;
		};
	} else {
		if (_queryResult isEqualTo "[3]") then {
			["EXTDB2 [MySQL]: Sleep [4]", "DEEPDEBUG"] call tiig_fnc_log;
			sleep 0.1;
		} else {
			_loop = false;
		};
	};
};

_queryResult = call compile _queryResult;

// Not needed, its SQF Code incase extDB2 ever returns error message i.e Database Connection Died
if ((_queryResult select 0) isEqualTo 0) exitWith { ["EXTDB2 [MySQL]: Protocol Error: %1", _queryResult] call tiig_fnc_log; [] };
_return = (_queryResult select 1);
_return;