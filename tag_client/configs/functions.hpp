class CfgFunctions {
	class tiig {
		class Client {
			class variables { file="tag_client\data\globalVars.sqf"; preInit=1; };
		};

		class Util {
			file="tag_client\functions\util";
			class log { preInit=1; };
			class dynWeather;
			class mapMarkers;
			class mapTextures;
			class rand2d;
			class emptyCargo;
			class addToCargo;
			class messanger;
		};

		class Misc {
			file="tag_client\functions\misc";
			class vaulting;
			class moveToMarker;
			class deathCircle;
			class animations;
			class randomArray;
			class shotMarker;
			class itHelmet;
			class selectRandom;
			class waitForRound;
			class loadUniform;
			class playGround;
			class soundDanger;
			class removeWeapons;
		};

		class Init_Global {
			file="tag_client\init\global";
			class initGlobal { postInit=1; };
		};
	};

	class tiic {

		class General {
			class version {	file="tag_client\version.sqf"; preInit=1; };
		};

		class Init_Client {
			file="tag_client\init\client";
			class initClient { postInit=1; };
		};

		class Camera {
			file="tag_client\functions\camera";
			class cameraSystem;
		};

		class UI {
			file="tag_client\functions\ui";
			class showHud;
			class showAdmin;
			class changeUniform;
			class escMenu { postInit=1; };
			class showWelcome;
			class showScore;
			class showCamInfo;
			class showKillfeed;
		};

		class Anticamp {
			file="tag_client\functions\anticamp";
			class antiCamp;
		};

		class Eventhandlers {
			file="tag_client\eh";
			class onPreloadFinished;
			class onEjectVehicle;
			class onDisconnected;
			class onHandleDamage;
			class onHandleHeal;
			class onConnected;
			class onRespawn;
			class onKilled;
			class onEnded;
			class onFired;
			class onHit;
		};
	};
};