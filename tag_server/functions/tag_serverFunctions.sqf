/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_serverFunctions.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Global functions library only serverside
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////



/*
*	@Name: tag_fn_getObjectId
*	@Description: Call function with an object and it returns the id number of that object
*	@Version: 0.0.1
*	@Usage: [_house] call tag_fn_getObjectId;
*	@Return: House ID number
*/
tag_fn_getObjectId = {
	private ["_object","_sn","_sf","_ef","_na","_id","_i","_item"];

	_object = _this select 0;

	_sn = toArray (str (_object));

	_sf = false;_ef = false;_na = [];_id = 0;

	for "_i" from 0 to (count _sn)-1  do {
		_item = _sn select _i;
		if (_sf and (not (_ef))) then {
			_na set [count _na,_item];
		};
		if (_item == 35) then {
			_sf = true;
		};
		if (_item == 58) then {
			_ef = true;
		};
	};

	if ((count _na) >=3) then {
		_na set [((count _na)-1) ,"delete"];
		_na = _na - ["delete"];
		_na set [0 ,"delete"];
		_na = _na - ["delete"];
		_id = toString (_na);
	};

	_id
};

/*
*	@Name: tag_fn_getLootPos
*	@Description: Writes houseId, houseType, posX, posY, posZ and mapName to MySQL
*	@Version: 0.0.1
*	@Usage: ["markerName", TRUE] call tag_fn_getLootPos;
*	@Return: nothing
*/
tag_fn_getLootPos = {
	private ["_distance", "_houseList", "_mkr", "_showLoot", "_data", "_weaponsLoot", "_itemsLoot", "_clothesLoot", "_vestsLoot", "_exclusionList", "_types"];

	_startTime = time;

	_data 	  = _this;
	_mkr 	  = _data select 0;
	_showLoot = _data select 1;

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
		_houseId = [_house] call tag_fn_getObjectId;
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
};

/*
*	@Name: tag_fn_messageSystem
*	@Description: Server sends messages in system chat
*	@Version: 0.0.1
*	@Usage: 0 spawn tag_fn_messageSystem;
*	@Return: nothing
*/
tag_fn_messageSystem = {
	
	_pause = 50;

	_messages = ["WELCOME TO TAG I'M IT!",
				 "VISIT THE WEBSITE AT | www.tagimit.eu",
				 "CHECK YOUR STATS AT | www.tagimit.eu/leaderboard",
				 "REMEMBER, THIS MOD IS UNDER DEVELOPMENT. SO IF YOU ENCOUNTER A BUG, PLEASE REPORT IT AT THE BOTTOM OF THE WEBSITE"
				];

	_doMessage = TRUE;
	_messageCount = 0;

	while{_doMessage} do {

		{
			[format [_x], "systemChat", true, false, true] spawn BIS_fnc_MP;
			sleep _pause;
		} forEach _messages;
		
		_messageCount = _messageCount + 1;

		if (_messageCount >= 50) then {
			_doMessage = FALSE;
		};
	};
};

/*
*	@Name: tag_fn_strip
*	@Description:
*		Strips semicolon from String.
*		Needed for parser Player Name etc since extDB uses : as seperator character
*	@Version: 0.0.1
*	@Usage: [STRING (clientID)] call tag_fn_strip;
*	@Return: Client ID stripped of semicolon
*/
tag_fn_strip = {
	private["_string","_array"];

	_string = (_this select 0);

	_array = toArray _string;
	{
		if (_x == 58) then
		{
			_array set[_forEachIndex, -1];
		};
	} foreach _array;
	_array = _array - [-1];
	_string = toString _array;
	_string
};

["tag_serverFunctions.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;