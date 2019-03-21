/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_removeWeapons.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Strips all weapons from unit when unit is ready to play a round
*
*	Example(s):
*		0 spawn tiig_fnc_removeWeapons;
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

while{!(player getVariable "tag_unitPlaying")} do {
	sleep 1;
	if (player getVariable "tag_unitPlaying") then {
		removeAllWeapons player;
		terminate _thisScript;
	};
};