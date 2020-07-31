import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:nongple/models/models.dart';

class WeatherScreen extends StatefulWidget {
  final Facility facility;
  const WeatherScreen({@required this.facility});
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherBloc _weatherBloc;
  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _weatherBloc.add(WeatherLoading());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _weatherBloc,
      listener: (BuildContext context, WeatherState state){
        if(state is WLoading){
        _weatherBloc.add(GetWeather(
        fid: widget.facility.fid,
        nx: widget.facility.lat,
        ny: widget.facility.lng));
          LoadingDialog.onLoading(context);
        }else{
          LoadingDialog.dismiss(context, ()=>null);
        }
      },
      child: BlocBuilder<WeatherBloc, WeatherState>(
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
                          child: (int.parse(state.skyList_short[0].fcstValue) <=
                                  1)
                              ? Icon(
                                  CustomIcons.sun,
                                  size: 100,
                                  color: Colors.yellow[700],
                                )
                              : (int.parse(state.skyList_short[0].fcstValue) >
                                          1 &&
                                      int.parse(
                                              state.skyList_short[0].fcstValue) <
                                          4)
                                  ? Icon(
                                      CustomIcons.cloud,
                                      size: 100,
                                      color: Colors.grey[400],
                                    )
                                  : Icon(
                                      CustomIcons.rain,
                                      size: 100,
                                      color: Colors.blue[600],
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
                                    state.tmpList_short[0].fcstValue +
                                        degrees +
                                        'C',
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
                                    state.humidList_short[0].fcstValue + '%',
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
//                    itemCount: state.tmpList.length,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        String fcstTime = state.tmpList[index].fcstTime;
                        return ListTile(
                          leading: Text(fcstTime[0] + fcstTime[1] + '시'),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              (int.parse(state.skyList[index].fcstValue) <= 1)
                                  ? Icon(
                                      CustomIcons.sun,
                                      color: Colors.yellow[700],
                                    )
                                  : (int.parse(state.skyList[index].fcstValue) >
                                              1 &&
                                          int.parse(state
                                                  .skyList[index].fcstValue) <
                                              4)
                                      ? Icon(
                                          CustomIcons.cloud,
                                          color: Colors.grey[400],
                                        )
                                      : Icon(
                                          CustomIcons.rain,
                                          color: Colors.blue[600],
                                        ),
                              SizedBox(
                                width: width * 0.008,
                              ),
                              Text(
                                  state.tmpList[index].fcstValue + degrees + 'C'),
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
            );
//          return Container(
//            child: Center(
//              child: Text("Weather Info Not Available", style: TextStyle(fontSize: 25),),
//            ),
//          );
          }
        },
      ),
    );
  }
}
