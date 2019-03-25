/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: clientVars.sqf
*	@Location: {@mod\addons}\tag_client\data\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Client variables, accessable only too client
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

// ACS (anti-camp system)
#define campingTime   75	// Time until player gets a warning
#define redeemLimit   120	// Time until player has redeemed themself
#define detectionRate 0.3	// Movement detection rate

// Kill feedback
TAG_DISTBONUS = 50;    // How many meters before giving distance bonus on kill
TAG_DANGERSOUND = 50;  // How near the last 2 players have to be eachother for danger sound to start playing