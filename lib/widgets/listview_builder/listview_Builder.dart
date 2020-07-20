import 'package:flutter/material.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/widgets/widgets.dart';

class ListViewBuilder extends StatefulWidget {
  List<Facility> facList;

  ListViewBuilder({
    Key key,
    this.facList,
  }) : super(key: key);

  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: widget.facList.length,
      itemBuilder: (BuildContext context, int index) {
//        return Container();
        if (index == widget.facList.length - 1) {
          return Column(
            children: [
              SizedBox(
                height: height - 670,
              ),
              HomePageCard(facList: widget.facList[index],),
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
              HomePageCard(facList: widget.facList[index],),
            ],
          );
        }
//                    return HomePageCard();
      },
    );
  }
}
