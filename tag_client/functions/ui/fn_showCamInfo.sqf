disableSerialization;

"RSC_TAG_CAMINFO" cutRsc ["TAG_U_CAMINFO","PLAIN"];

_disp = uiNamespace getVariable "TAG_U_CAMINFO_DISP";
_txtInfo = _disp displayCtrl 8642;

_lotsOfText = "* <t color='#ff0000'>M</t> to show map then leftclick to place camera.<br/>
* <t color='#ff0000'>B</t> to view player names<br/>
* <t color='#ff0000'>W/S</t> to move forward and backwards<br/>
* <t color='#ff0000'>A/D</t> to move left and right<br/>
* <t color='#ff0000'>Q/Z</t> to move up and down<br/>
* <t color='#ff0000'>*(NUM)</t> to enable free look<br/>
* <t color='#ff0000'>N</t> to switch between nightvision/thermal/heat<br/>
* <t color='#ff0000'>scroll(MIDDLE MOUSE BUTTON)</t> to change focus";

_txtInfo ctrlSetStructuredText parseText format["<t size='0.7'>%1</t>", _lotsOfText];