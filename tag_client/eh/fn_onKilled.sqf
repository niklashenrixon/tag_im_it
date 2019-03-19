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

	// Check if player is IT
	_unitIsIt = player getVariable "tag_unitIsIT";

	// If killer is not IT, set killer to IT
	if(!_unitIsIt) then {
		player setVariable ["tag_unitIsIT", true, true];
		missionNamespace setVariable ["tag_playerIt", player, true];
		[player] joinSilent (createGroup east);

		if (tag_playerCount >= 2) then {
			["You're ""IT"" now, good luck!", 1, 0, 0.7, 5, 1337, "specific", player, "mp"] call tiig_fnc_messanger;
			["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", player, "mp"] call tiig_fnc_messanger;
		};
	};

	// Add score to player (in-game)
	player addScore _score;

	// Add score to player (statistics)
	_uScore = (player getVariable "tag_unitScore") + _score;
	player setVariable ["tag_unitScore", _uScore, true];
};

/*
*	All player deaths (including suicide)
*/
if(player == _unit) then {

	[player] joinSilent (createGroup resistance);

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

	["Thank you for playing. Better luck next time!", 1, 0, 0.7, 5, 1337, "specific", _unit, "mp"] call tiig_fnc_messanger;

	// Unit cant be IT and is not playing anymore
	_unit setVariable ["tag_unitPlaying", false, true];
	_unit setVariable ["tag_unitIsIT", false, true];

	// Delete shot marker
	deleteMarker (_unitId + "_solid");
	deleteMarker (_unitId + "_text");

	// Report all player stats to DB
	[_unit] spawn tiis_fnc_reportStats;

	// If game is live and IT disappeared somehow
	if(tag_gameInProgress && tag_playerCount >= 2) then {
		0 spawn {
			sleep 2;

			_itExists = call tiis_fnc_itExists;

			if(!_itExists) then { 0 spawn tiis_fnc_itDisappeared; };
			terminate _thisScript;
		};
	};
};

[">>>> EH TRIGGERED: onKilled <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _killer: %2 | _instigator: %3 | _useEffects: %4",_unit,_killer,_instigator,_useEffects],"DEEPDEBUG"] call tiig_fnc_log;