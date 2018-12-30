/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_soundDanger.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		When in 1v1 mode, play danger sound then players get in given range of each other
*
*	Example(s):
*		[_range(NUMBER)] spawn tiig_fnc_soundDanger;
*
*	Parameter(s):
*		0 NUMBER (Mandatory):
*			Of far in meters the danger sound should start playing
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

params ["_area"];

waitUntil {
	if (({side _x != civilian} count playableUnits) == 2 && ({side _x == east} count playableUnits) == 1 && tag_gameInProgress) exitWith {

		_trg = createTrigger ["EmptyDetector", getPos player];
		_trg setTriggerArea [_area, _area, 0, false];
		_trg setTriggerStatements ["this", "sound1 = 'Land_HelipadEmpty_F' createVehicle position player; sound1 attachTo [player]; sound1 say 'jaws1';", "deleteVehicle sound1;"];

		switch (side player) do {
			case west: { _trg setTriggerActivation ["EAST", "PRESENT", true]; };
			case east: { _trg setTriggerActivation ["WEST", "PRESENT", true]; };
		};

		while {alive player} do {
			_trg setPos getPos player;
			sleep 0.5;
		};

		TRUE
	};
	
	sleep 2;
};