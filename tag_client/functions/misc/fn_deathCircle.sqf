private ["_pos1", "_rds", "_steps", "_radStep", "_pos2", "_wallA", "_wallB", "_retA"];

_retA = [];
_retB = [];
//_pos1 = param [0, getMarkerPos "tag_playArea", [[]]];
//_pos1 = getMarkerPos "tag_playArea";
//_rds = (getMarkerSize "tag_playArea") select 0;

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
	_retA = _retA + [_wallA];

	_wallB = "UserTexture10m_F" createVehicleLocal _pos2;
	_wallB setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
	_wallB enableSimulation FALSE;
	_wallB setPosATL _pos2;
	_wallB setDir (_i + 180);
	_retB = _retB + [_wallB];
	
	_i = _i + _radStep;
};