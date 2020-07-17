import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';

class HomePageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4.0,
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
                      )));
        },
        child: Container(
          height: height / 5,
          padding: EdgeInsets.fromLTRB(
              width / 25, height / 35, width / 25, height / 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '성운이네 딸기 농장',
                          style: cardWidgetFacilityNameStyle,
                        ),
                        SizedBox(
                          height: 6.0,
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
              Flexible(
                flex: 1,
                child: Container(
                  height: height / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        backgroundColor: Colors.white,
                        elevation: 1.0,
                        label: Text(
                          ' 자세히보기 ',
                          style: cardWidgetDetailButtonStyle,
                        ),
                      ),
                      Container(
//                        width: width,
//                        height: height,
                        child: Card(
                          elevation: 2.0,
                          child: Icon(
                            CustomIcons.cow,
                            color: Color(0xFF2F80ED),
                            size: 25,
                          ),
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
