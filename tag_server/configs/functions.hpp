class CfgFunctions {
	class tiis {
		class Server {
			class version { file="tag_server\version.sqf"; preInit=1; };
		};

		class Init_Server {
			file="tag_server\init";
			class initServer { preInit=1; };
		};

		class Database {
			file="tag_server\functions\db";
			class aSync;
			class distributeHits;
			class strip;
		};

		class Utilities {
			file="tag_server\functions\util";
			class generateRoundId;
			class lootSystem;
			class supplyDrop;
			class getObjectId;
			class messageSystem;
			class getLootPos;
		};

		class Eventhandlers {
			file="tag_server\eh";
			class onCheckVersion;
			class onPlayerConnected;
			class onSetBanned;
			class onAddScore;
			class onHandleDisconnect;
		};
	};
};