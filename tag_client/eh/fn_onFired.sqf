/*
*	@Name: onFired
*
*	@Description:
*		Triggered when the unit fires a weapon.
*		This EH will not trigger if a unit fires out of a vehicle. For those cases an EH has to be attached to that particular vehicle.
*		When "Manual Fire" is used, the gunner is objNull if gunner is not present or the gunner is not the one who fires.
*		To check if "Manual Fire" is on, use isManualFire. The actual shot instigator could be retrieved with getShotParents command.
*
*	@Parameters:
*		_unit: Object - Object the event handler is assigned to
*		_weapon: String - Fired weapon
*		_muzzle: String - Muzzle that was used
*		_mode: String - Current mode of the fired weapon
*		_ammo: String - Ammo used
*		_magazine: String - magazine name which was used
*		_projectile: Object - Object of the projectile that was shot out
*		_gunner: Object - gunner whose weapons are firing.
*
*/

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

[_unit] call tiig_fnc_shotMarker;

if (tag_gameInProgress && _weapon != "Put" && side _unit != civilian) then {
	_sfired = (player getVariable "tag_unitShotsFired") + 1;
	player setVariable ["tag_unitShotsFired", _sfired, true];
};

[">>>> EH TRIGGERED: onFired <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _weapon: %2 | _muzzle: %3 | _mode: %4 | _ammo: %5 | _magazine: %6 | _projectile: %7 | _gunner: %8",_unit,_weapon,_muzzle,_mode,_ammo,_magazine,_projectile,_gunner],"DEEPDEBUG"] call tiig_fnc_log;