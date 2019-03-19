/*
*	@Name: onHandleDisconnect
*
*	@Description:
*		Triggered when player disconnects from the game.
*		Similar to onPlayerDisconnected event but can be stacked and contains the unit occupied by player before disconnect.
*		Must be added on the server and triggers only on the server.
*
*	@Notes
*		Override: If this EH code returns true, the unit, previously occupied by player,
*		gets transferred to the server, becomes AI and continues to live,
*		even with description.ext param disabledAI = 1;
*
*	@Parameters:
*		_unit: Object - unit formerly occupied by player
*		_id: Number - is the unique DirectPlay ID. Quite useless as the number is too big for in-built string representation and gets rounded. It is also the same id used for user placed markers.
*		_uid: String - is getPlayerUID of the leaving player. In Arma 3 it is also the same as Steam ID.
*		_name: String - is profileName of the leaving player.
*
*/

params ["_unit", "_id", "_uid", "_name"];

if (tag_gameInProgress) then {

	// Player disconnected
	_unit setVariable ["tag_unitDisconnected", 1, true];

	[">>>> EH TRIGGERED: onHandleDisconnect <<<<","DEEPDEBUG"] call tiig_fnc_log;
	[["_unit: %1 | _id: %2 | _uid: %3 | _name: %4 | _roundId: %5", _unit, _id, _uid, _name, tag_roundID],"DEEPDEBUG"] call tiig_fnc_log;
};