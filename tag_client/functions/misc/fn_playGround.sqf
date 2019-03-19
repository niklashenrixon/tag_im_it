/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: fn_playGround.sqf
*	@Location: {@mod\addons}\tag_client\functions\misc\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Spawns trigger and visible circle around the player as a bounderie
*
*	Example(s):
*		0 spawn tiig_fnc_playGround;
*
*	Parameter(s):
*
*	Returns:
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

// True if server has chosen "map" and player is moved
waitUntil {	if (player getVariable "tag_unitPlaying") exitWith { call tiig_fnc_deathCircle; TRUE }; };

waitUntil {	if (tag_gameInProgress) exitWith { TRUE }; };

["Spawning player bounderies", "DEBUG"] call tiig_fnc_log;

_pos = tag_playGroundSettings select 0;
_size = tag_playGroundSettings select 1;

tag_outsidePlayGround = false;

tag_deathCircle = createTrigger ["EmptyDetector", _pos, false];
tag_deathCircle setTriggerArea [_size, _size, 0, false];
tag_deathCircle setTriggerActivation ["ANYPLAYER", "NOT PRESENT", true];
tag_deathCircle setTriggerStatements [
	"player in thisList",
	"tag_outsidePlayGround = FALSE;",
	"tag_outsidePlayGround = TRUE; tag_outsideTime = time + 3;"
];

while { tag_gameInProgress && player getVariable "tag_unitPlaying" } do {

	if (tag_outsidePlayGround) then {
		_message = "YOU ARE OUTSIDE THE PLAYZONE";
		_fMessage = format["<t color='#db0015'>%1</t>", _message];
		[_fMessage, 1, 0, 0.5, 15, 9025, 'any', nil, 'local'] call tiig_fnc_messanger;
		'dynamicBlur' ppEffectEnable true;
		'dynamicBlur' ppEffectAdjust [5];
		'dynamicBlur' ppEffectCommit 2;
		2 fadeSound 0.2;

		if(time >= tag_outsideTime) then {
			tag_outsideTime = time + 3;
			player setDamage (damage player + 0.1);
			if(damage player >= 0.5) then { player setHitPointDamage ["hitLegs", 0.48]; };
			[["Damage player: %1", damage player]] call tiig_fnc_log;
		};
	};

	if (!tag_outsidePlayGround) then {
		['', 1, 0, 0.5, 0.5, 9025, 'any', nil, 'local'] call tiig_fnc_messanger;
		'dynamicBlur' ppEffectEnable true;
		'dynamicBlur' ppEffectAdjust [0];
		'dynamicBlur' ppEffectCommit 1;
		1 fadeSound 1; 
	};

	sleep 0.2;
};