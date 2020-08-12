import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nongple/utils/utils.dart';
import 'package:webfeed/domain/media/media.dart';

class DateIcon extends StatelessWidget {
  final Timestamp date;

  const DateIcon({@required Timestamp date, Key key})
      : this.date = date,
        super(key: key);



  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    int dayOfWeek = date.toDate().weekday;

    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.0)),
      color: dayOfWeek == 6? journalIconColor2:dayOfWeek==7?journalIconColor3:journalIconColor1
      ,
      child: Container(
//        decoration: BoxDecoration(
//        ),
        width: width/7,
        height: width/7,
        child: FittedBox(
//          fit: BoxFit.fitHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${date.toDate().day}',
                style: TextStyle(color: dayOfWeek== 6 || dayOfWeek== 7 ?Colors.white:Colors.black,fontSize: 28.6),
              ),
              Text(
                '${DateFormat.E().format(date.toDate())}',
                style: TextStyle(color: dayOfWeek== 6 || dayOfWeek== 7 ?Colors.white:Colors.black,fontSize: 14.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
