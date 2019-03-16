/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_messageSystem.sqf
*	@Location: {@mod\addons}\tag_server\functions\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Server sends messages in system chat
*
*	Example(s):
*		0 spawn tiis_fnc_messageSystem;
*
*	Parameter(s):
*		none
*
*	Returns:
*		nothing
*		
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////
	
_pause = 50;

_messages = ["WELCOME TO TAG I'M IT!",
			 "VISIT THE WEBSITE AT | www.tagimit.eu",
			 "CHECK YOUR STATS AT | www.tagimit.eu/leaderboard",
			 "REMEMBER, THIS MOD IS UNDER DEVELOPMENT. SO IF YOU ENCOUNTER A BUG, PLEASE REPORT IT AT THE BOTTOM OF THE WEBSITE"
			];

_doMessage = TRUE;
_messageCount = 0;

while{_doMessage} do {

	{
		[format [_x]] remoteExec ["systemChat"];
		sleep _pause;
	} forEach _messages;
	
	_messageCount = _messageCount + 1;

	if (_messageCount >= 50) then {
		_doMessage = FALSE;
	};
};
