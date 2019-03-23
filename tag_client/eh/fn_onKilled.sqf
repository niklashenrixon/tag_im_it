/*
*	@Name: onKilled (MP)
*
*	@Description:
*		Triggered when the unit is killed. EH can be added on any machine and EH code will trigger globally on every connected client and server.
*		This EH is clever enough to be triggered globally only once even if added on all clients or a single client that is then disconnected,
*		EH will still trigger globally only once.
*
*	@Parameters:
*		_unit: Object - Object the event handler is assigned to
*		_killer: Object - Object that killed the unit. Contains the unit itself in case of collisions
*		_instigator: Object - Person who pulled the trigger
*		_useEffects: Boolean - same as useEffects in setDamage alt syntax
*
*/

params ["_unit", "_killer", "_instigator", "_useEffects", "_unitName", "_unitId", "_killerName", "_killerId"];

_unitName = name _unit;
_unitId = getPlayerUID _unit;
_killerName = name _killer;
_killerId = getPlayerUID _killer;

/*
*	Executed on killer pc
*/
if(player == _killer && player != _unit) then {

	// On-screen killfeed
	private ["_hs", "_dist", "_score"]; private _top = ""; private _mid = ""; private _bot = "";

	// Killed by headshot
	if ((_unit getHit "head") >= 1) then {
		_hs = TRUE;

		_uHS = (player getVariable "tag_unitHeadshots") + 1;
		player setVariable ["tag_unitHeadshots", _uHS, true];

		// Unit who was killed was so by headshot
		_unit setVariable ["tag_unitKilledByHS", 1, true];

	} else {
		_hs = FALSE;
	};

	// Get distance to dead player
	_dist = round(player distance _unit);

	_top = format ["<t size='1.5'>ENEMY KILLED [<t color='#16fe00'>%1</t>] +%2 points</t>", _unitName, TAG_SCORE_BASE];
	_score = TAG_SCORE_BASE;

	if (_hs) then { _mid = format ["<t size='1'>HEADSHOT BONUS +%1 points</t>", TAG_SCORE_HS]; playSound "hs1"; _score = _score + TAG_SCORE_HS; };
	if (_dist >= TAG_DISTBONUS && !_hs) then { _mid = format ["<t size='1'>DISTANCE BONUS +%1 points</t>", _dist]; _score = _score + _dist; };
	if (_dist >= TAG_DISTBONUS && _hs) then { _bot = format ["<t size='1'>DISTANCE BONUS +%1 points</t>", _dist]; _score = _score + _dist; };

	// Send to screen
	[_top, _mid, _bot] call tiic_fnc_showKillfeed;

	// If killer is not IT, set killer to IT
	if(!(player getVariable "tag_unitIsIT")) then {
		player setVariable ["tag_unitIsIT", true, true];
		player setVariable ["tag_unitTimeITBegin", round(time), true];
		missionNamespace setVariable ["tag_playerIt", player, true];
		[player] joinSilent (createGroup east);

		["<t color='#fc374a'>YOU'RE IT!</t>", 1.2, 0, 0.6, 5, 9027, 'any', nil, 'local'] call tiig_fnc_messanger;
	};

	// Update longest Kill / HS if it was longer
	_longHS   = player getVariable "tag_unitLongHS";
	_longKill = player getVariable "tag_unitLongKill";

	_gun = currentWeapon player;
	_gDispName = getText (configfile >> "CfgWeapons" >> _gun >> "displayName");

	if(_hs) then {
		if(_dist > _longHS) then {
			player setVariable ["tag_unitLongHS", _dist, true];
			player setVariable ["tag_unitLongHSGun", _gDispName, true];
		};
	} else {
		if(_dist > _longKill) then {
			player setVariable ["tag_unitLongKill", _dist, true];
			player setVariable ["tag_unitLongKillGun", _gDispName, true];
		};
	};

	// Update kills
	_kills = player getVariable "tag_unitKills";
	player setVariable ["tag_unitKills", _kills+1, true];

	// Add score to player (statistics)
	_uScore = (player getVariable "tag_unitScore") + _score;
	player setVariable ["tag_unitScore", _uScore, true];
};

/*
*	All player deaths (including suicide)
*/
if(player == _unit) then {

	[player] joinSilent (createGroup resistance);

	["Thank you for playing. Better luck next time!", 1, 0, 0.7, 5, 9028, 'any', nil, 'local'] call tiig_fnc_messanger;

	// Remove player bounderies / blur effect / warning message
	'dynamicBlur' ppEffectEnable true;
	'dynamicBlur' ppEffectAdjust [0];
	'dynamicBlur' ppEffectCommit 1;
	1 fadeSound 1;
	['', 1, 0, 0.5, 0.5, 9025, 'any', nil, 'local'] call tiig_fnc_messanger;
	["Removing player bounderies", "DEBUG"] call tiig_fnc_log;

	// Spawn spectator camera on player
	[player] call tiic_fnc_cameraSystem;
};

/*
*	All player deaths (not including suicide)
*/
if(player == _unit && player != _killer) then {

	// Distance player was killed from
	_killedDist = round(player distance _killer);
	player setVariable ["tag_unitKilledDist", _killedDist, true];

	// Weapon player was killed by
	_gun = currentWeapon _killer;
	_gDispName = getText (configfile >> "CfgWeapons" >> _gun >> "displayName");
	player setVariable ["tag_unitKilledWeapon", _gDispName, true];

	// Unit who killed player
	player setVariable ["tag_unitKilledBy", _killerId, true];
};

/*
*	Suicide
*/
if(player == _unit && player == _killer) then {
	
	// Player commited suicide
	player setVariable ["tag_unitSuicide", 1, true];
};

/*
*	Server execution
*	All types of deaths; killed / suicide / game crash / disconnect
*/
if(isServer || isDedicated) then {

	_unit setVariable ["tag_unitLifespan", round(time - tag_timeRoundBegin), true];
	_timeBeginIT = _unit getVariable "tag_unitTimeITBegin";
	if(_unit getVariable "tag_unitIsIT") then { _unit setVariable ["tag_unitLifespanIT", round(time - _timeBeginIT), true]; };

	// Unit cant be IT and is not playing anymore
	_unit setVariable ["tag_unitPlaying", false, true];
	_unit setVariable ["tag_unitIsIT", false, true];
	_unit setVariable ["tag_unitDeath", 1, true];

	// Delete dead unit from player list
	_pList = missionNamespace getVariable "tag_playerList";;
	_pList deleteAt (_pList find _unit);
	missionNamespace setVariable ["tag_playerList", _pList, true];

	// Delete shot marker
	deleteMarker (_unitId + "_solid");
	deleteMarker (_unitId + "_text");

	// Report all player stats to DB
	[_unit] spawn tiis_fnc_reportStats;

	// If game is live and IT disappeared somehow
	if(tag_gameInProgress || tag_gameLoading) then {
		0 spawn {
			sleep 4;
			if(tag_playerCount >= 2) then {
				_itExists = call tiis_fnc_itExists;
				if(!_itExists) then { 0 spawn tiis_fnc_itDisappeared; };
			};
			terminate _thisScript;
		};
	};
};

[">>>> EH TRIGGERED: onKilled <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _killer: %2 | _instigator: %3 | _useEffects: %4",_unit,_killer,_instigator,_useEffects],"DEEPDEBUG"] call tiig_fnc_log;