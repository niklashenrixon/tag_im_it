/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_shotMarker.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Marks a random area on the map around given object up-on firing weapon if this function is loaded
*		Area size depends on amount of players
*
*	Example(s):
*		[_unit(object)] call tiig_fnc_shotMarker;
*
*	Parameter(s):
*		0 OBJECT (Mandatory):
*			Player to spawn function on
*
*	Returns:
*		
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

params [["_unit",objNull], ["_allowed", false], "_au", "_sil", "_ms"];
if (isNull _unit) exitWith { ["tiig_fnc_shotMarker: cannot be used without a provided unit object"] call tiig_fnc_log; };

if (tag_gameInProgress) then {
	if(_allowed || missionNamespace getVariable "tag_gameEndgame") then {
		_unitUID = getPlayerUID _unit;
		_msID = _unitUID + "_solid";
		_mtID = _unitUID + "_text";

		_au = {side _x != resistance && side _x != civilian && alive _x} count playableUnits;
		
		_wa = _unit weaponAccessories currentWeapon _unit;
		_sil = _wa select 0;

		if (_sil != "") then {
			_ms = 30 * (6 min (round (_au / 3)));
		} else {
			_ms = 15 * (4 min (round (_au / 2)));
		};

		_unitPos = getPos _unit;
		_posX = _unitPos select 0;
		_posY = _unitPos select 1;

		_mp = [_ms, _ms, _posX, _posY] call tiig_fnc_rand2d;

		deleteMarker _msID;
		deleteMarker _mtID;

		_itM = createMarker [_msID,[0,0]];
		_itM setMarkerShape "ELLIPSE";
		_itM setMarkerType "Empty";
		_itM setMarkerBrush "Solid";
		_itM setMarkerAlpha 0.5;
		_itM setMarkerSize [_ms,_ms];
		_itM setMarkerColor "ColorBlue";
		_itM setMarkerPos _mp;

		_itMPos = getMarkerPos _msID;

		_mText = createMarker [_mtID,[0,0]];
		_mText setMarkerShape "ICON";
		_mText setMarkerType "mil_dot";
		_mText setMarkerAlpha 0.5;
		_mText setMarkerSize [0.1,0.1];
		_mText setMarkerColor "ColorBlue";

		if(side _unit == east) then {
			_mText setMarkerText "Position of ""IT""";
		} else {
			_unitName = name _unit;
			_mText setMarkerText "Position of " + _unitName;
		};

		_mText setMarkerPos _mp;
	};
};