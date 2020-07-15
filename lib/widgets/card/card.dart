import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/utils.dart';

class HomePageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 143,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('card tapped');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider<TabBloc>(
                      create: (context) => TabBloc(),
                      child: TabScreen(),
                    )
                )
            );
          },
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '성운이네 딸기 농장',
                            style: cardWidgetFacilityNameStyle,
                          ),
                          Text(
                            '경북 포항시 북구 양덕로 30번길 62-1',
                            style: cardWidgetAddrStyle,
                          ),
                        ],
                      ),
                      Text(
                        '25' + degrees + 'C',
                        style: cardWidgetWeatherDataStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                          backgroundColor: Colors.white,
                          elevation: 1.0,
                          label: Text(
                            ' 자세희보기 ',
                            style: cardWidgetDetailButtonStyle,
                          ),
                      ),
                      Flexible(
                        child: Chip(
                          backgroundColor: Colors.white,
                          elevation: 1.0,
                          label: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
