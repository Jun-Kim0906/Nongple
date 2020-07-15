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
              child: Icon(Icons.rss_feed),
            ),
            label: Text('RSS'),
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
              child: Icon(Icons.settings),
            ),
            label: Text('설정'),
            onPressed: () {
              print("설정");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Settings()));
            }),
      ],
    );
  }
}
