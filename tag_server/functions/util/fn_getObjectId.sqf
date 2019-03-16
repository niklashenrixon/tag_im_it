/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_getObjectId.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Call function with an object and it returns the id number of that object
*
*	Example(s):
*		[_house] call tiis_fnc_getObjectId;
*
*	Parameter(s):
*		0 ARRAY (Mandatory):
*			Array with a house object
*
*	Returns:
*		House ID number (string)
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_object", objNull, [objNull]], "_sn", "_sf", "_ef", "_na", "_id", "_i", "_item"];
if(!(_object isEqualType objNull) || isNull _object) exitWith { ["tiis_fnc_getObjectId: cannot be used without an object"] call tiig_fnc_log; };

_sn = toArray (str (_object));

_sf = false;_ef = false;_na = [];_id = 0;

for "_i" from 0 to (count _sn)-1  do {
	_item = _sn select _i;
	if (_sf and (not (_ef))) then {
		_na set [count _na,_item];
	};
	if (_item == 35) then {
		_sf = true;
	};
	if (_item == 58) then {
		_ef = true;
	};
};

if ((count _na) >=3) then {
	_na set [((count _na)-1) ,"delete"];
	_na = _na - ["delete"];
	_na set [0 ,"delete"];
	_na = _na - ["delete"];
	_id = toString (_na);
};

_returnThis = _id;
_returnThis