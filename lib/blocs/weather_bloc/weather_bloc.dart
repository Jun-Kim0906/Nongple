import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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
      yield* _mapGetWeatherToState(event);
    }
  }

  Stream<WeatherState> _mapGetWeatherToState(GetWeather event) async* {
    print('//////////////////////////////// Weather API Start ///////////////////////////////////////');
    List<Weather> skyList = [];
    List<Weather> tmpList = [];
    List<Weather> humidList = [];

    List<Weather> skyList_short = [];
    List<Weather> tmpList_short = [];
    List<Weather> humidList_short = [];

    String nx = event.nx;
    String ny = event.ny;
    print('nx : $nx, ny : $ny');

    String bt;
    String bt_short;

    print('base date: ' + base_date);
    print('hour: $hour, minute: $minute');
//    DateTime testDateTimeNow = DateTime.parse("20200723T093000");
//    String btTest = DateFormat('HHmm').format(testDateTimeNow);
//    print('btTest: ' + btTest);

    /// short fcst info
    if (int.parse(minute) > 30) {
      bt_short = hour + '30';
    } else if (int.parse(minute) == 30) {
      bt_short = hour + '00';
    } else if (int.parse(minute) < 30) {
      int tempHour = int.parse(hour) - 1;
      (tempHour.toString().length < 2)
          ? bt_short = '0' + tempHour.toString() + '30'
          : bt_short = tempHour.toString() + '30';
    } else {
      throw Exception('[if-else] Failed to load short fcst weather');
    }
    print('bt_short : ' + bt_short);

    http.Response shortWeatherInfo;

    shortWeatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$base_date&base_time=$bt_short&nx=$nx&ny=$ny&');

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
      throw Exception('[category] Failed to load short fcst weather');
    }

    String startingTemp = tmpList_short[0].fcstValue;
    String startingTime = tmpList_short[0].fcstTime;

    print(
        'Starting item of short fcst list { starting temperature : $startingTemp, starting time : $startingTime');

    /// village weather info
    /// base_time : 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300
    villageFcstBT.forEach((element) {
      if (int.parse(hour) >= int.parse(element)) {
        bt = element + '00';
      } else if (int.parse(hour) < int.parse(element)) {
        ;
      } else if (int.parse(element) < 02) {
        bt = '2300';
      } else {
        throw Exception('[if-else] Failed to load village weather');
      }
    });

    print('bt : ' + bt);

    http.Response villageWeatherInfo;

    villageWeatherInfo = await http.get(
        '$villageFcstHeader&base_date=$base_date&base_time=$bt&nx=$nx&ny=$ny&');

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
      throw Exception('[category] Failed to load village weather');
    }

    print('////////////////////// Finished Getting Weather API ///////////////////////////////////');

    /// update firebase with new temperature
    await Firestore.instance.collection('Facility').document(event.fid).updateData({
      'temperature' : tmpList_short[0].fcstValue,
    });

    yield WeatherListSet(skyList, tmpList, humidList, skyList_short,
        tmpList_short, humidList_short);
  }
}
