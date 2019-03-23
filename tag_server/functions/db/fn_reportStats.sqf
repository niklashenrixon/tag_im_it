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

params [["_unit", objNull], ["_beganAsIT", 0]];
if (isNull _unit) exitWith { ["tiis_fnc_reportStats: cannot be used without providing unit object"] call tiig_fnc_log; };

sleep 5; // Let server recieve data before continuing

_reported = _unit getVariable "tag_unitStatsReported";

if(!_reported) then {

	// Write stats to db on killed / disconnect / game crash

	_uid        = (_unit getVariable "tag_unitIdentity") select 1;
	// Alias
	_name       = (_unit getVariable "tag_unitIdentity") select 4;
	_kills       = _unit getVariable "tag_unitKills";
	_death       = _unit getVariable "tag_unitDeath";
	_win         = _unit getVariable "tag_unitWin";
	_score       = _unit getVariable "tag_unitScore";
	// Nr of Rounds; just +1
	_hs         = _unit getVariable "tag_unitHeadshots";
	_fired      = _unit getVariable "tag_unitShotsFired";
	_hits       = _unit getVariable "tag_unitShotsHit";
	_taken      = _unit getVariable "tag_unitShotsTaken";
	_longHS     = _unit getVariable "tag_unitLongHS";
	_longHSGun   = _unit getVariable "tag_unitLongHSGun";
	_longKill   = _unit getVariable "tag_unitLongKill";
	_longKillGun = _unit getVariable "tag_unitLongKillGun";
	// Status level
	_disco      = _unit getVariable "tag_unitDisconnected";
	_suicide    = _unit getVariable "tag_unitSuicide";
	// Camp Warnings
	// Banned
	// ban reason
	// avatar
	// Online
	// last seen

	_lifespan   = _unit getVariable "tag_unitLifespan";
	_lifespanIT = _unit getVariable "tag_unitLifespanIT";
	if(_unit == (missionNamespace getVariable "tag_firstIt")) then { _beganAsIT = 1; };
	_killer     = _unit getVariable "tag_unitKilledBy";
	_killedbyhs = _unit getVariable "tag_unitKilledByHS";
	_gun        = _unit getVariable "tag_unitKilledWeapon";
	_dist       = _unit getVariable "tag_unitKilledDist";


	_query = format ["UpdateProfileData:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15",
					_kills, _death, _win, _score, _hs, _fired, _hits, _taken, _longHS, _longHSGun, _longKill, _longKillGun, _disco, _suicide, _uid];
	[_query, 1, true] call tiis_fnc_aSync;

	_query = format ["UpdateRoundStats:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:%18:%19",
					tag_roundID, _uid, _kills, _win, _score, _hs, _fired, _hits, _taken, _death, _disco, _suicide, _lifespan, _lifespanIT, _beganAsIT, _killer, _killedbyhs, _gun, _dist];
	[_query, 1, true] call tiis_fnc_aSync;

	[["_name: <%1> | _score: <%2> | _taken: <%3> | _hits: <%4> | _fired: <%5>", _name, _score, _taken, _hits, _fired],"DEEPDEBUG"] call tiig_fnc_log;
	[["_hs: <%6> | _dist: <%7> | _gun: <%8> | _killer: <%9> | _killedbyhs: <%10>", _hs, _dist, _gun, _killer, _killedbyhs],"DEEPDEBUG"] call tiig_fnc_log;
	[["_suicide: <%11> | _disco: <%12> | _lifespan: <%13> | _lifespanIT: <%14> | _longHS: <%15>", _suicide, _disco, _lifespan, _lifespanIT, _longHS],"DEEPDEBUG"] call tiig_fnc_log;
	[["_longKill: <%16> | _longHSGun: <%17> | _longKillGun: <%18> | _kills: <%19>", _longKill, _longHSGun, _longKillGun, _kills],"DEEPDEBUG"] call tiig_fnc_log;

	// Set reported TRUE on unit
	_unit setVariable ["tag_unitStatsReported", true, true];
};

terminate _thisScript;