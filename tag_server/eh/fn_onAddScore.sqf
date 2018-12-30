/*
*	@Name: onAddScore (Variable Eventhandler)
*
*	@Description:
*		Add Score to Unit (Must be added from server)
*
*	@Parameters:
*		_unit: Object - Unit object
*		_score: Number - Score to add to unit
*
*/

params [["_unit",objNull], ["_score",0,[0]]];
if (isNull _unit) exitWith { ["onAddScore: eventhandler cannot be used without providing unit object"] call tiig_fnc_log; };

_unit addScore _score;

_query = format ["UpdateScore:%1:%2:%3", _score, tag_roundID, getPlayerUID _unit];
[_query, 1, true] call tiis_fnc_aSync;