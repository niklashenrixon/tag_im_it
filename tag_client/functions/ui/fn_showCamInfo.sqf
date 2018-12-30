disableSerialization;

"RSC_TAG_CAMINFO" cutRsc ["TAG_U_CAMINFO","PLAIN"];

_disp = uiNamespace getVariable "TAG_U_CAMINFO_DISP";
_txtInfo = _disp displayCtrl 8642;
_txtInfo ctrlSetText "M to show map then leftclick to place camera.
W/S to move forward and backwards
A/D to move left and right
Q/Z to move up and down
*(NUM) to enable free look
N to switch between nightvision/thermal/heat
0-9 to change camera filter. Press § / ½ to reset filter
B to view player names";