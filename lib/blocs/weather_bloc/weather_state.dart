

import 'package:nongple/models/weather/weather.dart';

class WeatherState {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class InitializeWeatherState extends WeatherState{}

class WeatherListSet extends WeatherState{
  final List<Weather> weatherList;

  const WeatherListSet(this.weatherList);

  List<Object> get props => [weatherList];

  @override
  String toString()=>'FacilityListSet { facList : $weatherList }';
}


