/* ///////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: version.hpp
*	@Location: {@mod\addons}\tag_server\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Contains version information {Server-side}
*
*/ ///////////////////////////////////////////////////////////////////////////////////////

tag_serverVersion       = 101;     // 0.0.0 (FULL.BETA.ALPHA) [Alpha 2] = 0.0.2 [BETA 2] = 0.2.0
tag_serverVersionString = "1.0.1"; // Version in string format
tag_serverRevision      = "a";     // Revision letter
tag_serverBuildName	    = format["%1%2.stable", tag_serverVersionString, tag_serverRevision]; // Buildname