/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_reportStats.sqf
*	@Location: {@mod\addons}\tag_server\functions\db\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Report player stats to db
*
*	Example(s):
*		[_unit] spawn tiis_fnc_reportStats;
*
*	Parameter(s):
*		0 <OBJECT> (Mandatory):
*			Unit object
*
*	Returns:
*		BOOLEAN - True or false if successfull
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_unit", objNull]];
if (isNull _unit) exitWith { ["tiis_fnc_reportStats: cannot be used without providing unit object"] call tiig_fnc_log; };

sleep 5; // Let server recieve data before continuing

_reported = _unit getVariable "tag_unitStatsReported";

if(!_reported) then {

	// Write stats to db on killed / disconnect / game crash
	_name       = (_unit getVariable "tag_unitIdentity") select 4;
	_score      = _unit getVariable "tag_unitScore";
	_taken      = _unit getVariable "tag_unitShotsTaken";
	_hits       = _unit getVariable "tag_unitShotsHit";
	_fired      = _unit getVariable "tag_unitShotsFired";
	_hs         = _unit getVariable "tag_unitHeadshots";
	_dist       = _unit getVariable "tag_unitKilledDist";
	_gun        = _unit getVariable "tag_unitKilledWeapon";
	_killer     = _unit getVariable "tag_unitKilledBy";
	_killedbyhs = _unit getVariable "tag_unitKilledByHS";
	_suicide    = _unit getVariable "tag_unitSuicide";
	_disco      = _unit getVariable "tag_unitDisconnected";
	_lifespan   = _unit getVariable "tag_unitLifespan";
	_lifespanIT = _unit getVariable "tag_unitLifespanIT";

	// _query = format ["UpdateScore:%1:%2:%3", _score, tag_roundID, getPlayerUID _unit];
	// [_query, 1, true] call tiis_fnc_aSync;

	[["_name: <%1> | _score: <%2> | _taken: <%3> | _hits: <%4> | _fired: <%5> | _hs: <%6> | _dist: <%7> | _gun: <%8> | _killer: <%9> | _killedbyhs: <%10> | _suicide: <%11> | _disco: <%12> | _lifespan: <%13> | _lifespanIT: <%14>", _name, _score, _taken, _hits, _fired, _hs, _dist, _gun, _killer, _killedbyhs, _suicide, _disco, _lifespan, _lifespanIT],"DEEPDEBUG"] call tiig_fnc_log;

	// Set reported TRUE on unit
	_unit setVariable ["tag_unitStatsReported", true, true];
};

terminate _thisScript;