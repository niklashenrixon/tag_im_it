/*
*	@Name: onHandleHeal
*
*	@Description:
*		Triggered when unit starts to heal (player using heal action or AI heals after being ordered).
*		Triggers only on PC where EH is added and unit is local. If code returns false, engine side healing follows.
*		Return true if you handle healing in script, use AISFinishHeal to tell engine that script side healing is done.
*		See also lifeState and setUnconscious commands.
*
*		NOTE: This Event Handler is broken but somewhat usable. When attached to a unit it will fire when medic action is started (not finished!) on the unit.
*		_this select 0 will be the unit itself, _this select 1 will be the healer.
*		The 3rd param will always be false and neither returning true nor using AISFinishHeal will have any effect on the engine default healing behaviour.
*		If unit walks away from the healer during healing action, the heal will not finish but there is no way to detect this within "HandleHeal" framework.
*
*	@Parameters:
*		_unit: Object
*		_healer: Object
*		_isMedic: Boolean - true when healer is corpsman
*
*/

params ["_unit","_healer","_isMedic"];

// Give player 100% health when using first aid kits
_damage = damage _unit;
if (_unit == _healer) then {
	waitUntil {damage _unit != _damage};
	if (damage _unit < _damage) then {
		_unit setDamage 0;
	};
};

[">>>> EH TRIGGERED: onHandleHeal <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 |_healer: %2 |_isMedic: %3",_unit,_healer,_isMedic],"DEEPDEBUG"] call tiig_fnc_log;