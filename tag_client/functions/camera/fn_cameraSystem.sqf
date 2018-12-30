// If camera is already defined
if (!isNil "TAG_SPEC_CAM") exitwith {};

// Is FLIR available
if (isnil "TAG_SPEC_CAM_ISFLIR") then { TAG_SPEC_CAM_ISFLIR = isclass (configfile >> "cfgpatches" >> "A3_Data_F"); };

TAG_IN_CAM = TRUE;
TAG_SHOWNAMES = 1;

TAG_SPEC_CAM_MAP = FALSE;
TAG_SPEC_CAM_VISION = 0;
TAG_SPEC_CAM_FOCUS = 0;

0 spawn { sleep 5; player enableSimulation false; terminate _thisScript; };

/*
*	Play jaws
*/
tag_fn_camPlayJaws = {

	_jawsPlaying = FALSE;

	0 spawn {
		waitUntil {
			if (!tag_roundInProgress) exitWith {
				playSound "blank";
				TRUE
			};
			sleep 1;
		};
		terminate _thisScript;
	};

	while {tag_roundStarted && TAG_IN_CAM} do {

		{
			if (side _x == west) then {
				tag_lastHunter = _x;
			};
		} forEach playableUnits;

		_dist1v1 = round(tag_playerIt distance tag_lastHunter);

		if (_dist1v1 <= 60) then {
			if (!_jawsPlaying) then {

				playSound "jaws1";

				_jawsPlaying = TRUE;
			};
		} else {

			playSound "blank";

			_jawsPlaying = FALSE;
		};

		sleep 0.5;
	};
};

0 spawn {
	waitUntil {
		if (({side _x != civilian} count playableUnits) == 2) exitWith {
			0 spawn tag_fn_camPlayJaws;
			TRUE
		};
		sleep 1;
	};
	terminate _thisScript;
};

