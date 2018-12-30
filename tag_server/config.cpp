class CfgPatches {
    class tag_server {
        author = "NIXON";
        name = "Server";
        units[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {"tag_client"};
        version = 1.0;
        authors[] = {"NIXON"};
    };
};

#include "\tag_client\configs\commands.hpp"
#include "\tag_server\configs\functions.hpp"