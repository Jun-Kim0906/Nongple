

import 'package:nongple/models/weather/weather.dart';

class WeatherState {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class InitializeWeatherState extends WeatherState{}

class WeatherListSet extends WeatherState{
  final List<Weather> skyList;
  final List<Weather> tmpList;
  final List<Weather> humidList;

  const WeatherListSet(this.skyList, this.tmpList, this.humidList);

  List<Object> get props => [skyList, tmpList, humidList];

  @override
  String toString()=>'FacilityListSet { skyList : $skyList, tmpList : $tmpList, humidList : $humidList }';
}


