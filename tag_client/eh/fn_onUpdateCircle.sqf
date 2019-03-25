/*
*	@Name: onUpdateCircle
*
*	@Description:
*		Updates deathCircle when triggered from servers
*
*	@Parameters:
*		none
*/

if(player getVariable "tag_unitDeathCircle") then {
	player setVariable ["tag_unitDeathCircle", false, true];

	{ deleteVehicle _x; } forEach tag_circleRetA;
	{ deleteVehicle _x; } forEach tag_circleRetB;

	0 spawn tiig_fnc_deathCircle;
	
	[">>>> EH TRIGGERED: onUpdateCircle <<<<","DEEPDEBUG"] call tiig_fnc_log;
};