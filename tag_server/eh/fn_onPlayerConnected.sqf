/*
*	@Name: onPlayerConnected
*
*	@Description:
*		Executes assigned code when client joins the mission in MP. Stackable version of onPlayerConnected.
*		If dedicated server was started without '-autoInit' option and this EH was created on server,
*		on first GUI client this EH also fires against server, but after first client.
*
*	@Notes
*		That happens only for GUI clients, if HC client connects first, EH does not fire for server.
*		If dedicated server was started with -autoInit option, this EH does not fire against server,
*		only for future clients, and all further clients appear to be JIPped.
*		Interesting moment for headless clients, for headless clients instead of getPlayerUID, handler gets string like "HC12160",
*		where '12160' is headless client process ID (matches HC's PID observed in windows task manager)
*
*	@Parameters:
*		_id: Number - unique DirectPlay ID (very large number). It is also the same id used for user placed markers (same as _id param)
*		_uid: String - getPlayerUID of the joining client. The same as Steam ID (same as _uid param)
*		_name: String - profileName of the joining client (same as _name param)
*		_jip: Boolean - didJIP of the joining client (same as _jip param)
*		_owner: Number - owner id of the joining client (same as _owner param)
*
*/

params ["_id", "_uid", "_name", "_jip", "_owner", ["_banned", 0], "_reason", "_unit"];

// Do not run this code on server
// if (_owner == 2) exitWith {};

// On player connect, add 15 seconds to waittimer if a game is about to start
//if(tag_mCountReached && !tag_readyToPlay) then { waitTimer = waitTimer + 15; };

// Insert / Update player profileData
_query = format["InsertProfileData:%1:%2", _uid, _name];
[_query, 1, true] call tiis_fnc_aSync;

// Get some data from players profile
_query = format ["getProfileData:%1", _uid];
_result = [_query, 2, true] call tiis_fnc_aSync;

tag_unitBanned = false;

if (count _result > 0) then {
	_data = _result select 0;
	_banned = parseNumber(_data select 0);
	_reason = _data select 1;

	_longHS = parseNumber(_data select 2);
	_longKill = parseNumber(_data select 3);

	_longHSGun = _data select 4);
	_longKillGun = _data select 5);
};

if (_banned == 1) then {

	tag_unitBanned = true;
	_owner publicVariableClient "tag_unitBanned";

	_clientMSG = [_uid, _name, _reason, _owner] spawn {
		params ["_uid", "_name", "_reason", "_owner"];

		while{true} do {
			_message = "<t size='1'><t color='#db0015'>Attention:</t> You have been banned!</t>";
			[_message,0,0.2,15,0,0,1337] remoteExec ["bis_fnc_dynamicText", _owner];

			_message = format ["<t size='1'><t color='#db0015'>Reason:</t> %1</t>", _reason];
			[_message,0,0.3,15,0,0,3010] remoteExec ["bis_fnc_dynamicText", _owner];

			sleep 0.5;
		};
	};

	sleep 10;

	tag_cmdPass serverCommand format ["#kick %1", _uid]; // Kick client
	terminate _clientMSG;
	sleep 0.5;

};

// Get object from Owner id
{   if((_x getVariable "tag_unitIdentity") select 3 == _owner) then {
		_unit = (_x getVariable "tag_unitIdentity") select 0;
	}
} forEach playableUnits;

// Set variables on unit
_unit setVariable ["tag_unitLongHS", _longHS, true];
_unit setVariable ["tag_unitLongHSGun", _longHSGun, true];
_unit setVariable ["tag_unitLongKill", _longKill, true];
_unit setVariable ["tag_unitLongKillGun", _longKillGun, true];

[["LONGEST HS: %1", _longHS]] call tiig_fnc_log;
[["LONGEST HS GUN: %1", _longHSGun]] call tiig_fnc_log;
[["LONGEST KILL: %1", _longKill]] call tiig_fnc_log;
[["LONGEST KILL GUN: %1", _longKillGun]] call tiig_fnc_log;

_owner publicVariableClient "tag_unitBanned";

terminate _thisScript;