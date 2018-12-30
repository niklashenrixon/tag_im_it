// UNIFORM CHANGE
disableSerialization;
createDialog "TAG_U_UNIFORM"; // Create dialog
waitUntil {!isNull (findDisplay 9668);}; // Wait for dialog to appear

tag_uniforms = [];

_cfg = configFile >> "CfgSkins";
for "_i" from 0 to count(_cfg)-1 do {
	if(isClass (_cfg select _i)) then {
		_name = getText ((_cfg select _i) >> "name");
		_uniform = getText ((_cfg select _i) >> "uniform");
		_picture = getText (configFile >> "CfgWeapons" >> _uniform >> "picture");
		tag_uniforms pushBack [_name, _uniform, _picture];
	};
};

_disp = uiNamespace getVariable "TAG_U_UNIFORM_DISP"; // Get dialog handle

_ctrlPicture = _disp displayCtrl 8635;
_ctrlList    = _disp displayCtrl 8636;
_ctrlApply   = _disp displayCtrl 8637;

// Populate uniform list
{   _name = _x select 0;
	_ctrlList lbAdd _name;
} forEach tag_uniforms;

_ctrlApply ctrlAddEventHandler ["ButtonClick",{
	_si = lbCurSel 8636;
	_data = tag_uniforms select _si;
	_uniform = _data select 1;

	// Save chosen uniform to profile
	profileNamespace setVariable ["TAG_P_SETTINGS",[_uniform]];
	saveProfileNamespace;

	// Change uniform on player
	player addUniform _uniform;
}];

_ctrlList ctrlAddEventHandler ["LBSelChanged",{
	_si = lbCurSel 8636;
	_data = tag_uniforms select _si;
	_picture = _data select 2;
	ctrlSetText [8635, _picture];
}];