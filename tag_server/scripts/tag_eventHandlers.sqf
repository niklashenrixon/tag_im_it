/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_eventHandlers.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Server-side event handlers
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
*	@Name: HandleDisconnect
*	@Description: Triggered when player disconnects from the game.
*	@Usage: Can be stacked and contains the unit occupied by player before disconnect. Must be added on the server and triggers only on the server.
*	@Return: If this EH code returns true, the unit, previously occupied by player, gets transferred to the server, becomes AI and continues to live, even with description.ext param disabledAI = 1;
*/
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
	
	[_unit, _uid] spawn {

		_unit   = _this select 0;
		_unitID	= _this select 1;

		if (tag_roundInProgress) then {
			if(_unit == tag_playerIt) then {

				if(tag_playerCount >= 2) then {

					_newRandom = [] call tag_fn_selectRandom;

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

					[_newRandom, "TagHelmet"] spawn tag_fn_addHeadgear;

					[tag_m_youreIt, 1, 0, 0.7, 5, 1337, "specific", _newRandom, "mp"] call tiig_fnc_messanger;

					if (tag_playerCount >= 3) exitWith { ["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _newRandom, "mp"] call tiig_fnc_messanger; };
				};

				_markerSolidID = _unitID + "_solid";
				_markerTextID = _unitID + "_text";
				deleteMarker _markerSolidID;
				deleteMarker _markerTextID;
			};

			[["EH_NAME: HandleDisconnect triggered by: %1 (%2) | Round ID: %3", name _unit, _unitID, roundId], "DEBUG"] call tiig_fnc_log;
			
			UpdatePlayerDeathOnDisconnect = [_unit, _unitID];
			publicVariableServer "UpdatePlayerDeathOnDisconnect";
		};
	};
}];

/*
*	EVENTHANDLER : SUICIDE
*/
"suicide" addPublicVariableEventHandler {

	[_this select 1 select 0, _this select 1 select 1] spawn {

		_unit	= _this select 0;
		_unitID = _this select 1;

		if (tag_roundInProgress) then {
			if(_unit == tag_playerIt) then {

				if(tag_playerCount >= 2) then {

					_newRandom = [] call tag_fn_selectRandom;

					if(tag_roundStarted) then {
						["""IT"" Commited suicide. Someone new will be selected to play as ""IT"" in 20 seconds", 1, 0, 0.7, 10, 1337, "exclude", _newRandom, "mp"] call tiig_fnc_messanger;
						["""IT"" Commited suicide. You have been selected to play as ""IT"", you have 20 seconds until you're ""IT""", 1, 0, 0.7, 10, 1337, "specific", _newRandom, "mp"] call tiig_fnc_messanger;
					} else {
						["""IT"" Commited suicide. Someone new will be selected to play as ""IT"" after the round has begun", 1, 0, 0.7, 10, 1337, "noCiv", nil, "mp"] call tiig_fnc_messanger;

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

					[_newRandom, "TagHelmet"] spawn tag_fn_addHeadgear;

					[tag_m_youreIt, 1, 0, 0.7, 5, 1337, "specific", _newRandom, "mp"] call tiig_fnc_messanger;

					if (tag_playerCount >= 3) then { ["There's a new ""IT""", 1, 0, 0.7, 5, 1337, "exclude", _newRandom, "mp"] call tiig_fnc_messanger; };
				};

				_markerSolidID = _unitID + "_solid";
				_markerTextID = _unitID + "_text";
				deleteMarker _markerSolidID;
				deleteMarker _markerTextID;
			};

			[["EH_NAME: suicide triggered by: %1 (%2) | Round ID: %3", name _unit, _unitID, roundId], "DEBUG"] call tiig_fnc_log;

			UpdatePlayerDeathOnRespawn = [_unit, _unitID]; 
			publicVariableServer "UpdatePlayerDeathOnRespawn";
		};
	};
};

/*
*	EVENTHANDLER : DEATH
*/
"death" addPublicVariableEventHandler {
	
	[_this select 1 select 0, _this select 1 select 1] spawn {

		_victim	= _this select 0;
		_killer	= _this select 1;

		_victimID = getPlayerUID(_victim);
		_killerID = getPlayerUID(_killer);

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

["tag_eventHandlers.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;