/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_clientEventhandlers.sqf
*	@Location: {@mod\addons}\tag_client\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Client-side event handlers
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description: 
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
*	If player is the winner server will trigger this EH
*	Triggered from tag_winner.sqf
*/
"tag_clientIsWinner" addPublicVariableEventHandler {

	playSound "winner1";
	// Stats variables are set by winner
	player setVariable ["tag_shotsFired", tag_preShotsFired, true];
	player setVariable ["tag_shotsTaken", tag_preShotsTaken, true];
	player setVariable ["tag_shotsHitArray", hitArray, true];

	// Terminate Anti Camp System
	//deleteVehicle antiCampDetector;
	//terminate antiCampStop;
	//terminate antiCampMove;
	//terminate tag_antiCampSystem;

	UpdatePlayerRoundStatWinner = [player, (getPlayerUID player)];
	publicVariableServer "UpdatePlayerRoundStatWinner";
};

/*
*	Called from server; eject player from vehicle when called
*/
"tag_ejectVehicle" addPublicVariableEventHandler {
	if (vehicle player != player) then {
		_curVehicle = vehicle player;
		player action ["Eject", _curVehicle];
		_curVehicle lock true;
	};
};

/*
*	If player is in a draw round server will trigger this EH
*/
"tag_reportDraw" addPublicVariableEventHandler {

	// Stats variables are set by player
	player setVariable ["tag_shotsFired", tag_preShotsFired, true];
	player setVariable ["tag_shotsTaken", tag_preShotsTaken, true];
	player setVariable ["tag_shotsHitArray", hitArray, true];

	// Terminate Anti Camp System
	//deleteVehicle antiCampDetector;
	//terminate antiCampStop;
	//terminate antiCampMove;
	//terminate tag_antiCampSystem;

	UpdatePlayerOnDraw = [player, (getPlayerUID player)];
	publicVariableServer "UpdatePlayerOnDraw";
};

["tag_clientEventHandlers.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;
