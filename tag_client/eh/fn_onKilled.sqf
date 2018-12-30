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

// Executed on killer pc
if(player == _killer && player != _unit) then {

	player setVariable ["tag_unitIsIT", true, true];
	[player] joinSilent (createGroup east);

	/*
	*	On-screen killfeed
	*/
		private ["_hs", "_dist", "_score"]; private _top = ""; private _mid = ""; private _bot = "";

		// Killed by headshot
		if ((_unit getHit "head") >= 1) then { _hs = TRUE; } else { _hs = FALSE; };

		_dist = round(player distance _unit);
		_top = format ["<t size='1.5'>ENEMY KILLED [<t color='#16fe00'>%1</t>] +100 points</t>", _unitName];
		_score = 100;

		if (_hs) then { _mid = "<t size='1'>HEADSHOT BONUS +200 points</t>"; playSound "hs1"; _score = _score + 200; };
		if (_dist >= TAG_DISTBONUS && !_hs) then { _mid = format ["<t size='1'>DISTANCE BONUS +%1 points</t>", _dist]; _score = _score + _dist; };
		if (_dist >= TAG_DISTBONUS && _hs) then { _bot = format ["<t size='1'>DISTANCE BONUS +%1 points</t>", _dist]; _score = _score + _dist; };

		// Send to screen
		[_top, _mid, _bot] call tiic_fnc_showKillfeed;

	// Add score to player
	tag_addScore = [player, _score];
	publicVariableServer "tag_addScore";
};

// All player deaths (including suicide)
if(player == _unit) then {

	player setVariable ["tag_unitPlaying", false, true];
	player setVariable ["tag_unitIsIT", false, true];

	[player] joinSilent (createGroup resistance);

	'dynamicBlur' ppEffectEnable true;
	'dynamicBlur' ppEffectAdjust [0];
	'dynamicBlur' ppEffectCommit 1;
	1 fadeSound 1;
	['', 1, 0, 0.5, 0.5, 9025, 'any', nil, 'local'] call tiig_fnc_messanger;
	["Removing player bounderies", "DEBUG"] call tiig_fnc_log;

	[player] call tiic_fnc_cameraSystem;
};

// All player deaths (not including suicide)
if(player == _unit && player != _killer) then {
};

// Suicide
if(player == _unit && player == _killer) then {
	// Sätt en variabel till true som servern sedan tittar på för att regga suicide
};

// Server execution
// Happen everytime someone dies
if(isServer || isDedicated) then {
	// Utvärdera player och hämta all data
	// Samla in poäng från killfeed ovanför
	// samla in andra statusar som suicide från ovanför tex
};





/*
_killerUID = getPlayerUID(_killer);

deleteVehicle tag_deathCircle; // Delete circle detection

if (tag_roundInProgress) then {
	// Player commited suicide
	if (player == _killer) then {

		player setVariable ["tag_projectile", projectile, true];
		player setVariable ["tag_shotsFired", tag_preShotsFired, true];
		player setVariable ["tag_shotsTaken", tag_preShotsTaken, true];
		player setVariable ["tag_shotsHitArray", hitArray, true];

		suicide = [player, (getPlayerUID player)];
		publicVariableServer "suicide";

	// Player got killed
	} else {

		_feedbackHS = 0;
		_dist = 0;

		_dist = player distance _killer;
		player setVariable ["tag_killDist", _dist, true];

		// Killed by headshot yes/no?
		if ((player getHit "head") >= 1) then {
			_feedbackHS = 1;
			player setVariable ["tag_headshot", 1, true];
		} else {
			player setVariable ["tag_headshot", 0, true];
		};

		if (_killerUID in ownerArray) then {
			_ownerIDSearch = (ownerArray find _killerUID) + 1;
			_pcID = ownerArray select _ownerIDSearch;
			_pName = name player;
			tag_killFeedback = [_pName, projectile, _feedbackHS, _dist];
			_pcID publicVariableClient "tag_killFeedback";
		};

		if (!(time <= tag_eh_hitTriggered)) then {
			["EVENT_HIT_NOT_TRIGGERED Giving +1 for kill", "DEEPDEBUG"] call tagglobal_fnc_log;

			tag_preShotsTaken = tag_preShotsTaken + 1;

			if (_killerUID in hitArray) then {
				_hitSearch = (hitArray find _killerUID) + 1;
				hitArray set [_hitSearch, ((hitArray select _hitSearch) + 1)];
				[["EVENT_KILLED: ADD HIT | %1", hitArray],"DEEPDEBUG"] call tagglobal_fnc_log;
			} else {
				hitArray = hitArray + [_killerUID, 1];
				[["EVENT_KILLED: CREATE HIT | %1", hitArray],"DEEPDEBUG"] call tagglobal_fnc_log;
			};
		};

		player setVariable ["tag_projectile", projectile, true];
		player setVariable ["tag_shotsFired", tag_preShotsFired, true];
		player setVariable ["tag_shotsTaken", tag_preShotsTaken, true];
		player setVariable ["tag_shotsHitArray", hitArray, true];

		death = [player, _killer]; 
		publicVariableServer "death";
	};

	/*
	*	If player is VIP or above give him camera
	*
	if ((getPlayerUID player) in tag_cameraAccess) then {
		[] spawn {
			sleep 0.2;
			tag_inCam = [player] spawn TAG_fnc_cameraSystem;
		};
	};
};

/*
*	Terminate Anti Camp System
*/
//deleteVehicle antiCampDetector;
//terminate antiCampStop;
//terminate antiCampMove;
//terminate tag_antiCampSystem;

[">>>> EH TRIGGERED: onKilled <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _killer: %2 | _instigator: %3 | _useEffects: %4",_unit,_killer,_instigator,_useEffects],"DEEPDEBUG"] call tiig_fnc_log;