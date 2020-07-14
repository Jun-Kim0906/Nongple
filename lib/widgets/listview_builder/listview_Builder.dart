import 'package:flutter/material.dart';
import 'package:nongple/widgets/widgets.dart';

class ListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
//        return Container();
        if (index == 2) {
          return ButtonCard();
        }
        else {
          return HomePageCard();
        }
//                    return HomePageCard();
      },
    );
  }
}
