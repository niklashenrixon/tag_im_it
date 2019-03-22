private ["_pos1", "_rds", "_steps", "_radStep", "_pos2", "_wallA", "_wallB", "_retA"];

_spawned = player getVariable "tag_unitDeathCircle";
if(!_spawned) then {
	tag_circleRetA = [];
	tag_circleRetB = [];

	_pos1 = tag_playGroundSettings select 0;
	_rds = tag_playGroundSettings select 1;

	_steps = floor ((2 * pi * _rds) / 15); // 5 meter steps
	_radStep = 360 / _steps;

	for "_i" from 0 to 360 do {
		_pos2 = _pos1 getPos [_rds, _i];
		_pos2 set [2, 0];

		_wallA = "UserTexture10m_F" createVehicleLocal _pos2;
		_wallA setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
		_wallA enableSimulation FALSE;
		_wallA setPosATL _pos2;
		_wallA setDir _i;
		tag_circleRetA = tag_circleRetA + [_wallA];

		_wallB = "UserTexture10m_F" createVehicleLocal _pos2;
		_wallB setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
		_wallB enableSimulation FALSE;
		_wallB setPosATL _pos2;
		_wallB setDir (_i + 180);
		tag_circleRetB = tag_circleRetB + [_wallB];

		_i = _i + _radStep;

		uiSleep 0.005;
	};

	player setVariable ["tag_unitDeathCircle", true, true];
};

terminate _thisScript;