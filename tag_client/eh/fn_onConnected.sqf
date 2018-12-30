/*
*	@Name: onConnected
*
*	@Description:
*		publicVariableEventHandler triggered from server when player connects
*
*	@Parameters:
*		_this select 0: String - broadcast variable name (same variable name EH is attached to) 
*		_this select 1: Anything - broadcast variable value 
*		_this select 2: Object, Group - target the variable got set on with setVariable
*/

params ["_varName","_varValue"];
diag_log ">>>>>>>>>>>>> PLAYER CONNECTED <<<<<<<<<<<<<<<";
diag_log format["_varName: %1", _varName];
diag_log format["_varValue: %1", _varValue];