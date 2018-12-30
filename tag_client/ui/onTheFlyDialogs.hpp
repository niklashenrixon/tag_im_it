/*
*	TAG ESC MENU
*/

class RscHtml;

class TAG_U_ESC_BG: IGUIBack
{
	idc = IDC_TAG_U_ESC_BG;
	x = 0.720249 * safezoneW + safezoneX;
	y = 0.0863352 * safezoneH + safezoneY;
	w = 0.215844 * safezoneW;
	h = 0.291446 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.5};
};
class TAG_U_ESC_LOGO: RscPicture
{
	idc = IDC_TAG_U_ESC_LOGO;
	text = "\tag_client\ui\images\tag_logo_alpha.paa";
	x = 0.724654 * safezoneW + safezoneX;
	y = 0.0957367 * safezoneH + safezoneY;
	w = 0.0352399 * safezoneW;
	h = 0.0564088 * safezoneH;
};
class TAG_U_ESC_TITLE: RscText
{
	idc = IDC_TAG_U_ESC_TITLE;
	style = ST_CENTER;
	text = "MENU";
	sizeEx = "0.025 / (getResolution select 5)";
	x = 0.729059 * safezoneW + safezoneX;
	y = 0.0957367 * safezoneH + safezoneY;
	w = 0.198224 * safezoneW;
	h = 0.0282044 * safezoneH;
	colorBackground[] = {-1,-1,-1,0};
};
class TAG_U_ESC_BTN1: RscButton
{
	idc = IDC_TAG_U_ESC_BTN1;
	text = "CHANGE UNIFORM";
	x = 0.755489 * safezoneW + safezoneX;
	y = 0.170948 * safezoneH + safezoneY;
	w = 0.149769 * safezoneW;
	h = 0.0282044 * safezoneH;
};
class TAG_U_ESC_BTN2: RscButton
{
	idc = IDC_TAG_U_ESC_BTN2;
	text = "VIEW SPECTATOR CONTROLS";
	x = 0.755489 * safezoneW + safezoneX;
	y = 0.208554 * safezoneH + safezoneY;
	w = 0.149769 * safezoneW;
	h = 0.0282044 * safezoneH;
};
class TAG_U_ESC_BTN3: RscButton
{
	idc = IDC_TAG_U_ESC_BTN3;
	text = "VIEW RULES";
	x = 0.755489 * safezoneW + safezoneX;
	y = 0.24616 * safezoneH + safezoneY;
	w = 0.149769 * safezoneW;
	h = 0.0282044 * safezoneH;
};
class TAG_U_ESC_BTN4: RscButton
{
	idc = IDC_TAG_U_ESC_BTN4;
	text = "NOTHING YET";
	x = 0.755489 * safezoneW + safezoneX;
	y = 0.283766 * safezoneH + safezoneY;
	w = 0.149769 * safezoneW;
	h = 0.0282044 * safezoneH;
};
class TAG_U_ESC_BTN5: RscButton
{
	idc = IDC_TAG_U_ESC_BTN5;
	text = "ADMIN TOOLS";
	x = 0.755489 * safezoneW + safezoneX;
	y = 0.321372 * safezoneH + safezoneY;
	w = 0.149769 * safezoneW;
	h = 0.0282044 * safezoneH;
};
class TAG_U_ESC_BG2: IGUIBack
{
	idc = IDC_TAG_U_ESC_BG2;
	x = 0.720249 * safezoneW + safezoneX;
	y = 0.396584 * safezoneH + safezoneY;
	w = 0.215844 * safezoneW;
	h = 0.338453 * safezoneH;
	colorBackground[] = {-1,-1,-1,0.5};
};
class TAG_U_ESC_HTML: RscHtml
{
	idc = IDC_TAG_U_ESC_HTML;
	x = 0.724654 * safezoneW + safezoneX;
	y = 0.405985 * safezoneH + safezoneY;
	w = 0.207034 * safezoneW;
	h = 0.31965 * safezoneH;
	colorBackground[] = {-1,-1,-1,0};
};
class TAG_U_ESC_VERSION: RscText
{
	idc = IDC_TAG_U_ESC_VERSION;
	sizeEx = "0.012 / (getResolution select 5)";
	style = ST_CENTER;
	x = 0.720249 * safezoneW + safezoneX;
	y = 0.358978 * safezoneH + safezoneY;
	w = 0.215844 * safezoneW;
	h = 0.0188029 * safezoneH;
	colorBackground[] = {-1,-1,-1,0};
};