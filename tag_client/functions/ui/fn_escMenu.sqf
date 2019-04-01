[] spawn {
	while {true} do {
		waitUntil {!isNull (findDisplay 49)};

		disableSerialization;
		_display = findDisplay 49;

		/*
		*	TAG MENU
		*/

		// BACKGROUND
		_ctrl1 = _display ctrlCreate ["TAG_U_ESC_BG", 8653];

		// LOGO
		_ctrl2 = _display ctrlCreate ["TAG_U_ESC_LOGO", 8647];

		// TITLE
		_ctrl3 = _display ctrlCreate ["TAG_U_ESC_TITLE", 8645];

		// BUTTON 1 (CHANGE UNIFORM)
		_ctrlBtn1 = _display ctrlCreate ["TAG_U_ESC_BTN1", 8648];
		_ctrlBtn1 buttonSetAction "(findDisplay 49) closeDisplay 1; call tiic_fnc_changeUniform;";

		// BUTTON 2 (SPECTATOR CAMERA)
		_ctrlBtn2 = _display ctrlCreate ["TAG_U_ESC_BTN2", 8649];
		_ctrlBtn2 buttonSetAction "(findDisplay 49) closeDisplay 1; [player] call tiic_fnc_cameraSystem;";
		if (tag_gameInProgress) then { _ctrlBtn2 ctrlEnable TRUE; } else { _ctrlBtn2 ctrlEnable FALSE; };

		// BUTTON 3 (VIEW SPECTATOR CONTROLS)
		_ctrlBtn3 = _display ctrlCreate ["TAG_U_ESC_BTN3", 8650];
		_ctrlBtn3 buttonSetAction "(findDisplay 49) closeDisplay 1; call tiic_fnc_showCamInfo;";
		if (tag_gameInProgress) then { _ctrlBtn3 ctrlEnable TRUE; } else { _ctrlBtn3 ctrlEnable FALSE; };

		// BUTTON 4 (VIEW RULES)
		_ctrlBtn4 = _display ctrlCreate ["TAG_U_ESC_BTN4", 8651];
		_ctrlBtn4 buttonSetAction "(findDisplay 49) closeDisplay 1; call tiic_fnc_showHud;";
		_ctrlBtn4 ctrlEnable FALSE;

		// BUTTON 5 (ADMIN TOOLS)
		_ctrlBtn5 = _display ctrlCreate ["TAG_U_ESC_BTN5", 8652];
		_ctrlBtn5 buttonSetAction "(findDisplay 49) closeDisplay 1; call tiic_fnc_showAdmin;";

		// Disable button 5 if not logged in
		_adminState = admin owner player;
		if (_adminState >= 1 || (getPlayerUID(player) in tag_adminList)) then { _ctrlBtn5 ctrlEnable TRUE; } else { _ctrlBtn5 ctrlEnable FALSE; };

		// VERSION
		_ctrlVersion = _display ctrlCreate ["TAG_U_ESC_VERSION", 8655];
		_version = parseText format["Build name: " + tag_clientBuildName +" | Branch: " + tag_clientBranch];
		_ctrlVersion ctrlSetText format ["%1", _version];
		_ctrlVersion ctrlSetTextColor [1, 0.8, 0, 1];

		/*
		*	WEB WINDOW
		*/

		// BACKGROUND
		_display ctrlCreate ["TAG_U_ESC_BG2", 8654];

		// CONTENT
		_ctrlHTML = _display ctrlCreate ["RscHTML", 8646];
		_ctrlHTML ctrlSetBackgroundColor [-1,-1,-1,0];
		_ctrlHTML ctrlSetPosition [
			(0.724654 * safezoneW + safezoneX),
			(0.405985 * safezoneH + safezoneY),
			(0.207034 * safezoneW),
			(0.31965 * safezoneH)
		];
		_ctrlHTML ctrlSetTextColor [1, 1, 1, 1];

		_ctrlHTML ctrlCommit 0;
		_ctrlHTML htmlLoad "http://tagimit.eu/ingame_news.html";

		waitUntil{isNull (findDisplay 49)};
	};
};