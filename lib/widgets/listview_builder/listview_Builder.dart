import 'package:flutter/material.dart';
import 'package:nongple/widgets/widgets.dart';

class ListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
//        return Container();
        if (index == 2) {
          return Column(
            children: [
              SizedBox(
                height: height - 670,
              ),
              ButtonCard(),
            ],
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: height - 670,
              ),
              HomePageCard(),
            ],
          );
        }
//                    return HomePageCard();
      },
    );
  }
}
