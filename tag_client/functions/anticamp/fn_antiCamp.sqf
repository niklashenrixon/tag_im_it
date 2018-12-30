/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_antiCampSystem.sqf
*	@Location: {TagImIt.Stratis}\{root}\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Anti camping system
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

keyBindArray			  = [];	   						   // Declare empty array
isMoving				  = false; 						   // Declare variable with false value
toggle1					  = false; 						   // Declare variable with false value
toggle2					  = false; 						   // Declare variable with false value
detectorSpawned			  = false; 						   // Declare variable with false value
detectorNotSpawned		  = false; 						   // Declare variable with false value
redeemTime				  = 0;	   						   // Declare variable with 0 value
campTime				  = 0;	   						   // Declare variable with 0 value
warningLevel			  = 0;	   						   // Declare variable with 0 value
campItem				  = 0;	   						   // Declare variable with 0 value
UpdatePlayerAntiCamp	  = [player, getPlayerUID player]; // Declare array with player object and player id
UpdatePlayerAntiCampDeath = [player, getPlayerUID player]; // Declare array with player object and player id

/*
* 	Warning messages
*/
warning1 = "No camping allowed, keep it up and you'll be punished";
warning2 = "Decreasing health 40%. Last warning before crazy things starts happening!";
warning3 = "Decreasing health 20%. Spawning thing above your head now.. told you I was crazy!?";
warning4 = "Still at it huh? Time to die then..";

tag_fn_buildBindKeyArray = { { keyBindArray pushBack _x; } forEach (_this # 0); };

[actionKeys "MoveForward"]	call tag_fn_buildBindKeyArray;
[actionKeys "MoveBack"]		call tag_fn_buildBindKeyArray;
[actionKeys "TurnLeft"]		call tag_fn_buildBindKeyArray;
[actionKeys "TurnRight"]	call tag_fn_buildBindKeyArray;
[actionKeys "MoveUp"]		call tag_fn_buildBindKeyArray;
[actionKeys "MoveDown"]		call tag_fn_buildBindKeyArray;

(findDisplay 46) displayAddEventHandler ["keyDown", "_this call tag_fn_isMoving"];
(findDisplay 46) displayAddEventHandler ["keyUp",	"_this call tag_fn_hasStopped"];

/*
*	Function when moving
*/
tag_fn_isMoving = {
	private ["_keyMoving"];
	_keyMoving = _this # 1;
	if (_keyMoving in keyBindArray) then { isMoving = true; };
};

/*
*	Function when stopped
*/
tag_fn_hasStopped = {
	private ["_keyStopped"];
	_keyStopped = _this # 1;
	if (_keyStopped in keyBindArray) then { isMoving = false; };
};

/*
*	Detector
*/
tag_fn_spawnDetector = {
	antiCampDetector = createTrigger ["EmptyDetector", getPosATL player, false];
	antiCampDetector setTriggerArea [5, 5, 0, false];

	switch (side player) do {
		case west: { antiCampDetector setTriggerActivation ["WEST", "PRESENT", true]; };
		case east: { antiCampDetector setTriggerActivation ["EAST", "PRESENT", true]; };
	};

	antiCampDetector setTriggerStatements ["this",
		"detectorSpawned = true; detectorNotSpawned = false; antiCampStop = 0 spawn tag_fn_doWarning; terminate antiCampMove;",
		"detectorSpawned = false; detectorNotSpawned = true; tag_campTimer = 0; deleteVehicle antiCampDetector; terminate antiCampStop; antiCampMove = 0 spawn tag_fn_whileRunning;"];
};

/*
*	Anti-Camp penelty
*/
tag_fn_doWarning = {
	tag_campTimer = time + (campingTime - campTime);

	while{detectorSpawned} do {

		if (time >= tag_campTimer) then {

			if (warningLevel == 0) then {
				["<t color='#db0015'>Camping Warning #1:</t> " + warning1, 0.6, 0, 0.2, 10, 3010, "any", nil, "local"] call tiig_fnc_messanger;
				publicVariableServer "UpdatePlayerAntiCamp";
			};

			if (warningLevel == 1) then {
			["<t color='#db0015'>Camping Warning #2:</t> " + warning2, 0.6, 0, 0.2, 10, 3010, "any", nil, "local"] call tiig_fnc_messanger;
				player setDamage ((damage player) + 0.4 * (1 - (damage player)));

				publicVariableServer "UpdatePlayerAntiCamp";
			};

			if (warningLevel == 2) then {
				["<t color='#db0015'>Camping Warning #3:</t> " + warning3, 0.6, 0, 0.4, 10, 3010, "any", nil, "local"] call tiig_fnc_messanger;

				player setDamage ((damage player) + 0.2 * (1 - (damage player)));

				if (date # 3 >= 17 || date # 3 <= 6) then {
					campItem = createvehicle ["TagFlareLong", [0,0,0], [], 0, "FLY"];
					campItem attachTo [player, [0,1,2.5]];
				} else {
					campItem = createvehicle ["Land_TentA_F", [0,0,0], [], 0, "FLY"];
					campItem attachTo [player, [0,0,2.5]];
					campItem setDir 180;
				};

				publicVariableServer "UpdatePlayerAntiCamp";
			};

			if (warningLevel == 3) then {
				["<t color='#db0015'>Camping Warning #4:</t> " + warning4, 0.6, 0, 0.4, 10, 3010, "any", nil, "local"] call tiig_fnc_messanger;

				deleteVehicle campItem;

				// Stats variables are set by camper
				player setVariable ["tag_shotsFired", tag_preShotsFired, true];
				player setVariable ["tag_shotsTaken", tag_preShotsTaken, true];
				player setVariable ["tag_shotsHitArray", hitArray, true];

				publicVariableServer "UpdatePlayerAntiCampDeath";

				player setDamage 1;
			};

			warningLevel = warningLevel + 1;
			tag_campTimer = time + campingTime;
			campTime = 0;
		};

		campTime = campTime + 1;
		[["MOVEMENT: Stopped | Camping Time: %1 "], [campTime]] call tag_fn_debugHint;
		sleep 1;
	};
};

/*
*	Anti-Camp Redeem time
*/
tag_fn_whileRunning = {
	while{detectorNotSpawned} do {
		campTime = campTime - (2 min campTime);
		
		if (warningLevel >= 1) then {
			redeemTime = redeemTime + 1;

			if (redeemTime >= 120) then {
				redeemTime = 0;
				warningLevel = 0;

				if ((typeName campItem) == "OBJECT") then {
					deleteVehicle campItem;
				};
			};
		};

		[["MOVEMENT: Running | Camping Time: %1 "], [campTime]] call tag_fn_debugHint;
		sleep 1;
	};
};

/*
*	Movement detector
*/
0 spawn {
	while {alive player} do {
		if (tag_roundStarted && side player != civilian) then {

			if (!toggle1 && isMoving) then {
				toggle1 = true;
				toggle2 = false;
			};

			if (!toggle2 && !isMoving) then {
				toggle1 = false;
				toggle2 = true;

				if (!detectorSpawned) then { [] call tag_fn_spawnDetector; };
			};
		};
		sleep detectionRate;
	};
};

[["tag_antiCampSystem.sqf loaded"], "DEEPDEBUG"] call tagglobal_fnc_log;