/*
*	@Name: onEnded
*
*	@Description:
*		Triggered when mission ends, either using trigger of type "End",
*		endMission command, BIS_fnc_endMission function or ENDMISSION cheat.
*
*	@Parameters:
*		_endType: String - mission end type. Used in Debriefing among other things.
*
*/

params ["_endType"];

[">>>> EH TRIGGERED: onEnded <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_endType: %1",_endType],"DEEPDEBUG"] call tiig_fnc_log;