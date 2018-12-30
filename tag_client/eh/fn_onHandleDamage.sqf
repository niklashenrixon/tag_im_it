/*
*	@Name: onHandleDamage
*
*	@Description:
*		Triggers when the unit is damaged and fires for each damaged selection separately
*		Note: Currently, in Arma 3 v1.70 it triggers for every selection of a vehicle, no matter if the section was damaged or not).
*		Works with all vehicles. This EH can accept a remote unit as argument however it will only fire when the unit is local to the PC this event handler was added on.
*		For example, you can add this event handler to one particular vehicle on every PC.
*		When this vehicle gets hit, only EH on PC where the vehicle is currently local will fire.
*		If code provided returns a numeric value, this value will overwrite the default damage of given selection after processing.
*		Return value of 0 will make the unit invulnerable if damage is not scripted in other ways (i.e using setDamage and/or setHit for additional damage handling).
*		If no value is returned, the default damage processing will be done. This allows for safe stacking of this event handler.
*		Only the return value of the last added "HandleDamage" EH is considered.
*
*		Notes:
*
*		Multiple "HandleDamage" event handlers can be added to the same unit.
*		If multiple EHs return damage value for custom damage handling, only last returned value will be considered by the engine.
*		EHs that do not return value can be safely added after EHs that do return value.
*
*		You can save the last event as timestamp (diag_tickTime) onto the unit,
*		as well as the current health of the unit/its selections,
*		with setVariable and query it on each "HandleDamage" event with getVariable to define a system how to handle the "HandleDamage" event.
*		"HandleDamage" will continue to trigger even if the unit is already dead.
*		"HandleDamage" is persistent. If you add it to the player object, it will continue to exist after player respawned.
*		"HandleDamage" can trigger "twice" per damage event. Once for direct damage, once for indirect damage (explosive damage).
*		This can happen even in the same frame, but is unlikely.
*
*	@Parameters:
*		_unit: Object - Object the event handler is assigned to.
*		_hitSelection: String - Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
*		_damage: Number - Resulting level of damage for the selection.
*		_source: Object - The source unit that caused the damage.
*		_projectile: String - Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.)
*		_hitPartIndex: Number - Hit part index of the hit point, -1 otherwise.
*		_instigator: Object - Person who pulled the trigger
*		_hitPoint: String - hit point Cfg name
*
*/

params ["_unit", "_hitSelection", "_damage", "_shooter", "_projectile", "_hitPartIndex", "_instagator", "_hitPoint"];

if(_hitPoint == "HitLegs") then {
	if (_damage >= 0.5) then {
		_damage = 0.48;
	};
};

if (!tag_gameInProgress) then {
	_damage = damage(player);
} else {
	// If side of shooter is the same as yours and "shooter" is not you then set damage to nothing
	if ((side(player) == side(_shooter)) && ((getPlayerUID(player)) != (getPlayerUID(_shooter)))) then {
		_damage = damage(player);
	};
};

[">>>> EH TRIGGERED: onHandleDamage <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _hitSelection: %2 | _damage: %3 | _shooter: %4 | _projectile: %5 | _hitPartIndex: %6 | _instagator: %7 | _hitPoint: %8", _unit,_hitSelection,_damage,_shooter,_projectile,_hitPartIndex,_instagator,_hitPoint],"DEEPDEBUG"] call tiig_fnc_log;

_damage