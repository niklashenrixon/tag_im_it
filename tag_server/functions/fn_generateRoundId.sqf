/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_generateRoundId.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Function that generates a id-string with given length
*
*	Example(s):
*		[20] call tiis_fnc_generateRoundId;
*
*	Parameter(s):
*		0 NUMBEr (Mandatory):
*			Length of the round id that you want to be generated
*
*	Returns:
*		id(string)
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_length",0]];
if (_length == 0) exitWith { ["tiis_fnc_generateRoundId: cannot be used without providing a number"] call tiig_fnc_log; };

roundId	= [];
_roundIdString = "";

for "_i" from 1 to _length do {
	
	_letters = ['a','b','c','d','e','f','g','h','u','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
				'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
	_numbers = ['0','1','2','3','4','5','6','7','8','9'];

	_letterRandom = _letters select floor random count _letters;
	_numberRandom = _numbers select floor random count _numbers;

	_holder = [_letterRandom, _numberRandom];
	_outputRandom = _holder select floor random count _holder;

	roundId pushBack _outputRandom;
};

_idCount = (count roundId) -1;

for "_x" from 0 to _idCount do {
	_currentElement = roundId select _x;
	_roundIdString = _roundIdString + _currentElement;
};

_returnThis = _roundIdString;
_returnThis