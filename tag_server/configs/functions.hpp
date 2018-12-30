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
			file="tag_server\functions";
			class aSync;
		};

		class Utilities {
			file="tag_server\functions";
			class generateRoundId;
			class lootSystem;
			class supplyDrop;
		};

		class Eventhandlers {
			file="tag_server\eh";
			class onCheckVersion;
			class onPlayerConnected;
			class onSetBanned;
			class onAddScore;
		};
	};
};