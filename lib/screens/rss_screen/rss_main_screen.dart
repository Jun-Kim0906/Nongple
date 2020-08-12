import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/rss/rss.dart';
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

  Widget listSet(RssMainState state) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: state.copiedList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                    },
                    child: Table(
                      columnWidths: {
                        0: FractionColumnWidth(.3),
                        1: FractionColumnWidth(.6),
                        2: FractionColumnWidth(.1)
                      },
                      border: TableBorder(
                        horizontalInside: BorderSide(
                            style: BorderStyle.solid,
                            width: 1,
                            color: Color.fromRGBO(242, 242, 242, 100)),
                      ),
                      children: [
                        TableRow(children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                state.copiedList[index].name
                                    .replaceFirst(" ", "\n"),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 61, 165, 1),
                                ),
                                maxLines: 2,
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                            alignment: Alignment.centerLeft,
                            child: Text(state.copiedList[index].option,
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: -0.0615,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Text(
                                '삭제',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 61, 165, 1),
                                ),
                              ),
                              onTap: () {}
                            ),
                          ),
                        ]),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child:Container(
                padding: EdgeInsets.only(bottom: 20),
                height: 0,
              ),
            )
          ],
        ),
      ),
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
