/*
*	@Name: onEjectVehicle
*
*	@Description:
*		Ejects player from current vehicle (if any) and locks it.
*		Called from server via variableEventhandle
*
*	@Parameters:
*		none
*/

if (vehicle player != player) then {
	_curVehicle = vehicle player;
	player action ["Eject", _curVehicle];
	_curVehicle lock true;
};

[">>>> EH TRIGGERED: onEjectVehicle <<<<","DEEPDEBUG"] call tiig_fnc_log;