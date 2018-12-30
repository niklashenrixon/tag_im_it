disableSerialization;

createDialog "TAG_U_NEWS";

waitUntil {!isNull (findDisplay 9667);}; // Wait for dialog to appear
_disp = uiNamespace getVariable "TAG_U_NEWS_DISP"; // Get dialog handle

_txtTitle = _disp displayCtrl 8621;
_txtTitle ctrlSetText format["WELCOME %1!",name player];

// HTML CONTENT
_ctrlHTML = _disp ctrlCreate ["RscHTML", 8622];
_ctrlHTML ctrlSetBackgroundColor [-1,-1,-1,0];
_ctrlHTML ctrlSetPosition [
	(0.304062 * safezoneW + safezoneX),
	(0.269 * safezoneH + safezoneY),
	(0.391875 * safezoneW),
	(0.451 * safezoneH)
];
_ctrlHTML ctrlSetTextColor [1, 1, 1, 1];

_ctrlHTML ctrlCommit 0;
_ctrlHTML htmlLoad "http://tagimit.eu/ingame_welcome.html";