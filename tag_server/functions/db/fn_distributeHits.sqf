/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_distributeHits.sqf
*	@Location: {@mod\addons}\tag_server\functions\db\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		When called, shots taken is logged to statistics for each player
*
*	Example(s):
*		[_hitArray(array), _logMessage(string)] call tiis_fnc_distributeHits;
*
*	Parameter(s):
*		0 NUMBER (Mandatory):
*			Length of the round id that you want to be generated
*
*	Returns:
*		id(string)
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_hitArray",[]],["_logMessage",""]];
//if (_length == 0) exitWith { ["tiis_fnc_generateRoundId: cannot be used without providing a number"] call tiig_fnc_log; };

for "_i" from 1 to ((count _hitArray) / 2) do {
	_unitHitID = _hitArray select 0;
	_hitArray deleteAt 0;
	_hits = _hitArray select 0;
	_hitArray deleteAt 0;

	[[_logMessage + " Hits deploy | Hit/s: %1 | PUID: %2", _hits, _unitHitID], "DEBUG"] call tiig_fnc_log;

	_query = format [
		"UpdateTotalStatShotsHit:%1:%2",
		_hits,
		_unitHitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	_query = format [
		"UpdatePlayerRoundStatShotsHit:%1:%2:%3",
		_hits,
		roundId,
		_unitHitID
	]; [_query, 1, true] call tiis_fnc_aSync;
};