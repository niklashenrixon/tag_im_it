disableSerialization;

"RSC_TAG_HUD" cutRsc ["TAG_U_HUD","PLAIN"];

showHUD [true, false, false, true, false, false, false, true, true];

_disp = uiNamespace getVariable "TAG_U_HUD_DISP";
_txtIT = _disp displayCtrl 8627;
_txtHP = _disp displayCtrl 8628;
_txtUL = _disp displayCtrl 8629;
_picIT = _disp displayCtrl 8631;

_txtAMMO  = _disp displayCtrl 8632;
_txtMODE  = _disp displayCtrl 8633;
_txtRANGE = _disp displayCtrl 8640;

_id = addMissionEventHandler ["EachFrame", {

	_mags = { _x in getArray (configFile >> "CFGWeapons" >> (currentWeapon player) >> "magazines") } count (magazines player);

	_wsPlayer = weaponState player;
	_range = currentZeroing player;

	_mode = _wsPlayer select 2;
	_ammo = _wsPlayer select 4;

	_txtAMMO ctrlSetText format["%1 / %2", _ammo, _mags];
	_txtMODE ctrlSetText format["MODE: %1", _mode];
	_txtRANGE ctrlSetText format["RANGE: %1m", _range];

	if(player getVariable "tag_unitIsIT" && tag_gameInProgress) then {
		itText = "YOU'RE IT!";
		_txtIT ctrlSetTextColor [1, 0, 0, 1];
		_picIT ctrlSetText "\tag_client\ui\images\it_symbol.paa";
		_picIT ctrlCommit 0;
	} else {
		itText = "";
		_txtIT ctrlSetTextColor [1, 1, 1, 1];
		_picIT ctrlSetText "";
		_picIT ctrlCommit 0;
	};

	_txtIT ctrlSetText format ["%1", itText];
	_txtHP ctrlSetText format ["HEALTH: %1%2", round((1 - (damage player)) * 100), "%"];
	_txtUL ctrlSetText format ["PLAYERS LEFT: %1", count playableUnits];

}];

if(isNull _disp) then {
	removeMissionEventHandler ["EachFrame", _id]; //Remove the third index under type "EachFrame"
};