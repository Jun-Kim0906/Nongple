import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/weather/weather.dart';
import 'package:http/http.dart' as http;
import 'package:nongple/utils/todays_date.dart';
import 'package:nongple/utils/weather_util/api_addr.dart';

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

    List<Weather> skyList_short = [];
    List<Weather> tmpList_short = [];
    List<Weather> humidList_short = [];

    String bt;
    String bt_short;

    /// short fcst info
    if (int.parse(minute) > 30) {
      bt_short = hour + '30';
    } else if (int.parse(minute) == 30) {
      bt_short = hour + '00';
    } else if (int.parse(minute) < 30) {
      int tempHour = int.parse(hour) - 1;
      bt_short = tempHour.toString() + '30';
    } else {
      print('bt_short problem : ' + bt_short);
    }
    print('bt_short : ' + bt_short);

    http.Response shortWeatherInfo;

    shortWeatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$base_date&base_time=$bt_short&nx=1&ny=1&');

    if (shortWeatherInfo.statusCode == 200) {
      json
          .decode(shortWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "REH") {
          humidList_short.add(Weather.fromJSON(data));
        } else if (data['category'] == "SKY") {
          skyList_short.add(Weather.fromJSON(data));
        } else if (data['category'] == "T1H") {
          tmpList_short.add(Weather.fromJSON(data));
        } else {
          ;
        }
      });
    } else {
      throw Exception('Failed to load short fcst weather');
    }

    /// village weather info
    villageFcstBT.forEach((element) {
      if (int.parse(hour) > int.parse(element)) {
        bt = element + '00';
        print('bt : ' + bt);
      } else if (int.parse(hour) < int.parse(element)) {
        ;
      } else if (int.parse(element) < 02) {
        bt = '2300';
      } else {
        ;
      }
    });

    http.Response villageWeatherInfo;

    villageWeatherInfo = await http.get(
        '$villageFcstHeader&base_date=$base_date&base_time=$bt&nx=1&ny=1&');

    if (villageWeatherInfo.statusCode == 200) {
      json
          .decode(villageWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "REH") {
          humidList.add(Weather.fromJSON(data));
        } else if (data['category'] == "SKY") {
          skyList.add(Weather.fromJSON(data));
        } else if (data['category'] == "T3H") {
          tmpList.add(Weather.fromJSON(data));
        } else {
          ;
        }
      });
    } else {
      throw Exception('Failed to load village weather');
    }
    yield WeatherListSet(skyList, tmpList, humidList, skyList_short,
        tmpList_short, humidList_short);
  }
}
