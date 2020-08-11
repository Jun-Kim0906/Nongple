import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/rss_screen/rss_add.dart';
import 'package:nongple/screens/rss_screen/rss_demo.dart';
import 'package:nongple/utils/colors.dart';

class RssMainScreen extends StatefulWidget {
  @override
  _RssMainScreenState createState() => _RssMainScreenState();
}

class _RssMainScreenState extends State<RssMainScreen> {
  RssMainBloc _rssMainBloc;

  @override
  void initState() {
    super.initState();
    _rssMainBloc = BlocProvider.of<RssMainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Color(0xFF979797), // color grey
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
            'RSS',
          style: TextStyle(
            color: Color(0xFF263238), // color black
          ),
        ),
        centerTitle: true,
      ),
      body: emptyList(),
    );
  }

  Widget emptyList () {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/rss_default.png'),
            SizedBox(
              height:
              MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height:
              MediaQuery.of(context).size.height * 0.065,
              child: ButtonTheme(
                minWidth:
                MediaQuery.of(context).size.width * 0.5,
//                                  height: ,
                child: FlatButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        '추가하기',
                        style: TextStyle(
                          color: Color(0xFF2F80ED),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          BlocProvider.value(
                            value: _rssMainBloc,
                            child: RssAdd(),
                          )
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF2F80ED)),
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text('go to rss demo'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RSSDemo()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
