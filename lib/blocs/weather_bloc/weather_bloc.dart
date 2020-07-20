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
    List<Weather> weatherList = [];
    String headUrl = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst?';
    String serviceKey =
        'serviceKey=i4IEpXIP0gP8v4Kvwnz%2FwRwVVcDse7fMVVsqDhG0DeEjXXM7TtD2qHHgeMz%2BMeq6WV0EJ4gLNnLJugGw%2BPBYnw%3D%3D';
    String pageNo = '1';
    String numOfRows = '10';
    String dataType = 'JSON';
    String base_date = '20200720';
    String base_time = '0630';
    String nx = '55';
    String ny = '127';
    String head = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst?$serviceKey&pageNo=1&numOfRows=10&dataType=JSON';
    String testUrl = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst?serviceKey=i4IEpXIP0gP8v4Kvwnz%2FwRwVVcDse7fMVVsqDhG0DeEjXXM7TtD2qHHgeMz%2BMeq6WV0EJ4gLNnLJugGw%2BPBYnw%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&base_date=20200720&base_time=0630&nx=55&ny=127&';
    http.Response weatherInfo;
    print('testing URL : $head&base_date=$base_date&base_time=$base_time&nx=$nx&ny=$ny&');
    weatherInfo = await http.get('$head&base_date=$base_date&base_time=$base_time&nx=$nx&ny=$ny&');
//    weatherInfo = await http.get('$testUrl');
//    weatherInfo = await http.get('http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst?serviceKey=i4IEpXIP0gP8v4Kvwnz%2FwRwVVcDse7fMVVsqDhG0DeEjXXM7TtD2qHHgeMz%2BMeq6WV0EJ4gLNnLJugGw%2BPBYnw%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&base_date=20200720&base_time=0630&nx=55&ny=127&');
    if (weatherInfo.statusCode == 200) {
      json
          .decode(weatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        weatherList.add(Weather.fromJSON(data));
      });
    } else {
      throw Exception('Failed to load weather');
    }
    print(weatherList);
    yield WeatherListSet(weatherList);
  }
}
