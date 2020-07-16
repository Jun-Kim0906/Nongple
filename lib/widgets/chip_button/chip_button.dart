import 'package:flutter/material.dart';
import 'package:nongple/screens/screens.dart';

class ChipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionChip(
            backgroundColor: Colors.white,
            elevation: 3.0,
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.rss_feed,
                size: 20.0,
              ),
            ),
            label: Text(
              'RSS',
              style: TextStyle(fontSize: 14.4),
            ),
            onPressed: () {
              print("RSS");
            }),
        SizedBox(
          width: 20.0,
        ),
        ActionChip(
            backgroundColor: Colors.white,
            elevation: 3.0,
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.settings,
                size: 20.0,
              ),
            ),
            label: Text(
              '설정',
              style: TextStyle(fontSize: 14.4),
            ),
            onPressed: () {
              print("설정");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            }),
      ],
    );
  }
}
