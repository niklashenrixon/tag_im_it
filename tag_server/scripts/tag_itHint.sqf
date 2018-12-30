/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_itHint.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Reveals IT periodically and if IT is camping
*		plays a sound and marks IT on map for a short period
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
*	Every second, check how many players are alive
*/
tag_timeLimitHint = time + 120;
tag_firstHint = FALSE;

0 spawn {
	while{tag_playerCount >= 2} do {

		if (time >= tag_timeLimitHint && !tag_firstHint) then {

			tag_tLimit = time + (round(random 150)+90); // random number between 90 and 240

			["Hinting position of IT", "DEEPDEBUG"] call tiig_fnc_log;

			_itPos = getPos tag_playerIt;
			playSound3D ["tag_client\sounds\whistle.ogg", tag_playerIt, false, _itPos, 15, 1, 300];
			[tag_playerIt,30,30,30,30] call tiig_fnc_shotMarker;
			tag_firstHint = TRUE;
		};

		if(!isNil "tag_tLimit") then {
			if (time >= tag_tLimit) then {

				["Hinting position of IT", "DEEPDEBUG"] call tiig_fnc_log;

				_itPos = getPos tag_playerIt;
				tag_tLimit = time + (round(random 240)+90); // random number between 90 and 240
				playSound3D ["tag_client\sounds\whistle.ogg", tag_playerIt, false, _itPos, 15, 1, 300];
				[tag_playerIt,30,30,30,30] call tiig_fnc_shotMarker;
			};
		};

		sleep 1;
	};
};

["tag_itHint.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;