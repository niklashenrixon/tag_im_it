/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_rand2d.sqf
*	@Location: {@mod\addons}\tag_client\functions\util\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Function that randomizes in a 2 dimentional space
*		Asymmetrical randomization is possible in a 2d space
*
*	Example(s):
*		[50, 50, 122, 234] call tiig_fnc_rand2d; (This can give us from 0-50 minus or plus applied on 122 and the same for 234)
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

params ["_rX","_rY","_aX","_aY"];

// X
_rX = round(random _rX);
_nrX1 = _aX + _rX;
_nrX2 = _aX - _rX;
_raX = selectRandom [_nrX1, _nrX2];

// Y
_rY = round(random _rY);
_nrY1 = _aY + _rY;
_nrY2 = _aY - _rY;
_raY = selectRandom [_nrY1, _nrY2];

_r = [_raX,_raY];
_r