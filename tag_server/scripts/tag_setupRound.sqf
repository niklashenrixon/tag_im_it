/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_roundMilitary.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Prepair map for a round
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Variable declaration */ 
_maps = [];
_sirens = [];
_houseIdArray = [];
tag_lootPositions = [];

/* Loop through possible "maps" and add it to list */
for "_i" from 1 to 50 do {
	_map   = format ["tag_map%1", _i];
	_siren = format ["tag_siren%1", _i];

	if (getMarkerType _map != "" && getMarkerType _map == "ELLIPSE") then {
		_maps pushBack _map;
		_sirens pushBack _siren;
		_map setMarkerAlpha 0;
	};
};

/* Choose one of the maps to start a game on */
_rLocation = floor random count _maps;
tag_activeMap = _maps select _rLocation;

_sirenTemp = _sirens select _rLocation;
_objSiren = call compile _sirenTemp;
tag_activeSiren = getPosASL _objSiren;

/* Randomize a position inside chosen map as center of game */
_mPos = getMarkerPos tag_activeMap;
_mPosX = _mPos select 0;
_mPosY = _mPos select 1;
_mkrX = getMarkerSize tag_activeMap select 0;
_mkrY = getMarkerSize tag_activeMap select 1;
_mapCenter = [_mkrY-30, _mkrX-30, _mPosX, _mPosY] call tiig_fnc_rand2d;

/* X and Y of center in the chosen map */
_mapX = (_mapCenter select 0);
_mapY = (_mapCenter select 1);

/* Calculate the size of the playable area */
_markerSize = 100 * (1 max (round (tag_playerCount2 / 5)));

missionNamespace setVariable ["tag_playGroundSettings", [[_mapX, _mapY, 0], _markerSize], TRUE];

/* Spawn visible play area on map */
_pArea = createMarker ["tag_playArea",[_mapX, _mapY]];
_pArea setMarkerShape "ELLIPSE";
_pArea setMarkerType "ELLIPSE";
_pArea setMarkerBrush "Border";
_pArea setMarkerColor "ColorRed";
_pArea setMarkerSize [_markerSize, _markerSize];

/* Spawn loot area */
_lootArea = createMarker ["tag_lootArea",[_mapX, _mapY]];
_lootArea setMarkerShape "ELLIPSE";
_lootArea setMarkerType "ELLIPSE";
_lootArea setMarkerSize [_markerSize+20, _markerSize+20];
_lootArea setMarkerAlpha 0;

/* Spawn supply drop area */
_dropArea = createMarker ["tag_supplyDrop",[_mapX, _mapY]];
_dropArea setMarkerShape "ELLIPSE";
_dropArea setMarkerType "ELLIPSE";
_dropArea setMarkerSize [_markerSize-10, _markerSize-10];
_dropArea setMarkerAlpha 0;

/* Spawn supply drop area */
_startSpawn = createMarker ["tag_startSpawn",[_mapX, _mapY]];
_startSpawn setMarkerType "Empty";

/* Build list of houses that are inside playArea */
_houseList = [_mapX, _mapY] nearObjects ["House", _markerSize];

/* Get house ID from object and put in array */
{
	_qHouseID = [_x] call tag_fn_getObjectId;

	/* Get loot positions by querying database */
	_query = format ["getLootPosID:%1", _qHouseID];
	_result = [_query, 2, true] call tiis_fnc_aSync;

	if ((_result select 0 select 0) != "") then {

		{
			_houseId	= _x select 0;
			_houseType  = _x select 1;
			_posX 		= _x select 2;
			_posY		= _x select 3;
			_posZ		= _x select 4;

			[["GET_LOOT_POSITIONS: %1 %2 %3 %4 %5", _houseId, _houseType, _posX, _posY, _posZ], "DEEPDEBUG"] call tiig_fnc_log;

			tag_lootPositions = tag_lootPositions + [[_houseId, _houseType, _posX, _posY, _posZ]];

		} forEach _result select 0;
	};
	
} foreach _houseList;

/* Spawn loot */
[tag_lootPositions] call tiis_fnc_lootSystem;

tag_ejectVehicle = TRUE;
publicVariable "tag_ejectVehicle"; // Eject all players from Vehicle

/* Start round */
0 execVM "\tag_server\scripts\tag_startRound.sqf";

["tag_setupRound.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;