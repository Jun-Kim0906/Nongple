import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        leading: IconButton(
          color: weatherGoBackArrowColor,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text(
              '날씨',
              style: tabAppBarTitleStyle,
            ),
            Text(
              '성운이네 딸기농장',
              style: tabAppBarSubtitleStyle,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
