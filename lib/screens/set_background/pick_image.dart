import 'package:flutter/material.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/create_facility/bottom_Navigation_button.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';

class PickBackground extends StatefulWidget {
  final Facility facList;

  PickBackground({
    Key key,
    this.facList,
  }) : super(key: key);

  @override
  _PickBackgroundState createState() => _PickBackgroundState();
}

class _PickBackgroundState extends State<PickBackground> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.blue[600],
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '배경화면 관리',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
        child: Column(children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: (widget.facList.category == 1 ||
                        widget.facList.category == 2)
                    ? Icon(CustomIcons.tractor, color: Color(0xFF2F80ED))
                    : (widget.facList.category == 3)
                        ? Icon(CustomIcons.cow, color: Color(0xFF2F80ED))
                        : Icon(CustomIcons.plant, color: Color(0xFF2F80ED)),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Flexible(
                flex: 3,
                child: Text(widget.facList.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 5,),
          Flexible(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 1,
              child: Card(
                elevation: 2.0,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Text('Background'),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 15,),
          Flexible(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: OutlineButton(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.collections),
                      Text('사진 선택하기'),
                    ],
                  ),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationButton(
          title: '저장',
          onPressed: () {},
      )
    );
  }
}
