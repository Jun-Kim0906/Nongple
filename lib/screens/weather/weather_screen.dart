import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/widgets/loading/Loading.dart';

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
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state){
        if (state is WeatherListSet) {
          print(state.weatherList);
          return Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: ListView.separated(
              itemCount: state.weatherList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                thickness: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Column(
                    children: [
                      Text(state.weatherList[index].baseDate),
                      Text(state.weatherList[index].baseTime),
                      Text(state.weatherList[index].category),
                      Text(state.weatherList[index].fcstDate),
                      Text(state.weatherList[index].fcstTime),
                      Text(state.weatherList[index].fcstValue),
                      Text(state.weatherList[index].nx.toString()),
                      Text(state.weatherList[index].ny.toString()),
                    ],
                  ),
                );
              },
            )
          );
        }
        else {
          return Center(child: Loading(),);
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
