/*
*	@Name: onSetBanned (Variable Eventhandler)
*
*	@Description:
*		Set banstate on client
*
*	@Parameters:
*		_banState: Number - 0 = not banned | 1 = banned
*		_reason: String - Reason why client is banned. Empty string when removing ban
*		_puid: String - Player UID as identifier
*
*/

params [["_banState",0], ["_reason","ERROR"], ["_puid","00000000"]];
_query = format ["setBanned:%1:%2:%3", _banState, _reason, _puid];
[_query, 1, true] call tiis_fnc_aSync;