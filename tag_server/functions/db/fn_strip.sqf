/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_strip.sqf
*	@Location: {@mod\addons}\tag_server\functions\db\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Strips semicolon from String.
*		Needed for parser Player Name etc since extDB uses : as seperator character
*
*	Example(s):
*		[STRING (clientID)] call tiis_fnc_strip;
*
*	Parameter(s):
*		0 NUMBER (Mandatory):
*			Length of the round id that you want to be generated
*
*	Returns:
*		Client ID stripped of semicolon (string)
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_string",""],"_array"];
if (_string == "") exitWith { ["tiis_fnc_strip: cannot be called without data"] call tiig_fnc_log; };

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