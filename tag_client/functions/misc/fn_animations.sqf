tag_squat1 = FALSE;
tag_squat2 = FALSE;
tag_epicSplit = FALSE;

_keyDown = (finddisplay 46) displayAddEventhandler ["keyDown",{
	_key = _this select 1;
	_ctrl = _this select 3;

	if (_key in (actionkeys 'User14')) then {
		if(tag_epicSplit) then {
			tag_epicSplit = FALSE;
			player switchMove "";
		} else {
			tag_epicSplit = TRUE;
			player switchMove "Acts_EpicSplit";
		};
	};

	if (_key in (actionkeys 'User15')) then {
		if(tag_squat2) then {
			tag_squat2 = FALSE;
			player switchMove "";
		} else {
			tag_squat2 = TRUE;
			player switchMove "Acts_Executioner_Squat";
		};
	};

	if (_key in (actionkeys 'User16')) then {
		if(tag_squat1) then {
			tag_squat1 = FALSE;
			player switchMove "";
		} else {
			tag_squat1 = TRUE;
			player switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_4";
		};
	};
}];

//(findDisplay 46) displayRemoveEventhandler ["keydown",_keyDown];