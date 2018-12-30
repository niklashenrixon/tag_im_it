/*
*	@Name: onCheckVersion (Variable Eventhandler)
*
*	@Description:
*		Checks version on client-end when client connects
*
*	@Parameters:
*		_unit: Object - Connecting player object
*		_unitVersion: Number - Connected players version
*		_unitVersionString: String - Connected players version in nice format
*
*/

params [["_unit",objNull],"_unitVersion","_unitVersionString","_name","_uid"];
if (isNull _unit) exitWith { ["tiis_fnc_onClientVersion: cannot be used without a provided unit object"] call tiig_fnc_log; };

_name = name _unit;
_uid = getPlayerUID _unit;

if(_unitVersion != tag_serverVersion) then {
	
	[_unit, _unitVersionString] spawn {
		params ["_unit","_unitVersionString"];
		while{alive _unit} do {
			_message = format["Your version: <t color='#d8080d'>%1</t> | Server version: <t color='#d8080d'>%2</t>", _unitVersionString, tag_serverVersionString];

			["Bad version detected!", 1, 0, 0.7, 5, 1337, "specific", _unit, "mp"] call tiig_fnc_messanger;
			[_message, 0.5, 0, 0.8, 5, 3010, "specific", _unit, "mp"] call tiig_fnc_messanger;
			sleep 0.5;
		};
		terminate _thisScript;
	};

	sleep 10; // Let client see that he has a bad version

	tag_cmdPass serverCommand format ["#kick %1", _uid]; // Kick client
	sleep 0.5;

	if (!alive _unit) then {
		"Client with bad version was kicked" call tiig_fnc_log;
		[["Client: %1 (%2) | Client version: %3 | Server version: %4", _name, _uid, _unitVersionString, tag_serverVersionString], "ERROR"] call tiig_fnc_log;
	} else {
		[["Could not kick client with bad version: %1 (%2) | Client version: %3 | Server version: %4", _name, _uid, _unitVersionString, tag_serverVersionString], "ERROR"] call tiig_fnc_log;
	};

} else {
	_unit setVariable ["tag_unitVersionAllowed", true, true];
	[["Client connected: %1 (%2) | Client version: %3 | Server version: %4", _name, _uid, _unitVersionString, tag_serverVersionString], "DEBUG"] call tiig_fnc_log;
};
terminate _thisScript;