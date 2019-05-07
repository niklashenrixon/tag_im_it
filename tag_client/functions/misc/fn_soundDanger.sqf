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

waitUntil {	if (player getVariable "tag_unitPlaying") exitWith { TRUE }; };
waitUntil {	if (tag_gameInProgress) exitWith { TRUE }; };
waitUntil {	if (tag_playerCount == 2) exitWith { TRUE }; };

_outside = false;

playSound "jaws1";

while { tag_gameInProgress && player getVariable "tag_unitPlaying" && tag_playerCount == 2 } do {

	_pos = tag_playGroundSettings select 0;
	_size = tag_playGroundSettings select 1;
	_dc = player getVariable "tag_unitDeathCircle";

	if(_dc) then {
		if(((player distance _pos)-0.5) > _size && !_outside) then { _outside = TRUE; tag_outsideTime = time + 3 };
		if(((player distance _pos)-0.5) <= _size && _outside) then { _outside = FALSE; };

		if (_outside) then {
			_message = "YOU ARE OUTSIDE THE PLAYZONE";
			_fMessage = format["<t color='#db0015'>%1</t>", _message];
			[_fMessage, 1, 0, 0.5, 15, 9025, 'any', nil, 'local'] call tiig_fnc_messanger;
			'dynamicBlur' ppEffectEnable true;
			'dynamicBlur' ppEffectAdjust [5];
			'dynamicBlur' ppEffectCommit 2;
			2 fadeSound 0.2;

			if(time >= tag_outsideTime) then {
				tag_outsideTime = time + 3;
				player setDamage (damage player + 0.2);
				if(damage player >= 0.5) then { player setHitPointDamage ["hitLegs", 0.48]; };
				[["Damage player: %1", damage player]] call tiig_fnc_log;
			};
		};

		if (!_outside) then {
			['', 1, 0, 0.5, 0.5, 9025, 'any', nil, 'local'] call tiig_fnc_messanger;
			'dynamicBlur' ppEffectEnable true;
			'dynamicBlur' ppEffectAdjust [0];
			'dynamicBlur' ppEffectCommit 1;
			1 fadeSound 1; 
		};
	};
	sleep 0.2;
};

// Remove warning if unit goes outside while loop
['', 1, 0, 0.5, 0.5, 9025, 'any', nil, 'local'] call tiig_fnc_messanger;
'dynamicBlur' ppEffectEnable true;
'dynamicBlur' ppEffectAdjust [0];
'dynamicBlur' ppEffectCommit 1;
1 fadeSound 1;


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