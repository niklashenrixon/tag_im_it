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
				["ENTERING MODE: 1 vs 1", "DEBUG"] call tiig_fnc_log;
				tag_1v1 = true; publicVariable "tag_1v1";
				[tag_m_OneVsOne, 1, 0, 0.7, 5, 1337, "all", nil, "mp"] call tiig_fnc_messanger;

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

				tag_roundInProgress = false; publicVariable "tag_roundInProgress";
				tag_roundStarted = false; publicVariable "tag_roundStarted";

				_winnerObject = []; {
					if (side _x == east || side _x == west) then {
						_winnerObject pushBack _x;
					};
				} forEach playableUnits;

				_winner = _winnerObject select 0;
				[_winner] joinSilent (createGroup east);
				_winnerName = name _winner;

				[[0, 1.5, false, false], "BIS_fnc_cinemaBorder", _winner, false, true] call BIS_fnc_MP;
				["And the winner is " + _winnerName, 1, 0, 0.7, 15, 1337, "CivExclude", _winner, "mp"] call tiig_fnc_messanger;
				["Congratulations, you are the winner!", 1, 0, 0.7, 15, 1337, "specific", _winner, "mp"] call tiig_fnc_messanger;

				/*
				*	Tell player he/she is winner
				*/
				_pcIdWinner = owner _winner;
				tag_clientIsWinner = [];
				_pcIdWinner publicVariableClient "tag_clientIsWinner";

				[_winner] spawn tiis_fnc_reportStats;

				tag_roundComplete = TRUE;
				publicVariable "tag_roundComplete";

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

				tag_roundInProgress = false; publicVariable "tag_roundInProgress";
				tag_roundStarted = false; publicVariable "tag_roundStarted";

				[[0, 1.5, false, false], "BIS_fnc_cinemaBorder", true, false, true] call BIS_fnc_MP;
				["No winner was declared", 1, 0, 0.7, 15, 1337, "all", nil, "mp"] call tiig_fnc_messanger;

				tag_roundComplete = TRUE;
				publicVariable "tag_roundComplete";

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

				tag_roundInProgress = false; publicVariable "tag_roundInProgress";
				tag_roundStarted = false; publicVariable "tag_roundStarted";

				if(tag_playerCount == 2) then {

					tag_roundIsDraw = true;
					publicVariable "tag_roundIsDraw";

					{
						if(side _x != civilian) then {
							_pcIdDraw = owner _x;
							tag_reportDraw = [];
							_pcIdDraw publicVariableClient "tag_reportDraw";
						};
						sleep 1.5;
					} forEach playableUnits;

					["Times up! It's a draw", 1, 0, 0.7, 15, 1337, "all", nil, "mp"] call tiig_fnc_messanger;
				};

				tag_roundComplete = TRUE;
				publicVariable "tag_roundComplete";

				[[0, 1.5, false, false], "BIS_fnc_cinemaBorder", true, false, true] call BIS_fnc_MP;
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
			tag_supplyDrop addItemCargoGlobal ["kio_muzzle_sr25S", 1];
			tag_supplyDrop addItemCargoGlobal ["hlc_muzzle_300blk_KAC", 1];

			tag_supplyDrop addWeaponCargoGlobal ["srifle_GM6_F", 1];
			tag_supplyDrop addWeaponCargoGlobal ["hlc_rifle_Bushmaster300", 1];
			tag_supplyDrop addWeaponCargoGlobal ["kio_sr25", 1];
			tag_supplyDrop addWeaponCargoGlobal ["hlc_rifle_vendimus", 1];

			_weaponList =  ["srifle_GM6_F", "hlc_rifle_Bushmaster300", "hlc_rifle_vendimus", "kio_sr25"];
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