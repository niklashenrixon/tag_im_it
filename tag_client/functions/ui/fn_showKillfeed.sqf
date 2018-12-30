params ["_above", "_main", "_below"];
disableSerialization;

"RSC_TAG_KILLFEED" cutRsc ["TAG_U_KILLFEED","PLAIN"];

_disp = uiNamespace getVariable "TAG_U_KILLFEED_DISP";

_txtAbove = _disp displayCtrl 8665;
_txtMain = _disp displayCtrl 8666;
_txtBelow = _disp displayCtrl 8667;

_txtAbove ctrlSetStructuredText parseText format["<t align='center'>%1</t>", _above];
_txtMain ctrlSetStructuredText parseText format["<t align='center'>%1</t>", _main];
_txtBelow ctrlSetStructuredText parseText format["<t align='center'>%1</t>", _below];