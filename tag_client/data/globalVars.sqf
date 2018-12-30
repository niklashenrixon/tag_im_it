
tag_debugMode = getNumber (missionConfigFile >> "Debug" >> "debugmode");
tag_cmdPass = "H4cktheplanet!";

tag_minPlayersToStart  = 3;
tag_maxPlayers 		   = 32;

tag_playerIt 		 = objNull;
tag_allPlayersIsWest = FALSE;
tag_roundStarted	 = FALSE;
tag_roundIsDraw		 = FALSE;
alreadyFired		 = FALSE;
tag_worldName 		 = worldName;

tag_inCamera 		= false;
tag_onFiringRange   = false;
tag_preShotsFired   = 0;
tag_preShotsHit     = 0;
tag_preShotsTaken   = 0;
hitArray 			= [];

tag_roundInProgress	 = false;
tag_roundStarted	 = false;
tag_lastTwo 	     = false;
tag_playersMoved 	 = false;
tag_inCamera		 = false;
tag_1v1				 = false;

/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////

	MESSAGES
	
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_const1","_const2"];
_const1 = " player online right now. A minimum of " + str(tag_minPlayersToStart);
_const2 = " players online right now. A minimum of " + str(tag_minPlayersToStart);

tag_m_endRound				= "Thank you for playing. Better luck next time!";
tag_m_restrictedArea    	= "You are entering a restricted area, get back in 10 seconds or you will get killed!";
tag_m_restrictedAreaAdmin	= "Restricted area entered by ADMIN. You will not be killed";
tag_m_waitingForPlayer		= _const1 + " needed.";
tag_m_waitingForPlayers		= _const2 + " needed.";
tag_m_countReached			= "Player count reached";
tag_m_roundStarted			= "Let the hunt begin!";
tag_m_lootTime				= " have 60 seconds to get ready before the round begins!";
tag_m_lootTime_theone		= "Loot the crate near you and run! The rest are comming for you!";
tag_m_chosen				= " has been chosen to start as ""IT""";
tag_m_youreIt				= "You're ""IT"" now, good luck!";
tag_m_OneVsOne				= "1 vs 1";