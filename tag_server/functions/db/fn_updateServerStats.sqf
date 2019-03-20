/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_updateServerStats.sqf
*	@Location: {@mod\addons}\tag_server\functions\db\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Insert new round to server statistics in DB
*
*	Example(s):
*		_ok = [_roundID, _duration, true] call tiis_fnc_updateServerStats;
*
*	Parameter(s):
*		0 <STRING> (Mandatory):
*			ID of round beeing started
*
*		0 <NUMBER> (Mandatory):
*			Duration of round
*
*		1 <BOOLEAN> (Optional):
*			TRUE - Enable LOG
*			FALSE - Disable LOG (Default)
*
*	Returns:
*		<BOOLEAN> - TRUE if successfull, FALSE if not
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_rID", ""], ["_duration", 0], ["_log", false], ["_return", false]];

if(!tag_dbConn) exitWith { ["tiis_fnc_updateServerStats: No connection to database"] call tiig_fnc_log; _return };
if(_rID == "") exitWith { ["tiis_fnc_updateServerStats: provide ID of current round!"] call tiig_fnc_log; _return };
if(_duration == 0) exitWith { ["tiis_fnc_updateServerStats: a round cannot be 0 seconds long"] call tiig_fnc_log; _return };

_q = format["UpdateServerStats:%1:%2", _duration, _rID];
[_q, 1, true] call tiis_fnc_aSync;

_return = true;
if(_log) then { [["tiis_fnc_updateServerStats: Server statistics has been updated"], "DEEPDEBUG"] call tiig_fnc_log; };

_return