/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////
*	 ______   ______     ______        __     __    __        __     ______  
*	/\__  _\ /\  __ \   /\  ___\      /\ \   /\ "-./  \      /\ \   /\__  _\ 
*	\/_/\ \/ \ \  __ \  \ \ \__ \     \ \ \  \ \ \-./\ \     \ \ \  \/_/\ \/ 
*	   \ \_\  \ \_\ \_\  \ \_____\     \ \_\  \ \_\ \ \_\     \ \_\    \ \_\ 
*	    \/_/   \/_/\/_/   \/_____/      \/_/   \/_/  \/_/      \/_/     \/_/ 
*
*	@Filename: version.hpp
*	@Location: {@mod\addons}\tag_client\
*	@Author: Nixon {nixon@visualized.se}
*
*	Description:
*		Contains version information {Client-side}
*
*/ ///////////////////////////////////////////////////////////////////////////////////////////////////////////

tag_clientVersion	    = 101;           // 0.0.0 (FINAL.BETA.ALPHA) | [Alpha v2] = 0.0.2 | [BETA v2] = 0.2.0
tag_clientVersionString = "1.0.1";       // Version in string format
tag_clientRevision	    = "a";           // Revision letter
tag_clientBranch	    = "Stable"; // Branch
tag_clientBuildName	    = format["%1%2.stable", tag_clientVersionString, tag_clientRevision]; // Buildname