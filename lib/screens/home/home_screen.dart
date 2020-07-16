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
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name님\n오늘도 풍성한 하루 되세요',
//                style: Theme.of(context).textTheme.headline1,
                style: homeMainTitle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '$year년 $month월 $day일 $weekday',
//                style: Theme.of(context).textTheme.headline2,
                style: homeSubTitle,
              ),
              SizedBox(
                height: 18.0,
              ),
              Container(
                child: ChipButton(),
              ),
              SizedBox(
                height: 27.0,
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
