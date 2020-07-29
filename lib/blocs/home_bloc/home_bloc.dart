import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/models/weather/weather.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/data_repository/data_repository.dart';
import 'package:nongple/utils/todays_date.dart';
import 'package:nongple/utils/weather_util/api_addr.dart';
import 'home.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:nongple/utils/utils.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => Initial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetFacilityList) {
      yield* _mapGetFacilityListToState();
    }
  }

  Stream<HomeState> _mapGetFacilityListToState() async* {
    List<Facility> facList = [];
//    List<Facility> facList2 = [];

    QuerySnapshot qs = await Firestore.instance
        .collection('Facility')
        .where('uid', isEqualTo: UserUtil.getUser().uid)
        .getDocuments();
    qs.documents.forEach((ds) {
      facList.add(Facility.fromSnapshot(ds));
    });

//    facList.forEach((list) async {
//     await getTemperature(list.fid, list.lng, list.lat);
//    });

    await Future.wait(facList.map((doc) => getTemperature(doc.fid, doc.lat, doc.lng)));

//    await Future.forEach(facList, (list) {
//      getTemperature(list.fid, list.lng, list.lat);
//    });


    facList.clear();

    qs = await Firestore.instance
        .collection('Facility')
        .where('uid', isEqualTo: UserUtil.getUser().uid)
        .getDocuments();
    qs.documents.forEach((ds) {
      facList.add(Facility.fromSnapshot(ds));
    });

    facList.forEach((list) {
      print('[homeBloc] ${list.name} get temperature : ${list.temperature} }');
      print('[homeBloc] ${list.name} get bgUrl : ${list.bgUrl} }');
    });


    yield FacilityListSet(facList);
  }

  Future<String> getTemperature(String fid, String lng, String lat) async {
    List<Weather> skyList_short = [];
    List<Weather> tmpList_short = [];
    List<Weather> humidList_short = [];

    String nx = lat;
    String ny = lng;
    print('nx : $nx, ny : $ny');

    String bt_short;
    String bb_short;

//    print('base date: ' + base_date);
//    print('hour: $hour, minute: $minute');
//    DateTime testDateTimeNow = DateTime.parse("20200723T093000");
//    String btTest = DateFormat('HHmm').format(testDateTimeNow);
//    print('btTest: ' + btTest);

    /// short fcst info
    if (int.parse(minute) > 30) {
      bt_short = hour + '30';
      bb_short = base_date;
    } else if (int.parse(minute) == 30) {
      bt_short = hour + '00';
      bb_short = base_date;
    } else if (int.parse(minute) < 30) {
      int tempHour = int.parse(hour) - 1;
      if (tempHour < 0) {
        bt_short = '2330';
        int tempDay = int.parse(day) - 1;
        bb_short = year + month + tempDay.toString();
      } else {
        (tempHour.toString().length < 2)
            ? bt_short = '0' + tempHour.toString() + '30'
            : bt_short = tempHour.toString() + '30';
        bb_short = base_date;
      }
    } else {
      throw Exception('[if-else] Failed to load short fcst weather');
    }
//    print('bt_short : ' + bt_short);

    http.Response shortWeatherInfo;

    shortWeatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$bb_short&base_time=$bt_short&nx=$nx&ny=$ny&');

//    print('$ultraSrtFcstHeader&base_date=$bb_short&base_time=$bt_short&nx=$nx&ny=$ny&');

    if (shortWeatherInfo.statusCode == 200) {
      json
          .decode(shortWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "REH") {
          humidList_short.add(Weather.fromJson(data));
        } else if (data['category'] == "SKY") {
          skyList_short.add(Weather.fromJson(data));
        } else if (data['category'] == "T1H") {
          tmpList_short.add(Weather.fromJson(data));
        } else {
          ;
        }
      });
    } else {
      throw Exception('[category] Failed to load short fcst weather');
    }

    await Firestore.instance.collection('Facility').document(fid).updateData({
      'temperature' : tmpList_short[0].fcstValue,
    });

    return tmpList_short[0].fcstValue;
  }
}
