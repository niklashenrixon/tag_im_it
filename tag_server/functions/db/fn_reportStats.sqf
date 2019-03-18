/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_reportStats.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Report player stats to db
*
*	Example(s):
*		_handle = [_unit] spawn tiis_fnc_reportStats;
*		terminate _handle;
*
*	Parameter(s):
*		0 OBJECT (Mandatory):
*			Unit object to report for
*
*	Returns:
*		BOOLEAN - True or false if successfull
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_unit",objNull]];
if (isNull _unit) exitWith { ["tiis_fnc_reportStats: cannot be used without a provided unit object"] call tiig_fnc_log; };

sleep 5; // Let server recieve data before continuing

_reported = _unit getVariable "tag_unitStatsReported";

if(!_reported) then {

	// Write stats to db on killed / disconnect / game crash
	_score   = _unit getVariable "tag_unitScore";
	_taken   = _unit getVariable "tag_unitShotsTaken";
	_hits    = _unit getVariable "tag_unitShotsHit";
	_fired   = _unit getVariable "tag_unitShotsFired";
	_hs      = _unit getVariable "tag_unitHeadshots";
	_dist    = _unit getVariable "tag_unitKilledDist";
	_gun     = _unit getVariable "tag_unitKilledWeapon";
	_killer  = _unit getVariable "tag_unitKilledBy";
	_suicide = _unit getVariable "tag_unitSuicide";
	_disco   = _unit getVariable "tag_unitDisconnected";

	// _query = format ["UpdateScore:%1:%2:%3", _score, tag_roundID, getPlayerUID _unit];
	// [_query, 1, true] call tiis_fnc_aSync;

	[["_taken: %1 | _hits: %2 | _fired: %3 | _hs: %4 | _dist: %5 | _gun: %6 | _killer: %7 | _suicide: %8 | _disco: %9 | _score: %10", _taken, _hits, _fired, _hs, _dist, _gun, _killer, _suicide, _disco, _score],"DEEPDEBUG"] call tiig_fnc_log;

	// Set reported TRUE on unit
	_unit setVariable ["tag_unitStatsReported", true, true];
};

terminate _thisScript;