/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: tag_statEventHandlers.sqf
*	@Location: {@mod\addons}\tag_server\scripts\
*	@Author: Nixon {nixon@visualized.se}
*	@Version: 0.0.1
*
*	Description:
*		Server-side event handlers used by statistics module
*
*	3rd party (scripts, functions, addons):
*		@Author: 
*		@Description:
*		@Usage: 
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
*	Update player killer and victim on victim death
*/
"UpdatePlayerRoundStat" addPublicVariableEventHandler {
	
	_victim	  = _this select 1 select 0;
	_killer	  = _this select 1 select 1;

	_lifeSpanAsIT = 0;

	if (_victim == tag_playerIt) then {
		_lifeSpanAsIT = round(time - tag_ItTime);

		tag_ItTime = round(time);
		publicVariable "tag_ItTime";

		tag_playerIt = _killer;
		publicVariable "tag_playerIt";
	};

	_lifeSpan = round(time - roundStart);

	_victimID = getPlayerUID _victim;
	_killerID = getPlayerUID _killer;

	[["EH_NAME UpdatePlayerRoundStat triggered by: %1 (%2) | Killer: %3 (%4) | Round ID: %5", name _victim, _victimID, name _killer, _killerID, roundId], "DEEPDEBUG"] call tiig_fnc_log;

	_victimWeapon = currentWeapon _victim;
	_killerWeapon = currentWeapon _killer;

	_killerPOS = getPosASL _killer;
	_victimPOS = getPosASL _victim;

	_killerLocationX = _killerPOS select 0;
	_killerLocationY = _killerPOS select 1;
	_killerLocationZ = _killerPOS select 2;
	_victimLocationX = _victimPOS select 0;
	_victimLocationY = _victimPOS select 1;
	_victimLocationZ = _victimPOS select 2;

	_victimShotsFired = _victim getVariable "tag_shotsFired";
	_victimShotsTaken = _victim getVariable "tag_shotsTaken";
	_headshot		  = _victim getVariable "tag_headshot";
	_distance		  = _victim getVariable "tag_killDist";
	_hitArray		  = _victim getVariable "tag_shotsHitArray";
	_projectile		  = _victim getVariable "tag_projectile";
	tag_humiliation   = FALSE;
	_killDist = round(_distance * (10 ^ 2)) / (10 ^ 2);

	if (isNil "_headshot") then {
		_headshot = 0;
	};

	switch (_projectile) do {
		case "APERSTripMine_Wire_Ammo": { _killerWeapon = "APERSTripMine_Wire_Mag"; tag_humiliation = TRUE; };
		case "M_Titan_AP":				{ _killerWeapon = "launch_B_Titan_short_F"; tag_humiliation = TRUE; };
	};

	// Weapon updates
	switch (_killerWeapon) do {
		case "hgun_Rook40_F":			{ _query = format["PlayerKill_hgun_Rook40_F:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "SMG_01_Holo_F":			{ _query = format["PlayerKill_SMG_01_Holo_F:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "arifle_MX_F":				{ _query = format["PlayerKill_arifle_MX_F:%1",			   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "arifle_Mk20_F":			{ _query = format["PlayerKill_arifle_Mk20_F:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "arifle_Katiba_F":			{ _query = format["PlayerKill_arifle_Katiba_F:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "kio_l85a2_ris":			{ _query = format["PlayerKill_kio_l85a2_ris:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_g3a3":			{ _query = format["PlayerKill_hlc_rifle_g3a3:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_g3ka4":			{ _query = format["PlayerKill_hlc_rifle_g3ka4:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_auga3":			{ _query = format["PlayerKill_hlc_rifle_auga3:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_RU5562":		{ _query = format["PlayerKill_hlc_rifle_RU5562:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_auga2para_b":	{ _query = format["PlayerKill_hlc_rifle_auga2para_b:%1",   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_Bushmaster300": { _query = format["PlayerKill_hlc_rifle_Bushmaster300:%1", _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_vendimus":		{ _query = format["PlayerKill_hlc_rifle_vendimus:%1",	   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "kio_sr25":				{ _query = format["PlayerKill_kio_sr25:%1",				   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_hk51":			{ _query = format["PlayerKill_hlc_rifle_hk51:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_hk53":			{ _query = format["PlayerKill_hlc_rifle_hk53:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_Colt727":		{ _query = format["PlayerKill_hlc_rifle_Colt727:%1",	   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_honeybadger":	{ _query = format["PlayerKill_hlc_rifle_honeybadger:%1",   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_bcmjack":		{ _query = format["PlayerKill_hlc_rifle_bcmjack:%1",	   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "kio_l85a2_pink":			{ _query = format["PlayerKill_kio_l85a2_pink:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_saiga12k":		{ _query = format["PlayerKill_hlc_rifle_saiga12k:%1",	   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_aek971":		{ _query = format["PlayerKill_hlc_rifle_aek971:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_ak74":			{ _query = format["PlayerKill_hlc_rifle_ak74:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_aks74":			{ _query = format["PlayerKill_hlc_rifle_aks74:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_aks74u":		{ _query = format["PlayerKill_hlc_rifle_aks74u:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_ak47":			{ _query = format["PlayerKill_hlc_rifle_ak47:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_akm":			{ _query = format["PlayerKill_hlc_rifle_akm:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_rpk":			{ _query = format["PlayerKill_hlc_rifle_rpk:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_ak12":			{ _query = format["PlayerKill_hlc_rifle_ak12:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_smg_mp5a4":			{ _query = format["PlayerKill_hlc_smg_mp5a4:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_smg_mp5n":			{ _query = format["PlayerKill_hlc_smg_mp5n:%1",			   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_smg_mp510":			{ _query = format["PlayerKill_hlc_smg_mp510:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_smg_mp5sd5":			{ _query = format["PlayerKill_hlc_smg_mp5sd5:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_smg_mp5sd6":			{ _query = format["PlayerKill_hlc_smg_mp5sd6:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36A1":			{ _query = format["PlayerKill_hlc_rifle_G36A1:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36KA1":		{ _query = format["PlayerKill_hlc_rifle_G36KA1:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36C":			{ _query = format["PlayerKill_hlc_rifle_G36C:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36E1":			{ _query = format["PlayerKill_hlc_rifle_G36E1:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36KE1":		{ _query = format["PlayerKill_hlc_rifle_G36KE1:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36V":			{ _query = format["PlayerKill_hlc_rifle_G36V:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36KV":			{ _query = format["PlayerKill_hlc_rifle_G36KV:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36CV":			{ _query = format["PlayerKill_hlc_rifle_G36CV:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36TAC":		{ _query = format["PlayerKill_hlc_rifle_G36TAC:%1",		   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36CTAC":		{ _query = format["PlayerKill_hlc_rifle_G36CTAC:%1",	   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36MLIC":		{ _query = format["PlayerKill_hlc_rifle_G36MLIC:%1",	   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		case "hlc_rifle_G36CMLIC":		{ _query = format["PlayerKill_hlc_rifle_G36CMLIC:%1",	   _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
		
		case "APERSTripMine_Wire_Mag":	{ _query = format["PlayerKill_APERSTripMine_Wire_Mag:%1",  _killerID]; [_query, 1, true] call tiis_fnc_aSync; };
	};

	// Update victim's round stats
	_query = format [
		"UpdatePlayerRoundStatKilled:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16",
		_lifeSpan,
		_lifeSpanAsIT,
		_victimShotsFired,
		_victimShotsTaken,
		_killerID,
		_headshot,
		_killDist,
		_killerWeapon,
		_killerLocationX,
		_killerLocationY,
		_killerLocationZ,
		_victimLocationX,
		_victimLocationY,
		_victimLocationZ,
		roundId,
		_victimID
	]; [_query, 1, true] call tiis_fnc_aSync;

	// Did the killer do the longest headshot/kill?
	if (_headshot == 1) then {
		if (_distance >= 100) then {
			_distanceScore = round(_distance / 2);
			hsScore = _distanceScore + 200;
		} else {
			hsScore = 200;
		};

		_query = format [
			"UpdatePlayerLongestHeadshot:%1:%2:%3:%4:%5",
			_headshot,
			hsScore,
			_killDist,
			_killerWeapon,
			_killerID
		];

		_queryScore = format [
			"UpdatePlayerRoundStatScore:%1:%2:%3",
			hsScore,
			roundId,
			_killerID
		]; [_queryScore, 1, true] call tiis_fnc_aSync;

	} else {
		if (_distance >= 100) then {
			_distanceScore = round(_distance / 2);
			killScore = _distanceScore + 100;
		} else {
			killScore = 100;
		};

		if (tag_humiliation) then { killScore = killScore + 100; };

		_query = format [
			"UpdatePlayerLongestKill:%1:%2:%3:%4",
			killScore,
			_killDist,
			_killerWeapon,
			_killerID
		];

		_queryScore = format [
			"UpdatePlayerRoundStatScore:%1:%2:%3",
			killScore,
			roundId,
			_killerID
		]; [_queryScore, 1, true] call tiis_fnc_aSync;

	}; [_query, 1, true] call tiis_fnc_aSync;

	// Give the killer +1 kill
	_query = format [
		"UpdatePlayerRoundStat:%1:%2",
		roundId,
		_killerID
	]; [_query, 1, true] call tiis_fnc_aSync;

	// Update death +1 on victim
	_query = format [
		"UpdatePlayerStatDeaths:%1:%2:%3",
		_victimShotsFired,
		_victimShotsTaken,
		_victimID
	]; [_query, 1, true] call tiis_fnc_aSync;

	// Give units there "hits"
	["STATS_EVENT_DEATH: Distribute hits started", "DEEPDEBUG"] call tiig_fnc_log;
	[["STATS_EVENT_DEATH: Hits unmodified data: %1", _hitArray], "DEEPDEBUG"] call tiig_fnc_log;

	[_hitArray, "--- STATS_EVENT_DEATH:"] call tag_fn_distributeHits;
};

/*
*	Update player on win
*/
"UpdatePlayerRoundStatWinner" addPublicVariableEventHandler {
	
	_winner   = _this select 1 select 0;
	_winnerID = _this select 1 select 1;

	[["EH_NAME UpdatePlayerRoundStatWinner triggered by: %1 (%2) | Round ID: %3", name _winner, _winnerID, roundId], "DEEPDEBUG"] call tiig_fnc_log;

	_winnerShotsFired = _winner getVariable "tag_shotsFired";
	_winnerShotsTaken = _winner getVariable "tag_shotsTaken";
	_winnerHitArray	  = _winner getVariable "tag_shotsHitArray";

	/*  SKRIV OM DETTA SÅ DET PASSAR NYA SPELFORMEN
	if (participants >= tag_minPlayerSmall && participants <= (tag_playersRequiredSmall select 1)) then { wScore = 100; };
	if (participants >= (tag_playersRequiredMedium select 0) && participants <= (tag_playersRequiredMedium select 1)) then { wScore = 200; };
	if (participants >= (tag_playersRequiredLarge select 0) && participants <= (tag_playersRequiredLarge select 1)) then { wScore = 400; };
	*/

	wScore = 100;

	_lifeSpan = round(time - roundStart);
	_lifeSpanAsIT = 0;

	if (_winner == tag_firstIT) then {
		wScore = wScore * 2;
		_lifeSpanAsIT = round(time - tag_ItTime);
	};

	[["STATS_EVENT_WINNER: Update winner (roundStats) | Life span: %1 | Life span as IT: %2 | Shots fired: %3 | Shots taken: %4 | Score: %5", _lifeSpan, _lifeSpanAsIT, _winnerShotsFired, _winnerShotsTaken, wScore], "DEEPDEBUG"] call tiig_fnc_log;

	// Update winner round stats
	_query = format [
		"UpdatePlayerRoundStatWinner:%1:%2:%3:%4:%5:%6:%7",
		_lifeSpan,
		_lifeSpanAsIT,
		_winnerShotsFired,
		_winnerShotsTaken,
		wScore,
		roundId,
		_winnerID
	]; [_query, 1, true] call tiis_fnc_aSync;

	[["STATS_EVENT_WINNER: Update winner (personalStats) | Shots fired: %1 | Shots taken: %2 | Score: %3", _winnerShotsFired, _winnerShotsTaken, wScore], "DEEPDEBUG"] call tiig_fnc_log;

	// Update winner personal stats
	_query = format [
		"UpdatePlayerStatWinScore:%1:%2:%3:%4",
		_winnerShotsFired,
		_winnerShotsTaken,
		wScore,
		_winnerID
	]; [_query, 1, true] call tiis_fnc_aSync;

	// Give units there "hits"
	["STATS_EVENT_WINNER: Distribute hits started", "DEEPDEBUG"] call tiig_fnc_log;
	[["STATS_EVENT_WINNER: Hits unmodified data: %1", _winnerHitArray], "DEEPDEBUG"] call tiig_fnc_log;

	[_winnerHitArray, "STATS_EVENT_WINNER:"] call tag_fn_distributeHits;
};

/*
*	Update player deaths on respawn (suicide)
*/
"UpdatePlayerDeathOnRespawn" addPublicVariableEventHandler {
	_unit	= _this select 1 select 0;
	_unitID = _this select 1 select 1;

	[["EH_NAME UpdatePlayerDeathOnRespawn triggered by: %1 (%2) | Round ID: %3", name _unit, _unitID, roundId], "DEEPDEBUG"] call tiig_fnc_log;

	_shotsFired = _unit getVariable "tag_shotsFired";
	_shotsTaken = _unit getVariable "tag_shotsTaken";
	_hitArray	= _unit getVariable "tag_shotsHitArray";

	_lifeSpan = round(time - roundStart);
	_lifeSpanAsIT = 0;

	if (_unit == tag_playerIt) then {
		_lifeSpanAsIT = round(time - tag_ItTime);

		tag_ItTime = round(time);
		publicVariable "tag_ItTime";
	};

	_query = format [
		"UpdatePlayerStatSuicideDeath:%1:%2:%3",
		_shotsFired,
		_shotsTaken,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	_query = format [
		"UpdatePlayerRoundStatSuicideDeath:%1:%2:%3:%4:%5:%6",
		_lifeSpan,
		_lifeSpanAsIT,
		_shotsFired,
		_shotsTaken,
		roundId,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	// Give units there "hits"
	["STATS_EVENT_DEATH_ON_RESPAWN (SUICIDE): Distribute hits started", "DEEPDEBUG"] call tiig_fnc_log;
	[["STATS_EVENT_DEATH_ON_RESPAWN (SUICIDE): Hits unmodified data: %1", _hitArray], "DEEPDEBUG"] call tiig_fnc_log;

	[_hitArray, "STATS_EVENT_DEATH_ON_RESPAWN (SUICIDE):"] call tag_fn_distributeHits;
};

/*
*	Update player anti-camp warnings
*/
"UpdatePlayerAntiCamp" addPublicVariableEventHandler {
	_unit 	= _this select 1 select 0;
	_unitID = _this select 1 select 1;
	
	[["EH_NAME UpdatePlayerAntiCamp triggered by: %1 (%2) | Round ID: %3", name _unit, _unitID, roundId], "DEEPDEBUG"] call tiig_fnc_log;

	_query = format [
		"UpdatePlayerStatAntiCamp:%1",
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	_query = format [
		"UpdatePlayerRoundAntiCamp:%1:%2",
		roundId,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;
};

/*
*	Update player anti-camp death
*/
"UpdatePlayerAntiCampDeath" addPublicVariableEventHandler {
	_unit 	= _this select 1 select 0;
	_unitID = _this select 1 select 1;
	
	[["EH_NAME UpdatePlayerAntiCampDeath triggered by: %1 (%2) | Round ID: %3", name _unit, _unitID, roundId], "DEEPDEBUG"] call tiig_fnc_log;

	_shotsFired = _unit getVariable "tag_shotsFired";
	_shotsTaken = _unit getVariable "tag_shotsTaken";
	_hitArray	= _unit getVariable "tag_shotsHitArray";

	_lifeSpan = round(time - roundStart);
	_lifeSpanAsIT = 0;

	if (_unit == tag_playerIt) then {
		_lifeSpanAsIT = round(time - tag_ItTime);
	};

	_query = format [
		"UpdatePlayerStatAntiCampDeath:%1:%2:%3",
		_shotsFired,
		_shotsTaken,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	_query = format [
		"UpdatePlayerRoundAntiCampDeath:%1:%2:%3:%4:%5:%6",
		_lifeSpan,
		_lifeSpanAsIT,
		_shotsFired,
		_shotsTaken,
		roundId,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	// Give units there "hits"
	["STATS_EVENT_ANTICAMP_DEATH: Distribute hits started", "DEEPDEBUG"] call tiig_fnc_log;
	[["STATS_EVENT_ANTICAMP_DEATH: Hits unmodified data: %1", _hitArray], "DEEPDEBUG"] call tiig_fnc_log;

	[_hitArray, "STATS_EVENT_ANTICAMP_DEATH:"] call tag_fn_distributeHits;
};

/*
*	Update player on disconnect
*/
"UpdatePlayerDeathOnDisconnect" addPublicVariableEventHandler {
	_unit	= _this select 1 select 0;
	_unitID = _this select 1 select 1;

	[["EH_NAME UpdatePlayerDeathOnDisconnect triggered by: %1 (%2) | Round ID: %3", name _unit, _unitID, roundId], "DEEPDEBUG"] call tiig_fnc_log;

	/*
	_shotsFired = _unit getVariable "tag_shotsFired";
	_shotsTaken = _unit getVariable "tag_shotsTaken";
	_hitArray	= _unit getVariable "tag_shotsHitArray";
	*/

	_lifeSpan = round(time - roundStart);
	_lifeSpanAsIT = 0;

	if (_unit == tag_playerIt) then {
		_lifeSpanAsIT = round(time - tag_ItTime);

		tag_ItTime = round(time);
		publicVariable "tag_ItTime";
	};

	_query = format [
		"UpdatePlayerRoundStatDisconnected:%1:%2:%3:%4",
		_lifeSpan,
		_lifeSpanAsIT,
		roundId,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	/*
	// Give units there "hits"
	["--- STATS_EVENT_ANTICAMP_DEATH: Distribute hits started ---"] call tiig_fnc_log;
	[["--- STATS_EVENT_ANTICAMP_DEATH: Hits unmodified data: %1 ---"],[_hitArray]] call tiig_fnc_log;

	[_hitArray, "--- STATS_EVENT_ANTICAMP_DEATH:"] call tag_fn_distributeHits;
	*/
};

/*
*	Update player on draw
*/
"UpdatePlayerOnDraw" addPublicVariableEventHandler {
	_unit	= _this select 1 select 0;
	_unitID	= _this select 1 select 1;

	[["EH_NAME UpdatePlayerOnDraw triggered by: %1 (%2) | Round ID: %3", name _unit, _unitID, roundId], "DEEPDEBUG"] call tiig_fnc_log;

	_shotsFired = _unit getVariable "tag_shotsFired";
	_shotsTaken = _unit getVariable "tag_shotsTaken";
	_hitArray	= _unit getVariable "tag_shotsHitArray";

	_lifeSpan = round(time - roundStart);
	_lifeSpanAsIT = 0;

	if (_unit == tag_playerIt) then {
		_lifeSpanAsIT = round(time - tag_ItTime);
	};

	_query = format [
		"UpdatePlayerStatDraw:%1:%2:%3",
		_shotsFired,
		_shotsTaken,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	_query = format [
		"UpdatePlayerRoundStatDraw:%1:%2:%3:%4:%5:%6",
		_lifeSpan,
		_lifeSpanAsIT,
		_shotsFired,
		_shotsTaken,
		roundId,
		_unitID
	]; [_query, 1, true] call tiis_fnc_aSync;

	// Give units there "hits"
	["STATS_EVENT_DRAW: Distribute hits started", "DEEPDEBUG"] call tiig_fnc_log;
	[["STATS_EVENT_DRAW: Hits unmodified data: %1", _hitArray], "DEEPDEBUG"] call tiig_fnc_log;

	[_hitArray, "STATS_EVENT_DRAW:"] call tag_fn_distributeHits;
};

["tag_statsEventHandlers.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;