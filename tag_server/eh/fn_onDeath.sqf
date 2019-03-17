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



		/*
		*	Simultaneous death
		*/
		sleep 0.2;
		if (!alive _killer) then {

			if (!alreadyFired) then {
				
				alreadyFired = true; publicVariable "alreadyFired";
				tag_roundIsDraw = true;

				/*
				*	End of round
				*/
				if (_playerCount == 0) then {
					["""IT"" and the last hunter killed each other simultaneously. That means it's a draw", 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;

					tag_roundInProgress = false;
					publicVariable "tag_roundInProgress";

					tag_roundStarted = false;
					publicVariable "tag_roundStarted";

					[[0, 1.5, false, false], "BIS_fnc_cinemaBorder", true, false, true] call BIS_fnc_MP;
					sleep 10;
					["END1", TRUE, 5] spawn BIS_fnc_endMission;
				};

				/*
				*	Choose new IT
				*/
				if (tag_playerCount > 1) then {
					_newRandom = [] call tag_fn_selectRandom;
					["""IT"" and a hunter killed each other simultaneously. Someone of you will be ""IT"" in 10 seconds", 1, 0, 0.7, 10, 1337, "noCiv", nil, "mp"] call tiig_fnc_messanger;

					sleep 10;

					tag_playerIt = _newRandom;
					publicVariable "tag_playerIt";

					[_newRandom] joinSilent (createGroup east);
					[_newRandom, "TagHelmet"] spawn tag_fn_addHeadgear;

					[tag_m_youreIt, 1, 0, 0.7, 5, 1337, "specific", _newRandom, "mp"] call tiig_fnc_messanger;

					if (tag_playerCount >= 3) then { ["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _newRandom, "mp"] call tiig_fnc_messanger; };

				};

				[["EH_NAME: death_simultaneous triggered by: %1 (%2) | Killer: %3 (%4) | Round ID: %5", name _victim, _victimID, name _killer, _killerID, roundId], "DEBUG"] call tiig_fnc_log;

			};

		/*
		*	Normal death
		*/
		} else {

			if (tag_playerCount == 1) then {

				if(_killer != tag_playerIt) then {

					[_killer] joinSilent (createGroup east);

					[_killer, "TagHelmet"] spawn tag_fn_addHeadgear;

				};
			};

			if (tag_playerCount > 1) then {

				if(_killer != tag_playerIt) then {

					[_killer] joinSilent (createGroup east);

					[_killer, "TagHelmet"] spawn tag_fn_addHeadgear;

					[tag_m_youreIt, 1, 0, 0.7, 5, 1337, "specific", _killer, "mp"] call tiig_fnc_messanger;

					if (tag_playerCount >= 3) then {
						["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _killer, "mp"] call tiig_fnc_messanger;
					};
				};
			};

			[["EH_NAME: death triggered by: %1 (%2) | Killer: %3 (%4) | Round ID: %5", name _victim, _victimID, name _killer, _killerID, roundId], "DEBUG"] call tiig_fnc_log;
		};

		/*
		*	Perform every time death occurs
		*/
		_markerSolidID = _victimID + "_solid";
		_markerTextID = _victimID + "_text";
		deleteMarker _markerSolidID;
		deleteMarker _markerTextID;

		UpdatePlayerRoundStat = [_victim, _killer];
		publicVariableServer "UpdatePlayerRoundStat";

		[tag_m_endRound, 1, 0, 0.7, 5, 1337, "specific", _victim, "mp"] call tiig_fnc_messanger;
	};
};

terminate _thisScript;