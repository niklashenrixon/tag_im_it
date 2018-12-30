private "_scoreBoard";

_keyDownScore = (finddisplay 46) displayAddEventhandler ["keyDown",{
	_key = _this select 1;

	if (_key == 15) then {
		disableSerialization;
		"RSC_TAG_SCORE" cutRsc ["TAG_U_SCOREBOARD","PLAIN"];
		_disp = uiNamespace getVariable "TAG_U_SCOREBOARD_DISP";
	};
}];

_keyUpScore = (finddisplay 46) displayAddEventhandler ["keyUp",{
	_key = _this select 1;
	if (_key == 15) then { "RSC_TAG_SCORE" cutFadeOut 0; };
}];