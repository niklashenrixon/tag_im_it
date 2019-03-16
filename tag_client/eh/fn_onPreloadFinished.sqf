/*
*	@Name: onPreloadFinished
*
*	@Description:
*		Executes assigned code after the mission preload screen. Stackable.
*
*	@Parameters:
*
*/

// Make sure player is really loaded in to game and ready to recieve stuff
waitUntil { !isNull player && isPlayer player };
waitUntil { getClientState == "BRIEFING READ" };
waitUntil { alive player };
waitUntil { time > 1 };
waitUntil { isTouchingGround player };

// Send client version to server for verification
tag_checkVersion = [player, tag_clientVersion, tag_clientVersionString]; publicVariableServer "tag_checkVersion";

// Wait for client version verification before continuing with loading
waitUntil { (player getVariable ["tag_unitVersionAllowed", false]) && !tag_unitBanned };

[player] joinSilent (createGroup resistance);

// Remove blur effect from client after version verifications
'dynamicBlur' ppEffectEnable true;
'dynamicBlur' ppEffectAdjust [0];
'dynamicBlur' ppEffectCommit 1;
1 fadeSound 1;

player enableStamina FALSE; // Remove fatigue / stamina
enableRadio false; // Disable radio
showSubtitles false; // Do not show any text translations from speech
enableSentences false; // Nope
0 fadeRadio 0; // Mute radio
player disableConversation true; // Just.. no..
player setVariable ["BIS_noCoreConversations", true]; // YOU CAN NOT TALK.. GET IT!?
enableSaving [FALSE, FALSE]; // We don't want people to save

// Move player to lobby area
[player, "tag_lobby", 20] call tiig_fnc_moveToMarker;

// Remove Satellite Image from Map
call tiig_fnc_mapTextures;

// Adds custom animations
call tiig_fnc_animations;

// Display scoreboard while TAB is pressed
call tiic_fnc_showScore;

// Display welcome message
call tiic_fnc_showWelcome;

// Load player uniform
call tiig_fnc_loadUniform;

// Set marker of each player on map
[] call tiig_fnc_mapMarkers;

// Adds IT Helmet script
0 spawn tiig_fnc_itHelmet;

// Enable vault animation
0 spawn tiig_fnc_vaulting;

// Load HUD
0 spawn tiic_fnc_showHud;

// Display message if round in progress and player not part of round
0 spawn tiig_fnc_waitForRound;

// Wait until round starts then force player inside playground
0 spawn tiig_fnc_playGround;

// Start danger song
[TAG_DANGERSOUND] spawn tiig_fnc_soundDanger;


/*
*
*
*	LEGACY CODE TO BE CONVERTED
*
*
*/

// Enable anti-camping system
//tag_antiCampSystem  = 0 spawn tag_fn_antiCampSystem;

// Strip all weapons from player after player has been moved
tag_removeWeapons = [] spawn {
	while{!tag_playersMoved} do {
		sleep 2;
		if (tag_playersMoved) then {
			terminate tag_removeWeapons;
		};
	};
};

// Load client eventhandlers
#include "\tag_client\scripts\tag_clientEventhandlers.sqf"

//tag_giveMeClothes = [player, (getPlayerUID player)];
//publicVariableServer "tag_giveMeClothes";

tag_amIBanned = [player, (getPlayerUID player)];
publicVariableServer "tag_amIBanned";

// spawn camera when joining if round in progress
if (tag_roundInProgress) then {
	player addWeapon "ItemGPS";
	player addAction ["Spectator camera", { tag_inCam = [player] spawn tiic_fnc_cameraSystem; }];
	player addAction ["Show camera instructions", { [] call tag_fn_cameraHint; }];
};

[">>>> EH TRIGGERED: onPreloadFinished <<<<","DEEPDEBUG"] call tiig_fnc_log;