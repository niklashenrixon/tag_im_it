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
*		_id: Number - is the unique DirectPlay ID. Quite useless as the number is too big for in-built string representation and gets rounded. It is also the same id used for user placed markers.
*		_uid: String - is getPlayerUID of the leaving player. In Arma 3 it is also the same as Steam ID.
*		_name: String - is profileName of the leaving player.
*
*/

params ["_unit", "_id", "_uid", "_name"];

if (tag_roundInProgress) then {

	_itExists = call tiis_fnc_itExists;

	if(!_itExists) then {

		if(tag_playerCount >= 2) then {

			_newIt = call tiig_fnc_selectRandom;

			["""IT"" Disconnected. Someone new will be selected to play as ""IT"" in 20 seconds", 1, 0, 0.7, 10, 1337, "exclude", _newIt, "mp"] call tiig_fnc_messanger;
			["""IT"" Disconnected. You have been selected to play as ""IT"", you have 20 seconds until you're ""IT""", 1, 0, 0.7, 10, 1337, "specific", _newIt, "mp"] call tiig_fnc_messanger;

			sleep 20;

			[_newIt] joinSilent (createGroup east);

			_newIt setVariable ["tag_unitIsIT", true, true];

			tag_ItTime = round(time);
			publicVariable "tag_ItTime";

			["You're ""IT"" now, good luck!", 1, 0, 0.7, 5, 1337, "specific", _newIt, "mp"] call tiig_fnc_messanger;

			if (tag_playerCount >= 3) exitWith { ["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _newIt, "mp"] call tiig_fnc_messanger; };
		};

		_markerSolidID = _uid + "_solid";
		_markerTextID = _uid + "_text";
		deleteMarker _markerSolidID;
		deleteMarker _markerTextID;
	};

	[">>>> EH TRIGGERED: onHandleDisconnect <<<<","DEEPDEBUG"] call tiig_fnc_log;
	[["_unit: %1 | _id: %2 | _uid: %3 | _name: %4 | _roundId: %5", _unit, _id, _uid, _name, tag_roundID],"DEEPDEBUG"] call tiig_fnc_log;
	
	UpdatePlayerDeathOnDisconnect = [_unit, _uid];
	publicVariableServer "UpdatePlayerDeathOnDisconnect";

	// Player disconnected
	player setVariable ["tag_unitDisconnected", 1, true];
};

terminate _thisScript;