// Start drawing things on map and in 3d space
tag_fn_specCam = {

	cameraSystem_toggle = _this select 0;
	
	if (cameraSystem_toggle) then {

		disableSerialization;
		
		// Draw makers on map
		if (isNil "tag_fn_initUnitMarkers") then {
			_map = (findDisplay 12) displayCtrl 51;
			_mapdraw = _map ctrlSetEventHandler ["Draw", "_this call tag_fn_drawUnitMarkers;"];
			tag_fn_initUnitMarkers = TRUE;

		} else {
			_map ctrlremoveeventhandler ["Draw", _mapdraw];
			tag_fn_initUnitMarkers = nil;
		};

		tag_fn_drawUnitMarkers = {
			private["_ctrl"];
			_ctrl =  _this select 0;
			_iscale = (1 - ctrlMapScale _ctrl) max .2;
			_iconp = getText (configFile >> "cfgMarkers" >> "mil_triangle" >> "icon");
			_color = [0, 0, 0, 1];

			{
				if (alive _x && side _x != civilian) then {

					if (side _x == east) then {
						_color = [0, 250, 0, 0.8];
					} else {
						_color = [0, 0, 0, 0.8];
					};

					_ctrl drawIcon [_iconp, _color, getPosASL _x, _iscale*20, _iscale*30, getDir _x, name _x, 1];
				};
			} forEach playableUnits;
		};

		// Draw player info in 3d space
		["cameraSystem", "onEachFrame", {
				/*
				*	Name of players
				*/
				unitNameLayer = 1383;
				{	

					unitNameLayer = unitNameLayer + 1;
					unitNameLayer cutText ["","PLAIN"];

					if (alive _x && side _x != civilian) then {

						unitNameLayer cutRsc ["rscDynamicText", "PLAIN"];
						_ctrl = ((uiNamespace getvariable "BIS_dynamicText") displayctrl 9999);

						_unitWeapon = currentWeapon _x;
						_cfgUnitWeapon = configfile >> "CfgWeapons" >> _unitWeapon;
						unitWeaponName = gettext (_cfgUnitWeapon >> "displayname");
						if (format["%1 ", unitWeaponName] == " ") then { unitWeaponName = "Unarmed" };

						unitHealth = (100 - floor((damage _x) * 100));
						_posU2 = [(getPosATL _x) select 0, (getPosATL _x) select 1, ((getPosATL _x) select 2) + (((boundingBox _x) select 1) select 2) + 1.8];
						_pos2D = worldToScreen _posU2;
						_pos = getPosATL _x;
						_eyepos = ASLtoATL eyePos _x;

						if (side _x == east) then {
							unitName = name _x;
							unitName = unitName + " (IT)";
							unitNameColor = "#16ff00";
							distToIT = 0;
						};

						if (side _x == west) then {
							unitName = name _x;
							unitNameColor = "#fafafa";
							distToIT = round(tag_playerIt distance _x);
						};

						if ((getTerrainHeightASL [_pos select 0,_pos select 1]) < 0) then {
							_eyepos = eyePos _x;
							_pos = getPosASL _x;
						};
					
						if (count _pos2D > 0 && !visibleMap) then {

							_text = format ["<t size='0.35' font='PuristaSemiBold' color='%1'>%2 : %3 HP<br/>%4 : %5m from IT</t>", unitNameColor, unitName, unitHealth, unitWeaponName, distToIT];

							_ctrl ctrlSetFade 0;
							_ctrl ctrlShow TRUE;
							_ctrl ctrlEnable TRUE;
							_ctrl ctrlSetStructuredText parseText _text;
							_ctrl ctrlSetPosition [(_pos2D select 0) - (safezoneW / 2), (_pos2D select 1), safezoneW, safezoneH];
							_ctrl ctrlCommit 0;

						} else {
							disableSerialization;
							_ctrl ctrlShow FALSE;
							_ctrl ctrlEnable FALSE;
						};
					};						
				} forEach playableUnits;

				for '_i' from 1 to 50 do {
					unitNameLayer = unitNameLayer + 1;
					unitNameLayer cutText["","PLAIN"];
				};
				
		}] call BIS_fnc_addStackedEventHandler;
	} else {

		unitNameLayer = 1383;

		for '_i' from 1 to 50 do {
			unitNameLayer = unitNameLayer + 1;
			unitNameLayer cutText["","PLAIN"];
		};

		["cameraSystem", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	};
};

// Disable HUD
"RSC_TAG_HUD" cutFadeOut 1;

// Display camera info
call tiic_fnc_showCamInfo;

// Start camera
[TRUE] call tag_fn_specCam;

// If function is called without [player] use player object camera is attached to
if (typename _this != typename objnull) then { _this = cameraon };

private ["_ppos", "_pX", "_pY"];
_ppos = getPosATL _this;
_pX = _ppos select 0;
_pY = _ppos select 1;
_pZ = _ppos select 2;

private ["_local"];

_local = "camera" camCreate [_pX, _pY, _pZ+5];

TAG_SPEC_CAM = _local;
_local camCommand "MANUAL ON";
_local camCommand "INERTIA OFF";
_local cameraEffect ["EXTERNAL", "BACK"];
showCinemaBorder FALSE;
TAG_SPEC_CAM setDir direction (vehicle player);

systemChat ">>>> CAMERA: Spectator system enabled";

// Create camera marker on map
TAG_SPEC_CAM_MARKER = createMarkerLocal ["TAG_SPEC_CAM_MARKER", _ppos];
TAG_SPEC_CAM_MARKER setMarkerTypeLocal "mil_triangle";
TAG_SPEC_CAM_MARKER setMarkerColorLocal "ColorRed";
TAG_SPEC_CAM_MARKER setMarkerSizeLocal [.75,1];
TAG_SPEC_CAM_MARKER setMarkerTextLocal "Camera";

// Monitor keystrokes
_keyDown = (finddisplay 46) displayaddeventhandler ["keyDown",{
	_key = _this select 1;
	_ctrl = _this select 3;

	// Toggle nightvision modes
	// Default "n" key
	if (_key in (actionkeys 'nightvision')) then {
		TAG_SPEC_CAM_VISION = TAG_SPEC_CAM_VISION + 1;
		if (TAG_SPEC_CAM_ISFLIR) then {
					_vision = TAG_SPEC_CAM_VISION % 4;
			switch (_vision) do {
				case 0: {
					camusenvg FALSE;
					call compile 'FALSE SetCamUseTi 0';
				};
				case 1: {
					camusenvg TRUE;
					call compile 'FALSE SetCamUseTi 0';
				};
				case 2: {
					camusenvg FALSE;
					call compile 'TRUE SetCamUseTi 0';
				};
				case 3: {
					camusenvg FALSE;
					call compile 'TRUE SetCamUseTi 1';
				};
			};
		} else {
			_vision = TAG_SPEC_CAM_VISION % 2;
			switch (_vision) do {
				case 0: {
					camusenvg FALSE;
				};
				case 1: {
					camusenvg TRUE;
				};
			};
		};
	};

	// Show map
	// Default "m" key
	if (_key in (actionkeys 'showmap')) then {
		if (TAG_SPEC_CAM_MAP) then {
			openMap [FALSE, FALSE];
			TAG_SPEC_CAM_MAP = FALSE;
		} else {
			openMap [TRUE, TRUE];
			TAG_SPEC_CAM_MAP = TRUE;
			TAG_SPEC_CAM_MARKER setMarkerPosLocal position TAG_SPEC_CAM;
			TAG_SPEC_CAM_MARKER setMarkerPosLocal direction TAG_SPEC_CAM;
			mapAnimAdd [0, 0.1, position TAG_SPEC_CAM];
			mapAnimCommit;
		};
	};

	// 
	// F or User Action 17
	if (_key == 33 || _key in (actionkeys 'User17')) then {
		systemChat ">>>> CAMERA: FFFFFFFFFF";
	};

	// 
	// C or User Action 18
	if (_key == 46 || _key in (actionkeys 'User18')) then {
		systemChat ">>>> CAMERA: CCCCCCCCCC";
	};

	// Switch between first and third person view
	// V or User Action 19
	if (_key == 47 || _key in (actionkeys 'User19')) then {

		TAG_CAMERA_TARGET = screenToWorld[0.5,0.5];

		{ if(alive _x && side _x != civilian) exitWith { TAG_CAMERA_TARGET = _x; };
		} forEach (nearestObjects [TAG_CAMERA_TARGET,['Man'],15]);

		if(!isNull TAG_CAMERA_TARGET) then {

			TAG_SPEC_CAM camPrepareTarget TAG_CAMERA_TARGET;
			TAG_SPEC_CAM camCommitPrepared 0;

			waitUntil { camCommitted TAG_SPEC_CAM; };
			TAG_SPEC_CAM camCommand 'MANUAL ON';
			
			// TAG_CAMERA_TARGET switchCamera "INTERNAL";
			TAG_SPEC_CAM cameraEffect ["INTERNAL", "BACK"];

			_trackedName = name TAG_CAMERA_TARGET;
			systemChat format [">>>> CAMERA: Tracking %1", _trackedName];
		};		
	};

	// Display name above players
	// B or Use Action 20
	if (_key == 48 || _key in (actionkeys 'User20')) then {
		if(TAG_SHOWNAMES == 1) then {
			TAG_SHOWNAMES = 0;
			systemChat ">>>> CAMERA: Player names disabled";
			[FALSE] call tag_fn_specCam;
		} else {
			TAG_SHOWNAMES = 1;
			systemChat ">>>> CAMERA: Player names enabled";
			[TRUE] call tag_fn_specCam;
		};
	};

	// Set position to last position if camera was "destroyed"
	// NUMPAD = ,
	if (_key == 83 && !isnil 'TAG_SPEC_CAM_LASTPOS') then {
		TAG_SPEC_CAM setPos TAG_SPEC_CAM_LASTPOS;
	};
}];

// Mouse scroll wheel moving
// Manual focus
_mousezchanged = (findDisplay 46) displayAddEventhandler ["mousezchanged",{
	_n = _this select 1;
	TAG_SPEC_CAM_FOCUS = TAG_SPEC_CAM_FOCUS + _n/10;
	if (_n > 0 && TAG_SPEC_CAM_FOCUS < 0) then {TAG_SPEC_CAM_FOCUS = 0};
	if (TAG_SPEC_CAM_FOCUS < 0) then {TAG_SPEC_CAM_FOCUS = -1};
	TAG_SPEC_CAM camCommand 'manual off';
	TAG_SPEC_CAM camPrepareFocus [TAG_SPEC_CAM_FOCUS,1];
	TAG_SPEC_CAM camCommitPrepared 0;
	TAG_SPEC_CAM camCommand 'manual on';
}];

// Mouse click
// Place camera on map.
_map_mousebuttonclick = ((findDisplay 12) displayCtrl 51) ctrlAddEventhandler ["mousebuttonclick",{
	_button = _this select 1;
	_ctrl = _this select 5; // Not used (key CTRL + Mouseclick)
	if (_button == 0) then {
		_x = _this select 2;
		_y = _this select 3;
		_worldpos = (_this select 0) posScreenToWorld [_x,_y];
		TAG_SPEC_CAM setPos [_worldpos select 0, _worldpos select 1, position TAG_SPEC_CAM select 2];
		TAG_SPEC_CAM_MARKER setMarkerPosLocal _worldpos;
	};
}];

// Wait until destroy is forced or camera auto-destroyed.
[_local, _keyDown, _mousezchanged, _map_mousebuttonclick] spawn {
	private ["_local","_keyDown","_mousezchanged","_map_mousebuttonclick","_lastpos"];

	_local = _this select 0;
	_keyDown = _this select 1;
	_mousezchanged = _this select 2;
	_map_mousebuttonclick = _this select 3;

	waituntil {
		if (!isnull TAG_SPEC_CAM) then {_lastpos = position TAG_SPEC_CAM};
		isNull TAG_SPEC_CAM
	};

	player enableSimulation true;

	player cameraEffect ["TERMINATE", "BACK"];
	deleteMarkerLocal TAG_SPEC_CAM_MARKER;
	TAG_SPEC_CAM = nil;
	TAG_SPEC_CAM_MAP = nil;
	TAG_SPEC_CAM_MARKER = nil;
	TAG_SPEC_CAM_VISION = nil;
	camDestroy _local;
	systemChat ">>>> CAMERA: Disabling spectator system";
	TAG_SPEC_CAM_LASTPOS = _lastpos;
	TAG_IN_CAM = FALSE;

	playSound "blank";
	
	(findDisplay 46) displayRemoveEventhandler ["keydown",_keyDown];
	(findDisplay 46) displayRemoveEventhandler ["mousezchanged",_mousezchanged];
	((findDisplay 12) displayctrl 51) ctrlRemoveEventhandler ["mousebuttonclick",_map_mousebuttonclick];
};

[["tag_fn_cameraSystem.sqf loaded"], "DEEPDEBUG"] call tiig_fnc_log;