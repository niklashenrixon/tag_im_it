/*
Author: code34 nicolas_boiteux@yahoo.fr
Copyright (C) 2013 Nicolas BOITEUX

Real weather for MP GAMES v 1.3 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>. 
*/

private ["_lastrain", "_rain", "_fog", "_mintime", "_maxtime", "_overcast", "_realtime", "_random","_startingdate", "_startingweather", "_timeforecast", "_timeratio", "_timesync", "_wind"];

// Real time vs fast time
// true: Real time is more realistic weather conditions change slowly (ideal for persistent game)
// false: fast time give more different weather conditions (ideal for non persistent game) 
_realtime = false;

// Random time before new forecast
// true: forecast happens bewteen mintime and maxtime
// false: forecast happens at mintime
_random = true;

// Min time seconds (real time) before a new weather forecast
_mintime = 150;

// Max time seconds (real time) before a new weather forecast
_maxtime = 300;

// If Fastime is on
// Ratio 1 real time second for x game time seconds
// Default: 1 real second = 10 second in game
_timeratio = 0.1;

// send sync data across the network each xxx seconds
// 60 real seconds by default is a good value
// shortest time do not improve weather sync
_timesync = 30;

/*
*	Modified by Nixon (TAG I'M IT)

_initdate = date;
while {true} do {
	setdate _initdate;
	sleep 1;
};

*/

_startingdate = [1988, 3, 9, 12, round random 59];
_startingweather = selectRandom ["CLEAR","CLOUDY","RAIN"];

[["WEATHER: Date and time: %1 | Initial condition: %2", _startingdate, _startingweather], "DEBUG"] call tiig_fnc_log;

/////////////////////////////////////////////////////////////////
// Do not edit below
/////////////////////////////////////////////////////////////////

if(_mintime > _maxtime) exitwith {hint format["Real weather: Max time: %1 can no be higher than Min time: %2", _maxtime, _mintime];};
_timeforecast = _mintime;

setdate _startingdate;
switch(toUpper(_startingweather)) do {
	case "CLEAR": {
		wcweather = [0, 0, 0, [random 3, random 3, true], date];
	};
	
	case "CLOUDY": {
		wcweather = [0, 0, 0.6, [random 3, random 3, true], date];
	};
	
	case "RAIN": {
		wcweather = [1, 0, 1, [random 3, random 3, true], date];
	};

	default {
		// clear
		wcweather = [0, 0, 0, [random 3, random 3, true], date];
		diag_log "Real weather: wrong starting weather";
	};
};

// Add handler
if (local player) then {
	wcweatherstart = true;
	"wcweather" addPublicVariableEventHandler {
		// first JIP synchronization
		if(wcweatherstart) then {
			wcweatherstart = false;
			skipTime -24;
			86400 setRain (wcweather # 0);
			86400 setOvercast (wcweather # 2);
			skipTime 24;
			simulweatherSync;
			setwind (wcweather # 3);
			setdate (wcweather # 4);
		} else {
			wcweather = _this # 1;
			60 setRain (wcweather # 0);
			60 setOvercast (wcweather # 2);
			setwind (wcweather # 3);
			setdate (wcweather # 4);
		};
	};
};

// SERVER SIDE SCRIPT
if (!isServer) exitWith{};

if(!_realtime) then { setTimeMultiplier _timeratio; };

// apply weather
skipTime -24;
86400 setRain (wcweather # 0);
86400 setOvercast (wcweather # 2);
skipTime 24;
simulweatherSync;
setwind (wcweather # 3);
setdate (wcweather # 4);

// sync server & client weather & time
[_timesync, _startingdate] spawn {
	private["_timesync","_startingdate"];
	_timesync = _this # 0;
	_startingdate = _this # 1;

	while { true } do {
		wcweather set [4, _startingdate];
		publicvariable "wcweather";
		sleep _timesync;
	};
};

_lastrain = 0;
_rain = 0;
_overcast = 0;

while {true} do {
	_overcast = random 1;
	if(_overcast > 0.68) then {
		_rain = random 6;
	} else {
		_rain = 0;
	};
	if((date # 3 > 2) and (date # 3 <6)) then {
		_fog = 0.3 + (random 0.2);
	} else {
		if((_lastrain > 0.6) and (_rain < 0.2)) then {
			_fog = random 0.2;
		} else {
			_fog = 0;
		};
	};
	if(random 1 > 0.95) then {
		_wind = [random 7, random 7, true];
	} else {
		_wind = [random 3, random 3, true];
	};
	_lastrain = _rain;

	wcweather = [_rain, _fog, _overcast, _wind, _startingdate];
	60 setRain (wcweather # 0);
	60 setOvercast (wcweather # 2);
	setwind (wcweather # 3);
	if(_random) then {
		_timeforecast = _mintime + (random (_maxtime - _mintime));
	};
	sleep _timeforecast;
};

["real_weather.sqf loaded", "DEEPDEBUG"] call tiig_fnc_log;