import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';

class JournalCreateScreen extends StatefulWidget {
  @override
  _JournalCreateScreenState createState() => _JournalCreateScreenState();
}

class _JournalCreateScreenState extends State<JournalCreateScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: journalGoBackArrowColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        title: Text(
          '일지작성',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Text('$year년 $month월 $day일'),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              onPressed: () {},
            ),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: height * 0.5,
                padding: EdgeInsets.all(18.0),
                child: TextFormField(
                  minLines: 25,
                  maxLines: null,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: ' 오늘 일지를 수기로 작성해 주세요.',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusColor: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                    child: Card(
                      child: Icon(
                        Icons.photo
                      ),
                    )
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Card(
                      child: Icon(
                        Icons.camera_alt
                      ),
                    ),
                  ),
                ),
//                Flexible(
//                  flex: 1,
//                  child: Padding(
//                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
//                    child: RaisedButton(
//                      child: Icon(
//                        Icons.image
//                      ),
//                      onPressed: (){
//                      },
//                    ),
//                  ),
//                ),
//                Flexible(
//                  flex: 1,
//                  child:  Padding(
//                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//                    child: RaisedButton(
//                      child: Icon(
//                        Icons.camera_enhance
//                      ),
//                      onPressed: (){
//                      },
//                    ),
//                  ),
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
