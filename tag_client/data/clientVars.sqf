/*
*	Anti Camp System (ACS)
*/
#define campingTime   75	// Time until player gets a warning
#define redeemLimit   120	// Time until player has redeemed themself
#define detectionRate 0.3	// Movement detection rate

/*
*	Kill feedback
*/
TAG_DISTBONUS = 100; // How many meters before giving distance bonus on kill

TAG_DANGERSOUND = 50; // How near the last 2 players have to be eachother for danger sound to start playing

tag_inCamera 		= false;
tag_onFiringRange   = false;
tag_preShotsFired   = 0;
tag_preShotsHit     = 0;
tag_preShotsTaken   = 0;
hitArray 			= [];

tag_runningDist	     = 20;				// Number in meters from wish a player can run from the start position when game is NOT started (spawnLock)
tag_secondSpawnLock	 = true;
tag_deadSpawnLock	 = false;
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