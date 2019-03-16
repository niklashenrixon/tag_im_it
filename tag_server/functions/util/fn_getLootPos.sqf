/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_getLootPos.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Writes houseId, houseType, posX, posY, posZ and mapName to MySQL
*
*	Example(s):
*		["markerName", TRUE] call tiis_fnc_getLootPos;
*
*	Parameter(s):
*		0 ARRAY (Mandatory):
*			Array with a house object
*
*	Returns:
*		nothing
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [
	["_mkr", "MARKERNAME", [""]],
	["_showLoot", false],
	"_distance",
	"_houseList",
	"_weaponsLoot",
	"_itemsLoot",
	"_clothesLoot",
	"_vestsLoot",
	"_exclusionList",
	"_types"
];
if(_mkr == "MARKERNAME") exitWith { ["tiis_fnc_getLootPos: Provide a real marker name"] call tiig_fnc_log; };

_startTime = time;

_types = ["exclusions", "weapons", "items", "clothes", "vests"];

_weaponsLoot   = [];
_itemsLoot	   = [];
_clothesLoot   = [];
_vestsLoot	   = [];
_exclusionList = [];

_mkr    setMarkerAlpha 0;
_pos  = markerPos _mkr;
_mkrY = getMarkerSize _mkr select 0;
_mkrX = getMarkerSize _mkr select 1;

_distance = _mkrX;

if (_mkrY > _mkrX) then {
	_distance = _mkrY;
};

_houseList = _pos nearObjects ["House", _distance];

{
	_house = _x;
	_houseId = [_house] call tiis_fnc_getObjectId;
	_houseType = typeOf _house;

	if (!(typeOf _house in _exclusionList)) then {

		for "_n" from 0 to 100 do {

			_buildingPos = _house buildingPos _n;

			if (str _buildingPos == "[0,0,0]") exitwith {};

			_pos  =	_buildingPos;
			_pos0 =	(_pos select 0);
			_pos1 =	(_pos select 1);
			_pos2 =	(_pos select 2);

			_can = createVehicle ["Land_Can_V1_F", [_pos0, _pos1, _pos2+0.2], [], 0, "CAN_COLLIDE"];
			sleep 2;

			_query = format ["writeLootPos:%1:%2:%3:%4:%5:%6", _houseId, _houseType, _pos0, _pos1, (getPosATL _can select 2), tag_worldName];
			[_query, 1, true] call tiis_fnc_aSync;

			deleteVehicle _can;

			[["INDEXING LOOT POSITION | house id: %1 | house type: %2 | X: %3 | Y: %4 | Z: %5 | World: %6", _houseId, _houseType, _pos0, _pos1, (getPosATL _can select 2), tag_worldName], "DEBUG"] call tiig_fnc_log;
		};
	};
} foreach _houseList;

_endTime = time;

_timeElapsed = _endTime - _startTime;
_timeElapsedM = _timeElapsed / 60;

[["POSITIONS INDEXED SUCCESSFULLY | Time elapsed: %1m", _timeElapsedM], "DEBUG"] call tiig_fnc_log;