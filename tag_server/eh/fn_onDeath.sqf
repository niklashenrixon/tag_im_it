/*
*	@Name: onDeath (Variable Eventhandler)
*
*	@Description:
*		Triggered if player dies
*
*	@Parameters:
*		_unit: Object - Unit object
*
*/

params [["_unit", objNull]];
if (isNull _unit) exitWith { ["onSuicide: eventhandler cannot be used without providing unit object"] call tiig_fnc_log; };

if (tag_roundInProgress) then {

};

["You're ""IT"" now, good luck!", 1, 0, 0.7, 5, 1337, "specific", _killer, "mp"] call tiig_fnc_messanger;

if (tag_playerCount >= 3) then {
	["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _killer, "mp"] call tiig_fnc_messanger;
};


[["EH_NAME: death triggered by: %1 (%2) | Killer: %3 (%4) | Round ID: %5", name _victim, _victimID, name _killer, _killerID, roundId], "DEBUG"] call tiig_fnc_log;


/*
*	Perform every time death occurs
*/
_markerSolidID = _victimID + "_solid";
_markerTextID = _victimID + "_text";
deleteMarker _markerSolidID;
deleteMarker _markerTextID;

UpdatePlayerRoundStat = [_victim, _killer];
publicVariableServer "UpdatePlayerRoundStat";

["Thank you for playing. Better luck next time!", 1, 0, 0.7, 5, 1337, "specific", _victim, "mp"] call tiig_fnc_messanger;


terminate _thisScript;