/*
*	@Name: onHit (MP)
*
*	@Description:
*		Triggered when the unit is hit/damaged. EH can be added on any machine and EH code will trigger globally on every connected client and server.
*		This EH is clever enough to be triggered globally only once even if added on all clients or a single client that is then disconnected,
*		EH will still trigger globally only once.
*		Is not always triggered when unit is killed by a hit. Most of the time only the Killed event handler is triggered when a unit dies from a hit.
*		The hit EH will not necessarily fire if only minor damage occurred (e.g. firing a bullet at a tank), even though the damage increased.
*		Can also trigger several times for an explosion (direct and indirect damage). Does not fire when a unit is set to allowDamage false.
*		However it will fire with "HandleDamage" EH added alongside stopping unit from taking damage (unit addEventHandler ["HandleDamage", {0}];.
*		Will not trigger once the unit is dead.
*		Note: call a function from the MPHit EH code space rather than defining the full code in there directly.
*		The reason is the code space will be transferred over network on each event activation - so keep the data as small as possible!
*
*	@Parameters:
*		_unit: Object - Object the event handler is assigned to 
		_causedBy: Object - Object that caused the damage. Contains the unit itself in case of collisions. 
*		_damage: Number - Level of damage caused by the hit
*		_instigator: Object - Person who pulled the trigger
*
*/

params ["_unit", "_causedBy", "_damage", "_instigator"];

// Lägg till en statistik på hur mycket skada en person gör under varje runda
// summera även det i leaderboard så man ser hur mycket skada personen har gett under hela sin livstid

// Execute this only if game has started
if (tag_gameInProgress) then {

	// 
	if(player == _causedBy && player != _unit) then {

	};

	// Damage inflicted by yourself
	if(player == _unit && player == _causedBy) then {

	};

};


/*
_causedByUID = getPlayerUID(_causedBy);

if (tag_playersMoved) then {

	if (getPlayerUID(player) != _causedByUID && side(player) != side(_causedBy)) then {

		tag_preShotsTaken = tag_preShotsTaken + 1;

		[["EVENT_HIT: SHOTS TAKEN | %1", tag_preShotsTaken],"DEEPDEBUG"] call tagglobal_fnc_log;
		
		if (_causedByUID in hitArray) then {
			_hitSearch = (hitArray find _causedByUID) + 1;
			hitArray set [_hitSearch, ((hitArray select _hitSearch) + 1)];
			[["EVENT_HIT: ADD | %1", hitArray],"DEEPDEBUG"] call tagglobal_fnc_log;
		} else {
			hitArray = hitArray + [_causedByUID, 1];
			[["EVENT_HIT: CREATE | %1", hitArray],"DEEPDEBUG"] call tagglobal_fnc_log;
		};
		
		tag_eh_hitTriggered = time + 0.2;
	};
};
*/
[">>>> EH TRIGGERED: onHit <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _causedBy: %2 | _damage: %3 | _instigator: %4",_unit,_causedBy,_damage,_instigator],"DEEPDEBUG"] call tiig_fnc_log;

