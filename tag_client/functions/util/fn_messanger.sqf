/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_messsanger.sqf
*	@Location: {@mod\addons}\tag_client\functions\util\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		
*
*	Example(s):
*		
*
*	Parameter(s):
*		0 - VALUE TO RANDOMIZE BETWEEN (Mandatory):
*			NUMBER - A number which is then used as a top value for the randomization (random from 0 to rX)
*
*		1 - VALUE TO RANDOMIZE BETWEEN (Mandatory):
*			NUMBER - A number which is then used as a top value for the randomization (random from 0 to rY)
*
*		2 - ORIGINAL VALUE (Mandatory):
*			NUMBER - 
*
*		2 - ORIGINAL VALUE (Mandatory):
*			NUMBER - 
*
*	Returns:
*		ARRAY - [x,y] Randomized position
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

params ["_message","_size","_posX","_posY","_duration","_layer","_to","_unit","_net"];

_formatedMessage = format["<t size='%1'>%2</t>", _size, _message];

switch (_net) do {
	case "mp": {
		switch (_to) do {
			case "all": { [[_formatedMessage,_posX,_posY,_duration,0,0,_layer],"BIS_fnc_dynamicText", true, false, false] call BIS_fnc_MP };
			case "noCiv": { { if (side _x != civilian) then { [[_formatedMessage,_posX,_posY,_duration,0,0,_layer],"BIS_fnc_dynamicText", _x, false,false] call BIS_fnc_MP; }; } forEach playableUnits; };
			case "exclude": { { if (side _x != civilian) then { [[_formatedMessage,_posX,_posY,_duration,0,0,_layer],"BIS_fnc_dynamicText", _x, false,false] call BIS_fnc_MP; }; } forEach playableUnits - [_unit]; };
			case "CivExclude": { { [[_formatedMessage,_posX,_posY,_duration,0,0,_layer],"BIS_fnc_dynamicText", _x, false,false] call BIS_fnc_MP; } forEach playableUnits - [_unit]; };
			case "specific": { [[_formatedMessage,_posX,_posY,_duration,0,0,_layer],"BIS_fnc_dynamicText", _unit, false,false] call BIS_fnc_MP; };
		};
	};
	case "local": {
		switch (_to) do { 
			case "any": { [_formatedMessage,_posX,_posY,_duration,0,0,_layer] spawn bis_fnc_dynamicText; };
			case "civ": { if (side _unit == civilian) then { [_formatedMessage,_posX,_posY,_duration,0,0,_layer] spawn bis_fnc_dynamicText; }; };
			case "noCiv": { if (side _unit != civilian) then { [_formatedMessage,_posX,_posY,_duration,0,0,_layer] spawn bis_fnc_dynamicText; }; };
		};
	};
};