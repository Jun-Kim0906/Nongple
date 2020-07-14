import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '성운이네 딸기 농장',
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '경북 포항시 북구 양덕로 30번길 62-1',
                  style: TextStyle(fontSize: 10.0),
                ),
              ],
            ),
            Column(
              children: [
                Text('날씨 온도'),
              ],
            ),
          ],
        ),
        ),
    );
  }
}
