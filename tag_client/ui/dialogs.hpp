class RscText;
class RscEdit;
class IGUIBack;
class RscButton;
class RscPicture;
class RscListBox;
class RscStructuredText;

/*
*	CUSTOM PARENT CLASSES
*/
class TAG_UI_LISTBOX: RscListbox {
	sizeEx = "0.015 / (getResolution select 5)";
};

/*
*	ADMIN UI
*/
class TAG_U_ADMIN {
	idd = 9666; 
	duration = 1e+1000; 
	fadeIn = 1; 
	fadeOut = 1;
	onLoad = "uiNamespace setVariable ['TAG_U_ADMIN_DISP', _this select 0];"; 
	   
	class Controls {

		class TAG_U_ADMIN_BG: IGUIBack
		{
			idc = IDC_TAG_U_ADMIN_BG;
			x = 0.304063 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.506 * safezoneH;
		};
		class TAG_U_ADMIN_UNITLIST: TAG_UI_LISTBOX
		{
			idc = IDC_TAG_U_ADMIN_UNITLIST;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class TAG_U_ADMIN_UNITLIST_KICK: RscButton
		{
			idc = IDC_TAG_U_ADMIN_UNITLIST_KICK;
			text = "KICK";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_UNITLIST_BAN: RscButton
		{
			idc = IDC_TAG_U_ADMIN_UNITLIST_BAN;
			text = "BAN";
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_WEATHERLIST: TAG_UI_LISTBOX
		{
			idc = IDC_TAG_U_ADMIN_WEATHERLIST;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.143 * safezoneH;
		};
		class TAG_U_ADMIN_WEATHERLIST_BTN_OK: RscButton
		{
			idc = IDC_TAG_U_ADMIN_WEATHERLIST_BTN_OK;
			text = "CHANGE";
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_UNITLIST_LABEL: RscText
		{
			idc = IDC_TAG_U_ADMIN_UNITLIST_LABEL;
			sizeEx = "0.020 / (getResolution select 5)";
			text = "UNIT LIST";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_WEATHERLIST_LABEL: RscText
		{
			idc = IDC_TAG_U_ADMIN_WEATHERLIST_LABEL;
			text = "WEATHER PRESETS";
			sizeEx = "0.020 / (getResolution select 5)";
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_SERVERCMD_LABEL: RscText
		{
			idc = IDC_TAG_U_ADMIN_SERVERCMD_LABEL;
			sizeEx = "0.020 / (getResolution select 5)";
			text = "SERVER COMMANDS";
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_SERVERCMD_LIST: TAG_UI_LISTBOX
		{
			idc = IDC_TAG_U_ADMIN_SERVERCMD_LIST;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class TAG_U_ADMIN_SERVERCMD_SET: RscButton
		{
			idc = IDC_TAG_U_ADMIN_SERVERCMD_SET;
			text = "EXECUTE";
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_BTN_CLOSE: RscButton
		{
			idc = IDC_TAG_U_ADMIN_BTN_CLOSE;
			text = "CLOSE";
			x = 0.644375 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;";
		};
		class TAG_U_ADMIN_UNITLIST_BANREASON: RscEdit
		{
			idc = IDC_TAG_U_ADMIN_UNITLIST_BANREASON;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.278437 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
		};
		class TAG_U_ADMIN_UNITLIST_BANREASON_LABEL: RscText
		{
			idc = IDC_TAG_U_ADMIN_UNITLIST_BANREASON_LABEL;
			sizeEx = "0.020 / (getResolution select 5)";
			text = "BAN REASON";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_ADMIN_DEBUGTITLE: RscText
		{
			idc = IDC_TAG_U_ADMIN_DEBUGTITLE;
			text = "DEBUG MODE";
			x = 0.55286 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0528598 * safezoneW;
			h = 0.0188029 * safezoneH;
		};
		class TAG_U_ADMIN_DEBUGERROR: RscButton
		{
			idc = IDC_TAG_U_ADMIN_DEBUGERROR;
			text = "ERROR";
			x = 0.55286 * safezoneW + safezoneX;
			y = 0.528204 * safezoneH + safezoneY;
			w = 0.0528598 * safezoneW;
			h = 0.0188029 * safezoneH;
		};
		class TAG_U_ADMIN_DEBUGDEBUG: RscButton
		{
			idc = IDC_TAG_U_ADMIN_DEBUGDEBUG;
			text = "DEBUG";
			x = 0.55286 * safezoneW + safezoneX;
			y = 0.556409 * safezoneH + safezoneY;
			w = 0.0528598 * safezoneW;
			h = 0.0188029 * safezoneH;
		};
		class TAG_U_ADMIN_DEBUGDEEP: RscButton
		{
			idc = IDC_TAG_U_ADMIN_DEBUGDEEP;
			text = "DEEPDEBUG";
			x = 0.55286 * safezoneW + safezoneX;
			y = 0.584613 * safezoneH + safezoneY;
			w = 0.0528598 * safezoneW;
			h = 0.0188029 * safezoneH;
		};
	};
};

/*
*	TAG NEWS
*/
class TAG_U_NEWS {
	idd = 9667; 
	duration = 1e+1000; 
	fadeIn = 1; 
	fadeOut = 1;
	onLoad = "uiNamespace setVariable ['TAG_U_NEWS_DISP', _this select 0];"; 
	   
	class Controls {
		class TAG_U_NEWS_BG: IGUIBack
		{
			idc = IDC_TAG_U_NEWS_BG;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		//class TAG_U_NEWS_MAIN: RscText
		//{
		//	idc = IDC_TAG_U_NEWS_MAIN;
		//	x = 0.304062 * safezoneW + safezoneX;
		//	y = 0.269 * safezoneH + safezoneY;
		//	w = 0.391875 * safezoneW;
		//	h = 0.451 * safezoneH;
		//};
		class TAG_U_NEWS_TITLE: RscText
		{
			idc = IDC_TAG_U_NEWS_TITLE;
			style = ST_CENTER;
			text = "";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_NEWS_BTN_CLOSE: RscButton
		{
			idc = IDC_TAG_U_NEWS_BTN_CLOSE;
			text = "OK";
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};

/*
*	TAG UNIFORM SELECT
*/
class TAG_U_UNIFORM {
	idd = 9668; 
	duration = 1e+1000; 
	fadeIn = 1; 
	fadeOut = 1;
	onLoad = "uiNamespace setVariable ['TAG_U_UNIFORM_DISP', _this select 0];"; 
	   
	class Controls {
		class TAG_U_UNIFORM_BG: IGUIBack
		{
			idc = IDC_TAG_U_UNIFORM_BG;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.506 * safezoneH;
		};
		class TAG_U_UNIFORM_LIST: RscListbox
		{
			idc = IDC_TAG_U_UNIFORM_LIST;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.374 * safezoneH;
		};
		class TAG_U_UNIFORM_PREVIEW: RscPicture
		{
			idc = IDC_TAG_U_UNIFORM_PREVIEW;
			text = "#(argb,8,8,3)color(1,1,1,0)";
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.256 * safezoneH;
		};
		class TAG_U_UNIFORM_TITLE: RscText
		{
			idc = IDC_TAG_U_UNIFORM_TITLE;
			style = ST_CENTER;
			text = "UNIFORM SELECTION";
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_UNIFORM_BTN_USE: RscButton
		{
			idc = IDC_TAG_U_UNIFORM_BTN_USE;
			text = "APPLY";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class TAG_U_UNIFORM_BTN_CLOSE: RscButton
		{
			idc = IDC_TAG_U_UNIFORM_BTN_CLOSE;
			text = "CLOSE";
			x = 0.644375 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};

// IGUI CLASSES (SIMULATION IS NOT STOPPED WHEN THESE ARE DISPLAYED)
class RscTitles {

	/*
	*	HUD
	*/
	class TAG_U_HUD {
		idd = -1; 
		duration = 1e+1000; 
		fadeIn = 1; 
		fadeOut = 1;
		onLoad = "uiNamespace setVariable ['TAG_U_HUD_DISP', _this select 0];"; 
		   
		class Controls {
			class TAG_U_HUD_L_BG: IGUIBack
			{
				idc = IDC_TAG_U_HUD_L_BG;
				x = -0.00216831 * safezoneW + safezoneX;
				y = 0.894862 * safezoneH + safezoneY;
				w = 0.10572 * safezoneW;
				h = 0.0752118 * safezoneH;
				colorBackground[] = {-1,-1,-1,0.5};
			};
			class TAG_U_HUD_L_IT: RscText
			{
				idc = IDC_TAG_U_HUD_L_IT;
				style = ST_RIGHT;
				text = "";
				x = 0.0348336 * safezoneW + safezoneX;
				y = 0.904263 * safezoneH + safezoneY;
				w = 0.0660748 * safezoneW;
				h = 0.0188029 * safezoneH;
				colorBackground[] = {-1,-1,-1,0};
			};
			class TAG_U_HUD_L_HP: RscText
			{
				idc = IDC_TAG_U_HUD_L_HP;
				style = ST_RIGHT;
				text = "";
				x = 0.0348336 * safezoneW + safezoneX;
				y = 0.923066 * safezoneH + safezoneY;
				w = 0.0660748 * safezoneW;
				h = 0.0188029 * safezoneH;
				colorBackground[] = {-1,-1,-1,0};
			};
			class TAG_U_HUD_L_UL: RscText
			{
				idc = IDC_TAG_U_HUD_L_UL;
				style = ST_RIGHT;
				text = "";
				x = 0.0348336 * safezoneW + safezoneX;
				y = 0.941869 * safezoneH + safezoneY;
				w = 0.0660748 * safezoneW;
				h = 0.0188029 * safezoneH;
				colorBackground[] = {-1,-1,-1,0};
			};
			class TAG_U_HUD_L_IMG: RscPicture
			{
				idc = IDC_TAG_U_HUD_L_IMG;
				text = "";
				x = 0.00223668 * safezoneW + safezoneX;
				y = 0.904263 * safezoneH + safezoneY;
				w = 0.0308349 * safezoneW;
				h = 0.0564088 * safezoneH;
				colorBackground[] = {-1,-1,-1,0};
			};
			class TAG_U_HUD_R_BG: IGUIBack
			{
				idc = IDC_TAG_U_HUD_R_BG;
				x = 0.896449 * safezoneW + safezoneX;
				y = 0.894862 * safezoneH + safezoneY;
				w = 0.10572 * safezoneW;
				h = 0.0752118 * safezoneH;
				colorBackground[] = {-1,-1,-1,0.5};
			};
			class TAG_U_HUD_R_AMMO: RscText
			{
				idc = IDC_TAG_U_HUD_R_AMMO;
				text = "";
				x = 0.898211 * safezoneW + safezoneX;
				y = 0.898622 * safezoneH + safezoneY;
				w = 0.0792897 * safezoneW;
				h = 0.0376059 * safezoneH;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.5)";
			};
			class TAG_U_HUD_R_MODE: RscText
			{
				idc = IDC_TAG_U_HUD_R_MODE;
				text = "";
				x = 0.898211 * safezoneW + safezoneX;
				y = 0.939989 * safezoneH + safezoneY;
				w = 0.0528598 * safezoneW;
				h = 0.00940147 * safezoneH;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1)";
			};
			class TAG_U_HUD_R_RANGE: RscText
			{
				idc = IDC_TAG_U_HUD_R_RANGE;
				text = "";
				x = 0.898211 * safezoneW + safezoneX;
				y = 0.953151 * safezoneH + safezoneY;
				w = 0.0528598 * safezoneW;
				h = 0.00940147 * safezoneH;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1)";
			};
		};
	};

	/*
	*	CAMERA INFO
	*/
	class TAG_U_CAMINFO {
		idd = -1; 
		duration = 1e+1000; 
		fadeIn = 2; 
		fadeOut = 2;
		onLoad = "uiNamespace setVariable ['TAG_U_CAMINFO_DISP', _this select 0];"; 
		   
		class Controls {
			class TAG_U_CAMINFO_TEXT: RscStructuredText
			{
				idc = IDC_TAG_U_CAMINFO_TEXT;
				style = ST_LEFT + ST_MULTI;
				x = -0.000156274 * safezoneW + safezoneX;
				y = 0.478 * safezoneH + safezoneY;
				w = 0.113437 * safezoneW;
				h = 0.286 * safezoneH;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1)";
				colorBackground[] = {-1,-1,-1,0.2};
			};
		};
	};

	/*
	*	MESSAGES
	*/
	class TAG_U_MESS {
		idd = -1; 
		duration = 1e+1000; 
		fadeIn = 2; 
		fadeOut = 2;
		onLoad = "uiNamespace setVariable ['TAG_U_MESS_DISP', _this select 0];"; 
		   
		class Controls {
			class TAG_U_MESS_TOP: RscStructuredText
			{
				idc = IDC_TAG_U_MESS_TOP;
				text = "Match is about to begin";
				x = 0.323801 * safezoneW + safezoneX;
				y = 0.217956 * safezoneH + safezoneY;
				w = 0.352399 * safezoneW;
				h = 0.0470074 * safezoneH;
				colorBackground[] = {0,0,0,0.2};
			};
		};
	};

	/*
	*	KILLFEED
	*/
	class TAG_U_KILLFEED {
		idd = -1; 
		duration = 2; 
		fadeIn = 1; 
		fadeOut = 1;
		onLoad = "uiNamespace setVariable ['TAG_U_KILLFEED_DISP', _this select 0];"; 
		   
		class Controls {
			class TAG_U_KILLFEED_ABOVE: RscStructuredText
			{
				idc = IDC_TAG_U_KILLFEED_ABOVE;
				text = "ABOVE"; //--- ToDo: Localize;
				x = 0.37666 * safezoneW + safezoneX;
				y = 0.688029 * safezoneH + safezoneY;
				w = 0.246679 * safezoneW;
				h = 0.0282044 * safezoneH;
			};
			class TAG_U_KILLFEED_MAIN: RscStructuredText
			{
				idc = IDC_TAG_U_KILLFEED_MAIN;
				text = "MAIN"; //--- ToDo: Localize;
				x = 0.37666 * safezoneW + safezoneX;
				y = 0.716234 * safezoneH + safezoneY;
				w = 0.246679 * safezoneW;
				h = 0.0282044 * safezoneH;
			};
			class TAG_U_KILLFEED_UNDER: RscStructuredText
			{
				idc = IDC_TAG_U_KILLFEED_UNDER;
				text = "UNDER"; //--- ToDo: Localize;
				x = 0.37666 * safezoneW + safezoneX;
				y = 0.744438 * safezoneH + safezoneY;
				w = 0.246679 * safezoneW;
				h = 0.0282044 * safezoneH;
			};
		};
	};


	/*
	*	SCOREBOARD
	*/
	class TAG_U_SCOREBOARD {
		idd = -1; 
		duration = 1e+1000; 
		fadeIn = 0; 
		fadeOut = 0;
		onLoad = "uiNamespace setVariable ['TAG_U_SCOREBOARD_DISP', _this select 0];"; 
		   
		class Controls {
			class TAG_U_SCORE_TOP_BG: IGUIBack
			{
				idc = IDC_TAG_U_SCORE_TOP_BG;
				x = 0.182841 * safezoneW + safezoneX;
				y = 0.161547 * safezoneH + safezoneY;
				w = 0.638723 * safezoneW;
				h = 0.0188029 * safezoneH;
				colorBackground[] = {-1,-1,-1,0.5};
			};
			class TAG_U_SCORE_BOTTOM_BG: IGUIBack
			{
				idc = IDC_TAG_U_SCORE_BOTTOM_BG;
				x = 0.182841 * safezoneW + safezoneX;
				y = 0.669227 * safezoneH + safezoneY;
				w = 0.638723 * safezoneW;
				h = 0.0564088 * safezoneH;
				colorBackground[] = {-1,-1,-1,0.5};
			};
			class TAG_U_SCORE_LOGO: RscPicture
			{
				idc = IDC_TAG_U_SCORE_LOGO;
				text = "\tag_client\ui\images\tag_logo_alpha.paa";
				x = 0.182841 * safezoneW + safezoneX;
				y = 0.669227 * safezoneH + safezoneY;
				w = 0.0352399 * safezoneW;
				h = 0.0564088 * safezoneH;
			};
			class TAG_U_SCORE_LIST: RscListbox
			{
				idc = IDC_TAG_U_SCORE_LIST;
				x = 0.182841 * safezoneW + safezoneX;
				y = 0.180349 * safezoneH + safezoneY;
				w = 0.638723 * safezoneW;
				h = 0.488877 * safezoneH;
				colorBackground[] = {-1,-1,-1,0.2};
			};
			class TAG_U_SCORE_COL1: RscText
			{
				idc = IDC_TAG_U_SCORE_COL1;
				text = "PLAYERNAME";
				x = 0.266536 * safezoneW + safezoneX;
				y = 0.161547 * safezoneH + safezoneY;
				w = 0.0836947 * safezoneW;
				h = 0.0188029 * safezoneH;
			};
			class TAG_U_SCORE_TITLE: RscStructuredText
			{
				idc = IDC_TAG_U_SCORE_TITLE;
				text = "SCOREBOARD";
				x = 0.182841 * safezoneW + safezoneX;
				y = 0.133343 * safezoneH + safezoneY;
				w = 0.638723 * safezoneW;
				h = 0.0282044 * safezoneH;
				colorBackground[] = {0,0,0,1};
			};
			class TAG_U_SCORE_COL2: RscText
			{
				idc = IDC_TAG_U_SCORE_COL2;
				text = "KILLS";
				x = 0.45595 * safezoneW + safezoneX;
				y = 0.161547 * safezoneH + safezoneY;
				w = 0.0836947 * safezoneW;
				h = 0.0188029 * safezoneH;
			};
			class TAG_U_SCORE_COL3: RscText
			{
				idc = IDC_TAG_U_SCORE_COL3;
				text = "SCORE";
				x = 0.649769 * safezoneW + safezoneX;
				y = 0.161547 * safezoneH + safezoneY;
				w = 0.0836947 * safezoneW;
				h = 0.0188029 * safezoneH;
			};
		};
	};
};