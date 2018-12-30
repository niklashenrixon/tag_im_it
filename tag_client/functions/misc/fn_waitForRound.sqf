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

while{side player == civilian && tag_gameInProgress} do {
	_spec = player getVariable "tag_unitSpectating";
	if(!_spec) then {
		_pL = {side _x != civilian} count playableUnits;
		if (_pL >= 2) then {
			["Round in progress. Players left in round: " + str(_pL), 1, 0, 0.7, 5, 1347, "any", nil, "local"] call tiig_fnc_messanger;
		};
	};
	sleep 15;
};