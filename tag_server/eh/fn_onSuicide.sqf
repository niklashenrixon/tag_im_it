/*
*	@Name: onSuicide (Variable Eventhandler)
*
*	@Description:
*		Triggered if player commit suicide
*
*	@Parameters:
*		_unit: Object - Unit object
*
*/

params [["_unit", objNull]];
if (isNull _unit) exitWith { ["onSuicide: eventhandler cannot be used without providing unit object"] call tiig_fnc_log; };

if (tag_roundInProgress) then {

	_unitID = getPlayerUID(_unit);
	_itExists = call tiis_fnc_itExists;

	if(!_itExists) then {
		if(tag_playerCount >= 2) then {

			_newIt = call tiig_fnc_selectRandom;

			["""IT"" Commited suicide. Someone new will be selected to play as ""IT"" in 20 seconds", 1, 0, 0.7, 10, 1337, "exclude", _newIt, "mp"] call tiig_fnc_messanger;
			["""IT"" Commited suicide. You have been selected to play as ""IT"", you have 20 seconds until you're ""IT""", 1, 0, 0.7, 10, 1337, "specific", _newIt, "mp"] call tiig_fnc_messanger;

			sleep 20;

			[_newIt] joinSilent (createGroup east);

			_newIt setVariable ["tag_unitIsIT", true, true];

			tag_ItTime = round(time);
			publicVariable "tag_ItTime";

			["You're ""IT"" now, good luck!", 1, 0, 0.7, 5, 1337, "specific", _newIt, "mp"] call tiig_fnc_messanger;

			if (tag_playerCount >= 3) then { ["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _newIt, "mp"] call tiig_fnc_messanger; };
		};

		_markerSolidID = _unitID + "_solid";
		_markerTextID = _unitID + "_text";
		deleteMarker _markerSolidID;
		deleteMarker _markerTextID;
	};

	[">>>> EH TRIGGERED: onSuicide <<<<","DEEPDEBUG"] call tiig_fnc_log;
	[["_unit: %1 | _unitID: %2 | _roundID: %3", _unit, _unitID, tag_roundID],"DEEPDEBUG"] call tiig_fnc_log;

	UpdatePlayerDeathOnRespawn = [_unit, _unitID]; 
	publicVariableServer "UpdatePlayerDeathOnRespawn";
};

terminate _thisScript;