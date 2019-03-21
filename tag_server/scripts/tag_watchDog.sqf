/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_watchDog.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Checks wish state the game is currently in
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
*	Every second, check how many players are alive
*/
0 spawn {
	tag_twoLeftFired = FALSE;
	tag_winnerFired  = FALSE;
	tag_timeLimitTwoFired = FALSE;
	tag_timeLimitOneFired = FALSE;
	tag_timeLimitThirtyFired = FALSE;

	tag_lootDrop = time + 120;
	tag_dropped = false;

	waitUntil {

		/*
		*	1 vs 1
		*/
		if (tag_playerCount == 2 && !tag_twoLeftFired && !tag_winnerFired) then {
			
			sleep 2;

			tag_timeLimit2 = time + 180;
			tag_timeLimit1 = time + 240;
			tag_timeLimit30 = time + 270;
			tag_timeLimit5 = time + 300;
			tag_twoLeftFired = TRUE;

			if (tag_playerCount == 2) exitWith {
				missionNamespace setVariable ["tag_gameEndgame", true, true];
				["ENTERING MODE: 1 vs 1", "DEBUG"] call tiig_fnc_log;
				tag_1v1 = true; publicVariable "tag_1v1";
				["1 vs 1", 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;

				_HG = headgear tag_playerIt;
				if(_HG != "") then { removeHeadgear tag_playerIt; };

				sleep 6;
				["5 minutes remaining", 0.6, 0, 0.9, 5, 3010, "all", nil, "mp"] call tiig_fnc_messanger;
				playSound3D ["tag_client\sounds\five.ogg", nil, false, tag_activeSiren, 4, 1, 2000];
			};
		};

		/*
		*	Winner
		*/
		if (tag_playerCount == 1 && !tag_winnerFired && !tag_roundIsDraw) then {
			
			sleep 2;
			
			if (tag_playerCount == 1) exitWith {
				tag_winnerFired = TRUE;
				["ENTERING MODE: Winner", "DEBUG"] call tiig_fnc_log;

				missionNamespace setVariable ["tag_gameInProgress", false, true];
				missionNamespace setVariable ["tag_gameEndgame", false, true];
				missionNamespace setVariable ["tag_gameFinished", true, true];
				
				missionNamespace setVariable ["tag_timeRoundDuration", round(time - tag_timeRoundBegin), true];

				[tag_roundID, tag_timeRoundDuration] call tiis_fnc_updateServerStats;

				_winnerObject = []; {
					if (side _x == east || side _x == west) then {
						_winnerObject pushBack _x;
					};
				} forEach playableUnits;

				_winner = _winnerObject select 0;
				[_winner] joinSilent (createGroup east);
				_winnerName = name _winner;

				if(_winner == (missionNamespace getVariable "tag_firstIt")) then {
					_winner setVariable ["tag_unitScore", TAG_SCORE_FIRST, true];
				};

				[0, 1.5, false, false] remoteExecCall ["BIS_fnc_cinemaBorder", owner _winner];

				["And the winner is " + _winnerName, 1, 0, 0.7, 15, 1337, "CivExlusive", _winner, "mp"] call tiig_fnc_messanger;
				["Congratulations, you are the winner!", 1, 0, 0.7, 15, 1337, "specific", _winner, "mp"] call tiig_fnc_messanger;

				_winner setVariable ["tag_unitLifespan", round(time - tag_timeRoundBegin), true];
				_timeBeginIT = _winner getVariable "tag_unitTimeITBegin";
				if(_winner getVariable "tag_unitIsIT") then { _winner setVariable ["tag_unitLifespanIT", round(time - _timeBeginIT), true]; };

				// Unit cant be IT and is not playing anymore
				_winner setVariable ["tag_unitPlaying", false, true];
				_winner setVariable ["tag_unitIsIT", false, true];

				// Delete dead unit from player list
				_pList = missionNamespace getVariable "tag_playerList";;
				_pList deleteAt (_pList find _winner);
				missionNamespace setVariable ["tag_playerList", _pList, true];

				// Delete shot marker
				deleteMarker (getPlayerUID(_winner) + "_solid");
				deleteMarker (getPlayerUID(_winner) + "_text");

				[_winner] spawn tiis_fnc_reportStats;

				sleep 10;
				["END1", TRUE, 5] spawn BIS_fnc_endMission;
				TRUE
			};
		};

		/*
		*	No one is alive and winner didn't fire
		*/
		if (tag_playerCount == 0) exitWith { // No winner

			sleep 2;

			if (tag_playerCount == 0 && !tag_winnerFired) then {
				["ENTERING MODE: No one alive", "DEBUG"] call tiig_fnc_log;

				missionNamespace setVariable ["tag_gameInProgress", false, true];
				missionNamespace setVariable ["tag_gameEndgame", false, true];
				missionNamespace setVariable ["tag_gameFinished", true, true];

				[0, 1.5, false, false] remoteExecCall ["BIS_fnc_cinemaBorder", -2];
				["No winner was declared", 1, 0, 0.7, 15, 1337, "all", nil, "mp"] call tiig_fnc_messanger;

				sleep 10;
				["END1", TRUE, 5] spawn BIS_fnc_endMission;
				TRUE
			};
		};

		/*
		*	Match is at 2.5 mins left
		*/
		if (tag_twoLeftFired && tag_playerCount == 2 && !tag_winnerFired) then {
			if (time >= tag_timeLimit2 && !tag_timeLimitTwoFired) exitWith {
				tag_timeLimitTwoFired = TRUE;
				["2 minutes remaining", 0.6, 0, 0.9, 5, 3010, "all", nil, "mp"] call tiig_fnc_messanger;
				playSound3D ["tag_client\sounds\two.ogg", nil, false, tag_activeSiren, 4, 1, 2000];
			};
		};

		/*
		*	Match is at 1 min left
		*/
		if (tag_twoLeftFired && tag_playerCount == 2 && !tag_winnerFired) then {
			if (time >= tag_timeLimit1 && !tag_timeLimitOneFired) exitWith {
				tag_timeLimitOneFired = TRUE;
				["1 minute remaining", 0.6, 0, 0.9, 5, 3010, "all", nil, "mp"] call tiig_fnc_messanger;
				playSound3D ["tag_client\sounds\one.ogg", nil, false, tag_activeSiren, 4, 1, 2000];
			};
		};

		/*
		*	Match is at 30 sec left
		*/
		if (tag_twoLeftFired && tag_playerCount == 2 && !tag_winnerFired) then {
			if (time >= tag_timeLimit30 && !tag_timeLimitThirtyFired) exitWith {
				tag_timeLimitThirtyFired = TRUE;
				["30 seconds remaining", 0.6, 0, 0.9, 5, 3010, "all", nil, "mp"] call tiig_fnc_messanger;
				playSound3D ["tag_client\sounds\thirty.ogg", nil, false, tag_activeSiren, 4, 1, 2000];
			};
		};

		/*
		*	Time is up (5 mins)
		*/
		if (tag_twoLeftFired && tag_playerCount == 2) then {
			if (time >= tag_timeLimit5 && !tag_winnerFired) exitWith {
				sleep 2;

				missionNamespace setVariable ["tag_gameInProgress", false, true];
				missionNamespace setVariable ["tag_gameEndgame", false, true];
				missionNamespace setVariable ["tag_gameFinished", true, true];

				if(tag_playerCount >= 2) then {

					{ if(side _x != resistance && side _x != civilian) then {

							_x setVariable ["tag_unitLifespan", round(time - tag_timeRoundBegin), true];
							_timeBeginIT = _x getVariable "tag_unitTimeITBegin";
							if(_x getVariable "tag_unitIsIT") then { _x setVariable ["tag_unitLifespanIT", round(time - _timeBeginIT), true]; };

							// Unit cant be IT and is not playing anymore
							_x setVariable ["tag_unitPlaying", false, true];
							_x setVariable ["tag_unitIsIT", false, true];

							// Delete dead unit from player list
							_pList = missionNamespace getVariable "tag_playerList";;
							_pList deleteAt (_pList find _x);
							missionNamespace setVariable ["tag_playerList", _pList, true];

							// Delete shot marker
							deleteMarker (getPlayerUID(_x) + "_solid");
							deleteMarker (getPlayerUID(_x) + "_text");

							[_x] spawn tiis_fnc_reportStats;
						};
						sleep 1.5;
					} forEach playableUnits;
				};

				[0, 1.5, false, false] remoteExecCall ["BIS_fnc_cinemaBorder", -2];
				["Times up! It's a draw", 1, 0, 0.7, 15, 1337, "all", nil, "mp"] call tiig_fnc_messanger;
				sleep 10;
				["END1", TRUE, 5] spawn BIS_fnc_endMission;

				TRUE
			};
		};

		/*
		*	Supply Drop
		*/
		if (time >= tag_lootDrop && !tag_dropped && !tag_winnerFired) then {
			tag_dropped = TRUE;
			0 spawn tiis_fnc_supplyDrop;

			// TEMP spawning of loot in supply drop
			waitUntil {!isNil "tag_supplyDrop"};

			tag_supplyDrop addItemCargoGlobal ["Medikit", 2];
			tag_supplyDrop addItemCargoGlobal ["FirstAidKit", 5];
			tag_supplyDrop addItemCargoGlobal ["optic_DMS", 1];
			tag_supplyDrop addItemCargoGlobal ["V_PlateCarrierH_CTRG", 1];
			tag_supplyDrop addItemCargoGlobal ["hlc_muzzle_300blk_KAC", 1];
			tag_supplyDrop addWeaponCargoGlobal ["srifle_GM6_F", 1];
			tag_supplyDrop addWeaponCargoGlobal ["hlc_rifle_Bushmaster300", 1];
			tag_supplyDrop addWeaponCargoGlobal ["hlc_rifle_vendimus", 1];

			_weaponList =  ["srifle_GM6_F", "hlc_rifle_Bushmaster300", "hlc_rifle_vendimus"];
			{
			 	_weapon = _x;
			 	_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
				_magazineClass = _magazines call bis_fnc_selectRandom;

				tag_supplyDrop addMagazineCargoGlobal [_magazineClass, 2];

			} forEach _weaponList;
		};

		sleep 0.3;
	};
};

["tag_watchDog.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;