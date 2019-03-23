/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_loadUniform.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Load / change uniform on player
*
*	Example(s):
*		call tiig_fnc_loadUniform;
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

TAG_SETTINGS = profileNamespace getVariable "TAG_P_SETTINGS";

if (isNil "TAG_SETTINGS") then {
  TAG_SETTINGS = ["TAG_U_DEFAULT"];
} else {
	_uniform = TAG_SETTINGS select 0;

	// Set NIXON special
	if(_uniform == "TAG_U_NIXON") then {
		if((getPlayerUID player) == "76561198002908182") then {

			[player, "NIXON"] remoteExec ["setIdentity", 0, player];
			[player, "NixonHead_01"] remoteExec ["setFace", 0, player];
			lockIdentity player;
			player addHeadgear "NIXON_CAP";
		};
	};

	player addUniform _uniform;
};