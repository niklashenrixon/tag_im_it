/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_waitForRound.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Players who join or is killed during a round will see this
*
*	Example(s):
*		call tiig_fnc_waitForRound;
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

waitUntil { tag_gameInProgress };

private ["_spec","_pL"];

while{!(player getVariable "tag_unitPlaying") && tag_gameInProgress} do {
	if(!(player getVariable "tag_unitSpectating")) then {
		_pL = {side _x != resistance} count playableUnits;
		if (_pL >= 2) then {
			["Game in progress. Players left in round: " + str(_pL), 1, 0, 0.7, 5, 1347, "any", nil, "local"] call tiig_fnc_messanger;
		};
	};
	sleep 15;
};