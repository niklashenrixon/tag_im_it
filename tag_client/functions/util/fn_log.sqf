/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_log.sqf
*	@Location: \{root}\functions\util\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Logger with option to categorize data in different levels.
*		* The levels are defined when calling the function. And the global
*		  debug level are set in the settings file.
*         If global level is 3 (info) all your log messages will be shown
*
*	Example(s):
*		"Error message" call tag_fn_log;
*			OUTPUT: "- TAG IM IT [ERROR], T (13s) : Error message"
*
*		["Error message"] call tag_fn_log;
*			OUTPUT: "- TAG IM IT [ERROR], T (13s) : Error message"
*
*		["Error message", "ERROR"] call tag_fn_log;
*			OUTPUT: "- TAG IM IT [ERROR], T (14s) : Error message"
*
*		[["ERROR message with value %1", _value]] call tag_fn_log;
*			OUTPUT: "- TAG IM IT [ERROR], T (153s) : ERROR message with value _value"
*
*		[["INFO message with value %1", _value], "DEEPDEBUG"] call tag_fn_log;
*			OUTPUT: "- TAG IM IT [DEEPDEBUG], T (68s) : INFO message with value _value"
*
*		["Warning message", "DEBUG"] call tag_fn_log;
*			OUTPUT: "- TAG IM IT [DEBUG], T (14s) : Warning message"
*
*	Parameter(s):
*		0 DATA (Mandatory):
*			Alt 1. STRING in format "Message without value"
*			Alt 2. ARRAY in format ["Message without value"]
*			Alt 3. ARRAY in format [["Message with value %1", _value]]
*
*		1 DEBUG LEVEL (Optional):
*			STRING - Enter the level of logging. (default: "ERROR")
*				Available Levels:
*					ERROR     - Log message with this level will always be displayed
*					DEBUG     - Use this for more detailed info
*					DEEPDEBUG - Use this for even more detailed info
*		
*	Returns:
*		Logged message in RPT log file AND true
*
*/
params [
	["_data", "tiig_fnc_log called without data!", [[],""]],
	["_opt1", "ERROR", [""]],
	["_opt2", "RPT", [""]],
	["_debugLevel", 0, 0],
	["_output", [], []]
];

switch (toUpper(_opt1)) do {
	case "DEBUG": { _debugLevel = 1; };
	case "DEEPDEBUG": { _debugLevel = 2; };
	default { _debugLevel = 0; };
};

if (tag_debugMode >= _debugLevel) then {

	if (_data isEqualType []) then {

		_fm = format ["- TAG IM IT [%1], T (%2s) : %3", toUpper(_opt1), diag_tickTime, _data # 0];
		_data deleteAt 0; // Remove original message
		_output pushBack _fm;

		for "_i" from 0 to (count _data)-1 do {
			_sV = _data # _i;
			_output pushBack _sV;
		};

		switch (toUpper(_opt2)) do {
			case "HINT": { format _output remoteExec ["hint", -2]; };
			case "CHAT": { format _output remoteExec ["systemChat", -2]; };
			case "RH": { diag_log format _output; format _output remoteExec ["hint", -2]; };
			default { diag_log format _output; };
		};

	} else { // Single message

		switch (toUpper(_opt2)) do {
			case "HINT": { _data remoteExec ["hint", -2]; };
			case "CHAT": { _data remoteExec ["systemChat", -2]; };
			case "RH": { diag_log format ["- TAG IM IT [%1], T (%2s) : %3", toUpper(_opt1), diag_tickTime, _data]; _data remoteExec ["hint", -2]; };
			default { diag_log format ["- TAG IM IT [%1], T (%2s) : %3", toUpper(_opt1), diag_tickTime, _data]; };
		};
	};
};