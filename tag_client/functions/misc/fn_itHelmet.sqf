/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_itHelmet.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Add red it helmet to player if game is in progress
*		also removes helmet if player is not IT
*
*	Example(s):
*		0 spawn tiig_fnc_itHelmet;
*
*	Parameter(s):
*
*	Returns:
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

while{alive player} do {
	_hg = headgear player;
	_unitIt = player getVariable "tag_unitIsIT";

	if(_unitIt && tag_gameInProgress && (_hg != "TagHelmet")) then { player addHeadgear "TagHelmet"; };
	if(!_unitIt && tag_gameInProgress && (_hg == "TagHelmet")) then { removeHeadgear player; };
	sleep 1;
};