/*
*	@Name: onUpdateCircle
*
*	@Description:
*		Updates deathCircle when triggered from servers
*
*	@Parameters:
*		none
*/

{ deleteVehicle _x; } forEach tag_circleRetA;
{ deleteVehicle _x; } forEach tag_circleRetB;

0 spawn tiig_fnc_deathCircle;

[">>>> EH TRIGGERED: onUpdateCircle <<<<","DEEPDEBUG"] call tiig_fnc_log;