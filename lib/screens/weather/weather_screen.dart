
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';
import 'package:nongple/widgets/loading/Loading.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherBloc _weatherBloc;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherListSet) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$year년 $month월 $day일',
                  style: TextStyle(fontSize: 20.0),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                        child: Icon(
                          CustomIcons.sun,
                          size: 100,
                          color: Colors.yellow[700],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '현재기온',
                                  style: TextStyle(color: Colors.blue[600]),
                                ),
                                Text(
                                  '25' + degrees + 'C',
                                  style: TextStyle(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '습도',
                                  style: TextStyle(color: Colors.blue[600]),
                                ),
                                Text(
                                  '90%',
                                  style: TextStyle(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tmpList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String fcstTime = state.tmpList[index].fcstTime;
                      return ListTile(
                        leading: Text(fcstTime[0] + fcstTime[1] + '시'),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (int.parse(state.skyList[index].fcstValue) <= 5)
                                ? Icon(CustomIcons.sun, color: Colors.yellow[700],)
                                : (int.parse(state.skyList[index].fcstValue) >
                                            5 &&
                                        int.parse(
                                                state.skyList[index].fcstValue) <
                                            9)
                                    ? Icon(CustomIcons.cloud, color: Colors.grey[400],)
                                    : Icon(CustomIcons.rain, color: Colors.blue[600],),
                            SizedBox(width: width * 0.008,),
                            Text(state.tmpList[index].fcstValue + degrees + 'C'),
                          ],
                        ),
                        trailing: Container(
                          width: width * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(state.humidList[index].fcstValue + '%'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Loading(),
          );
//          return Container(
//            child: Center(
//              child: Text("Weather Info Not Available", style: TextStyle(fontSize: 25),),
//            ),
//          );
        }
      },
    );
  }
}
