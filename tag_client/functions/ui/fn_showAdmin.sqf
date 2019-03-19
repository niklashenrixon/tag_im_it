_accessGranted = false;
_adminState = admin owner player;
if(_adminState >= 1) then { _accessGranted = true; };
if(getPlayerUID(player) in tag_adminList) then { _accessGranted = true; };
if (!_accessGranted) exitWith { systemChat ">>>> ADMIN TOOL: You are not an admin! I cannot allow this."; };

disableSerialization;

createDialog "TAG_U_ADMIN"; // Create dialog

waitUntil {!isNull (findDisplay 9666);}; // Wait for dialog to appear

_disp = uiNamespace getVariable "TAG_U_ADMIN_DISP"; // Get dialog handle

_listUnits    = _disp displayCtrl 8606;
_listWeathers = _disp displayCtrl 8607;
_listCommands = _disp displayCtrl 8608;
_btnError 	  = _disp displayCtrl 8616;
_btnDebug 	  = _disp displayCtrl 8617;
_btnDebugDeep = _disp displayCtrl 8618;
_btnExecute   = _disp displayCtrl 8612;
_btnKick      = _disp displayCtrl 8609;
_btnBan       = _disp displayCtrl 8610;

_commands = [
	"Restart mission",
	"Restart server",
	"Reassign",
	"ON: Monitor (systemchat)",
	"OFF: Monitor (systemchat)",
	"ON: Monitor (server console)",
	"OFF: Monitor (server console)",
	"WaitTimer = 1",
	"MinPlayers = 1",
	"Quickstart server",
	"Spectator Camera",
	"Spawn supply drop",
	"GOD MODE"
];

_weatherPresets = ["CLEAR", "RAINY", "FOGGY", "OVERCAST"];

tag_userIdList = [];

{ _listCommands lbAdd _x; } forEach _commands; // Populate commands list
{ _listWeathers lbAdd _x; } forEach _weatherPresets; // Populate weather presets list

// Populate username list
{   _listUnits lbAdd name _x;
	tag_userIdList pushBack (getPlayerUID _x);
} forEach playableUnits;

// Kick selected player
_btnKick ctrlAddEventHandler ["ButtonClick",{
	_si = lbCurSel 8606;
	_kickUID = tag_userIdList select _si;

	lbDelete [8606, _si];

	_execOK = serverCommand format ["#kick %1", _kickUID];
	if(_execOK) then { systemChat format [">>>> ADMIN TOOL: Kicking %1", _kickUID]; };
	if(!_execOK) then { systemChat format [">>>> ADMIN TOOL: Failed to kick %1", _kickUID]; };
}];

// Ban selected player
_btnBan ctrlAddEventHandler ["ButtonClick",{
	_si = lbCurSel 8606;

	_kickUID = tag_userIdList select _si;

	_reason = ctrlText 8605;
	if (_reason == "") then { _reason = "No reason given"; };
	tag_setBanned = [1, _reason, _kickUID];

	publicVariableServer "tag_setBanned";

	_execOK = serverCommand format ["#kick %1", _kickUID];
	if(_execOK) then { systemChat format [">>>> ADMIN TOOL: Banning %1", _kickUID]; };
	if(!_execOK) then { systemChat format [">>>> ADMIN TOOL: Failed to ban %1", _kickUID]; };
}];

// Execute server commands
_btnExecute ctrlAddEventHandler ["ButtonClick",{
	_sc = lbCurSel 8608;
	switch (_sc) do { 
		case 0 : { _execOK = serverCommand "#restart"; };
		case 1 : { _execOK = serverCommand "#restartserver"; };
		case 2 : { _execOK = serverCommand "#reassign"; };
		case 3 : { _execOK = serverCommand "#monitor 1"; };
		case 4 : { _execOK = serverCommand "#monitor 0"; };
		case 5 : { _execOK = serverCommand "#monitords 1"; };
		case 6 : { _execOK = serverCommand "#monitords 0"; };
		case 7 : { waitTimer = 3; publicVariableServer "waitTimer"; };
		case 8 : { tag_minPlayersToStart = 1; publicVariableServer "tag_minPlayersToStart"; };
		case 9 : { waitTimer = 3; publicVariableServer "waitTimer"; tag_minPlayersToStart = 1; publicVariableServer "tag_minPlayersToStart"; };
		case 10 : { [player] call tiic_fnc_cameraSystem; };
		case 11 : { 0 spawn tiis_fnc_supplyDrop; };
		default { systemChat ">>>> ADMIN TOOL: Choose a command to execute first!"; };
	};
}];

// Set debug mode "error"
_btnError ctrlAddEventHandler ["ButtonClick",{
	tag_debugMode = 0;
	publicVariable "tag_debugMode";
	systemChat ">>>> ADMIN TOOL: Setting debugmode to 0";
}];

// Set debug mode "debug"
_btnDebug ctrlAddEventHandler ["ButtonClick",{
	tag_debugMode = 1;
	publicVariable "tag_debugMode";
	systemChat ">>>> ADMIN TOOL: Setting debugmode to 1";
}];

// Set debug mode "deep debug"
_btnDebugDeep ctrlAddEventHandler ["ButtonClick",{
	tag_debugMode = 2;
	publicVariable "tag_debugMode";
	systemChat ">>>> ADMIN TOOL: Setting debugmode to 2";
}];