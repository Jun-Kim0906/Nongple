import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/weather/weather.dart';
import 'package:http/http.dart' as http;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => InitializeWeatherState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeather) {
       yield* _mapGetWeatherToState();
    }
  }

  Stream<WeatherState> _mapGetWeatherToState() async* {
    List<Weather> skyList = [];
    List<Weather> tmpList = [];
    List<Weather> humidList = [];

    http.Response weatherInfo;

    weatherInfo = await http.get('http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?serviceKey=i4IEpXIP0gP8v4Kvwnz%2FwRwVVcDse7fMVVsqDhG0DeEjXXM7TtD2qHHgeMz%2BMeq6WV0EJ4gLNnLJugGw%2BPBYnw%3D%3D&pageNo=1&numOfRows=999&dataType=JSON&base_date=20200721&base_time=0500&nx=1&ny=1&');
    if (weatherInfo.statusCode == 200) {
      json
          .decode(weatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
            if(data['category'] == "REH") {
              humidList.add(Weather.fromJSON(data));
            } else if(data['category'] == "SKY") {
              skyList.add(Weather.fromJSON(data));
            } else if (data['category'] == "T3H") {
              tmpList.add(Weather.fromJSON(data));
            } else {
              ;
            }
      });
    } else {
      throw Exception('Failed to load weather');
    }
    yield WeatherListSet(skyList, tmpList, humidList);
  }
}
