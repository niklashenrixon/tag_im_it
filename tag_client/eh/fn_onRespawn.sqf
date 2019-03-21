/*
*	@Name: onRespawn
*
*	@Description:
*		Triggered when a unit respawns.
*
*	@Parameters:
*		_unit: Object - Object the event handler is assigned to
*		_corpse: Object - Object the event handler was assigned to, aka the corpse/unit player was previously controlling
*
*/

params ["_unit", "_corpse"];

/* Probably dont need this since its set on player when he joins
player enableStamina FALSE; // Remove fatigue / stamina
enableRadio false; // Disable radio
showSubtitles false; // Do not show any text translations from speech
enableSentences false; // Nope
0 fadeRadio 0; // Mute radio
player disableConversation true; // Just.. no..
player setVariable ["BIS_noCoreConversations", true]; // YOU CAN NOT TALK.. GET IT!?
enableSaving [FALSE, FALSE]; // We don't want people to save
*/

// Load player uniform
call tiig_fnc_loadUniform;

// Display message if round in progress and player not part of round
// Maybe i dont need this since its spawned at join
// 0 spawn tiig_fnc_waitForRound;

[player, "tag_lobby", 15] call tiig_fnc_moveToMarker;

// Add camera access when joining if game in progress
if(tag_gameInProgress) then { player addAction ["Spectator camera", { [player] call tiic_fnc_cameraSystem; }]; };

[">>>> EH TRIGGERED: onRespawn <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _corpse: %2",_unit,_corpse],"DEEPDEBUG"] call tiig_fnc_log;