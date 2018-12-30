/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_initClient.sqf
*	@Location: \{root}\init\client
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*
*	Example(s):
*
*	Parameter(s):
*		
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

// If server, be gone!
if(isDedicated || isServer) exitWith {};

// Load defined variables
#include "\tag_client\data\clientVars.sqf";

// Add eventhandlers to player
_ehMPKILLED		= player addMPEventHandler ["MPKilled",     { _this call tiic_fnc_onKilled; }];       // Player got killed; broadcasted globally
_ehMPHIT		= player addMPEventHandler ["MPHit",        { _this call tiic_fnc_onHit; }];          // Player got hit; broadcasted globally
_ehRESPAWN		= player addEventHandler   ["Respawn",      { _this call tiic_fnc_onRespawn; }];      // Player respawned due to death
_ehFIRED		= player addEventHandler   ["Fired",        { _this call tiic_fnc_onFired; }];        // Player fired a weapon
_ehHANDLEDAMAGE = player addEventHandler   ["HandleDamage", { _this call tiic_fnc_onHandleDamage; }]; // Player was damaged
_ehHANDLEHEAL   = player addEventHandler   ["HandleHeal",   { _this call tiic_fnc_onHandleHeal; }];   // Player is using medical
"tag_unitBanned" addPublicVariableEventHandler { tag_unitBanned = _this select 1; };
addMissionEventHandler ["PreloadFinished", { 0 spawn tiic_fnc_onPreloadFinished; }];
addMissionEventHandler ["Ended",{ _this call tiic_fnc_onEnded; }];

// Give player neccessary variables
player setVariable ["tag_unitIdentity", [player, getPlayerUID player, netId player, clientOwner], true]; // Unit identity; usefull for server
player setVariable ["tag_unitShotsFired", 0, true];         // How many bullets the unit has shot
player setVariable ["tag_unitShotsTaken", 0, true];         // How many times the player has been hit by a shot
player setVariable ["tag_unitTrail", [[0,0,0]], true];      // Array of tracking positions of player
player setVariable ["tag_unitDistanceTraveled", 0, true];   // Number of meters that unit has traveled when in a round
player setVariable ["tag_unitIsIT", false, true];           // Unit is IT
player setVariable ["tag_unitSpectating", false, true];     // Unit is spectating a round
player setVariable ["tag_unitPlaying", false, true];        // Unit is in-game and playing a round
player setVariable ["tag_unitVersionAllowed", false, true]; // Addon version is the same as server

// Set blur effect on player until client version is verified
'dynamicBlur' ppEffectEnable true;
'dynamicBlur' ppEffectAdjust [5];
'dynamicBlur' ppEffectCommit 2;
2 fadeSound 0.2;