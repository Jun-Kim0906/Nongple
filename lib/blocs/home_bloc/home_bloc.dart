import 'dart:convert';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/models/weather/weather.dart';
import 'package:nongple/utils/todays_date.dart';
import 'package:nongple/utils/weather_util/api_addr.dart';
import 'package:nongple/utils/weather_util/convert_grid_gps.dart';
import 'home.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:nongple/utils/utils.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => Initial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetFacilityList) {
      yield* _mapGetFacilityListToState();
    } else if(event is ListLoading){
      yield* _mapListLoadingToState();
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

    await Future.wait(facList.map((doc) => getTemperature(fid: doc.fid, lat: doc.lat, lng: doc.lng)));

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

  Future<String> getTemperature({String fid, String lng, String lat}) async {
    List<Weather> skyList_short = [];
    List<Weather> tmpList_short = [];
    List<Weather> humidList_short = [];

    String nx = lat;
    String ny = lng;
    print('nx : $nx, ny : $ny');

    double la = double.parse(lat);
    double lo = double.parse(lng);
    print('la : $la, lo : $lo');

    LatXLngY point = convertGridGPS(0, la, lo);
    int gridX = point.x;
    int gridY = point.y;
    print('gridX : $gridX, gridY : $gridY');

    String bt_short;
    String bb_short;

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

    http.Response shortWeatherInfo;

    shortWeatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$bb_short&base_time=$bt_short&nx=$gridX&ny=$gridY&');


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

  Stream<HomeState> _mapListLoadingToState() async*{
    yield Loading();
  }
}
