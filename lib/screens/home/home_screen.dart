import 'package:flutter/material.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:nongple/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name 님',
//                style: Theme.of(context).textTheme.headline1,
                style: homeMainTitle,
              ),
              Text(
                '오늘도 풍성한 하루 되세요',
//                style: Theme.of(context).textTheme.headline1,
                style: homeMainTitle,
              ),
              Text(
                '$year 년 $month 월 $day 일 $weekday',
//                style: Theme.of(context).textTheme.headline2,
                style: homeSubTitle,
              ),
              Container(
                child: ChipButton(),
              ),
              Expanded(
                child: ListViewBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
