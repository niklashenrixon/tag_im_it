/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_randomArray.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Returns a suffled and randomized array
*
*	Example(s):
*		_randomArray = [_array(any)] call tiig_fnc_randomArray;
*
*	Parameter(s):
*		0 ARRAY (Mandatory):
*			1 Dimentional array to be randomized
*
*	Returns:
*		1st STRING, OBEJCT or something else from original array
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

params [["_a",[]], ["_aO",[]], ["_r", []]];
if(count _a == 0) exitWith { ["tiig_fnc_randomArray: cannot be used with empty array"] call tiig_fnc_log; };
_aO = _a call BIS_fnc_arrayShuffle;
_r  = selectRandom _aO;
_r