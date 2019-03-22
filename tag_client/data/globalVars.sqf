
tag_debugMode = getNumber (missionConfigFile >> "Debug" >> "debugmode");
tag_cmdPass = "admin";

tag_minPlayersToStart  = 3;
tag_maxPlayers 		   = 32;

// Score
TAG_SCORE_BASE = 100;  // Base score for 1 kill
TAG_SCORE_HS = 200;    // Headshot score per headshot
TAG_SCORE_FIRST = 500; // Score if players won and was the first IT

tag_allPlayersIsWest = FALSE;
tag_roundStarted	 = FALSE;
tag_roundIsDraw		 = FALSE;
alreadyFired		 = FALSE;
tag_worldName 		 = worldName;

tag_inCamera 		= false;
tag_onFiringRange   = false;

tag_lastTwo 	     = false;
tag_playersMoved 	 = false;
tag_inCamera		 = false;
tag_1v1				 = false;

/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////

	MESSAGES
	
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
tag_m_endRound				= "Thank you for playing. Better luck next time!";
tag_m_restrictedArea    	= "You are entering a restricted area, get back in 10 seconds or you will get killed!";
tag_m_restrictedAreaAdmin	= "Restricted area entered by ADMIN. You will not be killed";
tag_m_countReached			= "Player count reached";
tag_m_roundStarted			= "Let the hunt begin!";
tag_m_lootTime				= " have 60 seconds to get ready before the round begins!";
tag_m_lootTime_theone		= "Loot the crate near you and run! The rest are comming for you!";
tag_m_chosen				= " has been chosen to start as ""IT""";
tag_m_youreIt				= "You're ""IT"" now, good luck!";
tag_m_OneVsOne				= "1 vs 1";
*/