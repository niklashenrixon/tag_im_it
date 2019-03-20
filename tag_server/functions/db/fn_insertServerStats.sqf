/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_insertServerStats.sqf
*	@Location: {@mod\addons}\tag_server\functions\db\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Insert new round to server statistics in DB
*
*	Example(s):
*		_ok = [_roundID, _playerCount, true] call tiis_fnc_insertServerStats;
*
*	Parameter(s):
*		0 <STRING> (Mandatory):
*			ID of round beeing started
*
*		0 <NUMBER> (Mandatory):
*			Player count
*
*		1 <BOOLEAN> (Optional):
*			TRUE - Enable LOG
*			FALSE - Disable LOG (Default)
*
*	Returns:
*		<BOOLEAN> - TRUE if successfull, FALSE if not
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_rID", ""], ["_pCount", 0], ["_log", false], ["_return", false]];

if(!tag_dbConn) exitWith { ["tiis_fnc_insertServerStats: No connection to database"] call tiig_fnc_log; _return };
if(_rID == "") exitWith { ["tiis_fnc_insertServerStats: provide ID of current round!"] call tiig_fnc_log; _return };
if(_pCount == 0) exitWith { ["tiis_fnc_insertServerStats: player count of 0 cannot be added"] call tiig_fnc_log; _return };

_q = format["InsertServerStats:%1:%2", _rID, _pCount];
[_q, 1, true] call tiis_fnc_aSync;

_return = true;
if(_log) then { [["tiis_fnc_insertServerStats: Server statistics has been written to DB"], "DEEPDEBUG"] call tiig_fnc_log; };

_return