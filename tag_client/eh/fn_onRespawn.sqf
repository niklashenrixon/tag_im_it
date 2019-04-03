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

// Load player uniform
call tiig_fnc_loadUniform;

[player, "tag_lobby", 15] spawn tiig_fnc_moveToMarker;

// Add camera access when joining if game in progress
if(tag_gameInProgress) then { player addAction ["Spectator camera", { [player] call tiic_fnc_cameraSystem; }]; };

[">>>> EH TRIGGERED: onRespawn <<<<","DEEPDEBUG"] call tiig_fnc_log;
[["_unit: %1 | _corpse: %2",_unit,_corpse],"DEEPDEBUG"] call tiig_fnc_log;