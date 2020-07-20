import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String baseDate;
  String baseTime;
  String category;
  String fcstDate;
  String fcstTime;
  String fcstValue;
  int nx;
  int ny;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        child: Column(
          children: [
            Text('baseDate' + baseDate)
          ],
        ),
      ),
    );
  }
}
