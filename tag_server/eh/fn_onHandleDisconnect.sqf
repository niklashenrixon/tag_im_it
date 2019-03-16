/*
*	@Name: onHandleDisconnect
*
*	@Description:
*		Triggered when player disconnects from the game.
*		Similar to onPlayerDisconnected event but can be stacked and contains the unit occupied by player before disconnect.
*		Must be added on the server and triggers only on the server.
*
*	@Notes
*		Override: If this EH code returns true, the unit, previously occupied by player,
*		gets transferred to the server, becomes AI and continues to live,
*		even with description.ext param disabledAI = 1;
*
*	@Parameters:
*		_unit: Object - unit formerly occupied by player
*		_id: Number - same as _id in onPlayerDisconnected
*		_uid: String - same as _uid in onPlayerDisconnected
*		_name: String - same as _name in onPlayerDisconnected
*
*/

params ["_unit", "_id", "_uid", "_name"];
	
if (tag_roundInProgress) then {
	if(_unit == tag_playerIt) then {

		if(tag_playerCount >= 2) then {

			_newRandom = call tiig_fnc_selectRandom;

			if(tag_roundStarted) then {
				["""IT"" Disconnected. Someone new will be selected to play as ""IT"" in 20 seconds", 1, 0, 0.7, 10, 1337, "exclude", _newRandom, "mp"] call tiig_fnc_messanger;
				["""IT"" Disconnected. You have been selected to play as ""IT"", you have 20 seconds until you're ""IT""", 1, 0, 0.7, 10, 1337, "specific", _newRandom, "mp"] call tiig_fnc_messanger;
			} else {
				["""IT"" Disconnected. Someone new will be selected to play as ""IT"" after the round has begun", 1, 0, 0.7, 10, 1337, "noCiv", nil, "mp"] call tiig_fnc_messanger;

				waitUntil {
					if (tag_roundStarted) exitWith {true};
					sleep 0.5;
				};

				sleep 5;
				["You have been selected to play as ""IT"", you have 20 seconds until you're ""IT""", 1, 0, 0.7, 10, 1337, "specific", _newRandom, "mp"] call tiig_fnc_messanger;
			};

			sleep 20;

			[_newRandom] joinSilent (createGroup east);

			tag_playerIt = _newRandom;
			publicVariable "tag_playerIt";

			tag_ItTime = round(time);
			publicVariable "tag_ItTime";

			[tag_m_youreIt, 1, 0, 0.7, 5, 1337, "specific", _newRandom, "mp"] call tiig_fnc_messanger;

			if (tag_playerCount >= 3) exitWith { ["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _newRandom, "mp"] call tiig_fnc_messanger; };
		};

		_markerSolidID = _uid + "_solid";
		_markerTextID = _uid + "_text";
		deleteMarker _markerSolidID;
		deleteMarker _markerTextID;
	};

	[["EH_NAME: HandleDisconnect triggered by: %1 (%2) | Round ID: %3", name _unit, _uid, roundId], "DEBUG"] call tiig_fnc_log;
	
	UpdatePlayerDeathOnDisconnect = [_unit, _uid];
	publicVariableServer "UpdatePlayerDeathOnDisconnect";
};

terminate _thisScript;