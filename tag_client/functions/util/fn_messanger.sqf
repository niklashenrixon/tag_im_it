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
			case "all": { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] remoteExec ["BIS_fnc_dynamicText", -2]; };
			case "noCiv": { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] remoteExec ["BIS_fnc_dynamicText", [west, east]]; };
			case "exclude": { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] remoteExec ["BIS_fnc_dynamicText", (playableUnits - [_unit])]; };
			case "specific": { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] remoteExec ["BIS_fnc_dynamicText", owner _unit]; };
			case "CivExlusive": { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] remoteExec ["BIS_fnc_dynamicText", [resistance, civilian]]; };
		};
	};

	case "local": {
		switch (_to) do {
			case "any": { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] spawn bis_fnc_dynamicText; };
			case "civ": { if (side _unit == resistance) then { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] spawn bis_fnc_dynamicText; }; };
			case "noCiv": { if (side _unit != resistance) then { [_formatedMessage, _posX, _posY, _duration, 0, 0, _layer] spawn bis_fnc_dynamicText; }; };
		};
	};
};