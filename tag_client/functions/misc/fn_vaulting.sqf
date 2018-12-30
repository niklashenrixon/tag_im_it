/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_vaulting.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Enable vault animation for unit when running in-game
*
*		Originally created by "ProGamer"
*		http://www.armaholic.com/page.php?id=24323
*
*	3rd party (scripts, functions, addons):
*		@Author: ProGamer
*		@Description: Running Vault Mod
*		@Usage: -
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
*	Eventhandler gets triggered when unit is pressing a key
*/
"vaultAnim" addPublicVariableEventHandler {
	(_this # 1) spawn tag_fn_doAnimation;
};

/*
*	Set animation to "vaulting"
*/
tag_fn_doAnimation =
{
	private ["_unit","_anim"];
	_unit = _this # 0;
	_anim = _this # 1;
	_unit switchMove _anim;
};

/*
*	Wait for key to be pressed
*/
tag_fn_keyPress = {
	private ["_r","_height","_vel","_dir","_speed"];
	_r = false;
	if ((inputAction "getOver" > 0) && (((inputAction "Turbo" > 0)) || ((inputAction "MoveFastForward" > 0)) || ((speed player > 15)))) then {
		_r = true;
		if  (player == vehicle player && player getvariable ["jump",true] && isTouchingGround player && stance player == "STAND") then {

			player setvariable ["jump",false];
			_height = 3.5-((load player));
			_vel = velocity player;
			_dir = direction player;
			_speed = 0.4;
			player setVelocity [(_vel # 0)+(sin _dir*_speed),(_vel # 1)+(cos _dir*_speed),_height];
			vaultAnim = [player,"AovrPercMrunSrasWrflDf"];
			_lastAnim = animationState player;
			publicVariable "vaultAnim";
			player switchMove "AovrPercMrunSrasWrflDf";
			_lastAnim spawn {uiSleep 0.73;player switchMove _this;player setvariable ["jump",true];};
		};
	};
};

/*
*	Display-eventhandler for keyDown
*/
waituntil {!(IsNull (findDisplay 46))};
(FindDisplay 46) displayAddEventHandler ["keydown","nul = player call tag_fn_keyPress"];

["tag_vaultAnimation.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;