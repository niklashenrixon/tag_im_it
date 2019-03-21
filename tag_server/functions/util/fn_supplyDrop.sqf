/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_supplyDrop.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Spawns loot @ designated marker
*
*	Example(s):
*		supplyBox = call tiis_fnc_supplyDrop;
*
*	Parameter(s):
*		0 ARRAY (Mandatory):
*			Multi-dim array with positions to spawn loot at = [[_houseId, _houseType, _posX, _posY, _posZ], [_houseId, _houseType, _posX, _posY, _posZ]]
*
*		1 ARRAY (Optional):
*			Array with house types to exclude from loot spawning = ["Land_i_House_Small_01_V2_F", "Land_Pier_F"]
*
*	Returns:
*		OBJECT - The create that was created when spawning the supply drop
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_playGround", "_randSupplyDropPos", "_dropX", "_dropY", "_parachute", "_smoke1"];

// Set wind to 0
_windArray = wind;
setWind [0, 0, TRUE];
0 setWindDir 0;
0 setWindForce 0;
0 setWindStr 0;
//forceWeatherChange;

sleep 15;

// Set safe position of supply drop
_playGround = missionNamespace getVariable "tag_playGroundSettings";
_pos = _playGround select 0;
_size = _playGround select 1;
_randSupplyDropPos = [_size-75, _size-75, _pos select 0, _pos select 1] call tiig_fnc_rand2d;
_position = _randSupplyDropPos findEmptyPosition [0, 100, "B_supplyCrate_F"];
if(count _position == 0) then { _position = _randSupplyDropPos findEmptyPosition [0, 200, "B_supplyCrate_F"]; };

_dropX = (_position select 0);
_dropY = (_position select 1);

playSound3D ["tag_client\sounds\siren.ogg", nil, false, tag_activeSiren, 3, 1, 2000];

[["SUPPLYDROP: Spawned"], "DEBUG"] call tiig_fnc_log;

// Create drop with parachute
_parachute = createVehicle ["B_Parachute_02_F", [0,0,0], [], 0, "FLY"];
_parachute setDir random 360;
_parachute setPos [_dropX, _dropY, 150];

tag_supplyDrop = createVehicle ["B_supplyCrate_F", [0,0,140], [], 0, "FLY"];
tag_supplyDrop attachTo [_parachute, [0,0,0]]; 

_smoke1 = createvehicle ["SmokeShellRed_Infinite", [0,0,0], [], 0, "FLY"];
_smoke1 setPos (getPos _parachute);
_smoke1 attachTo [_parachute, [0,0,0]];

// Land safely
tag_supplyDrop allowDamage false;
tag_supplyDrop call tiig_fnc_emptyCargo;
waitUntil { getPos tag_supplyDrop select 2 < 0.5 };
detach tag_supplyDrop;
tag_supplyDrop setVelocity [0,0,0];
sleep 0.3;
tag_supplyDrop allowDamage true;

// Reset wind to previous
setWind [_windArray select 0, _windArray select 1, FALSE];
//forceWeatherChange;

terminate _thisScript;