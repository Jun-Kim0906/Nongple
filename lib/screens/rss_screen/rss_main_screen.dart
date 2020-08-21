import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:nongple/screens/screens.dart';

class RssMainScreen extends StatefulWidget {
  @override
  _RssMainScreenState createState() => _RssMainScreenState();
}

class _RssMainScreenState extends State<RssMainScreen> {
  RssMainBloc _rssMainBloc;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _rssMainBloc = BlocProvider.of<RssMainBloc>(context);
    _rssMainBloc.add(LoadRssPage());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _rssMainBloc,
      listener: (BuildContext context, RssMainState state){
        if(state.isLoading == true && state.isMainPageLoading == true){
          LoadingDialog.onLoading(context);
          _rssMainBloc.add(GetRss());
        }else if(state.isLoading == false && state.isMainPageLoading == true){
          LoadingDialog.dismiss(context, (){
            _rssMainBloc.add(RssPageLoaded());
          });
        }
      },
      child: BlocBuilder<RssMainBloc, RssMainState>(builder: (context, state) {
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
                onPressed: () {
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
              actions: state.originalList.isEmpty
                  ? null
                  : state.editButtonPressed
                      ? [
                          FlatButton(
                            child: Container(
                                height: height * 0.0315,
                                width: width * 0.081,
                                child: FittedBox(
                                  child: Text(
                                    '완료',
                                    style: TextStyle(
                                      color: Color(0xFF2D9CDB),
                                    ),
                                  ),
                                )),
                            onPressed: () {
                              _rssMainBloc.add(EditButtonPressed());
                            },
                          )
                        ]
                      : [
                          FlatButton(
                              child: Container(
                                  height: height * 0.0315,
                                  width: width * 0.081,
                                  child: FittedBox(
                                    child: Text(
                                      '수정',
                                      style: TextStyle(
                                        color: Color(0xFF2F80ED),
                                      ),
                                    ),
                                  )),
                              onPressed: () {
                                _rssMainBloc.add(EditButtonPressed());
                              }),
                        ]),
          body: state.originalList.isEmpty ? emptyList() : listSet(state),
        );
      }),
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
                itemCount: state.originalList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RssDetail(
                                    rssOption: state.originalList[index],
                                  )));
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
                              child: Container(
                                height: height * 0.027,
                                child: AutoSizeText(
                                  state.originalList[index].name
                                      .replaceFirst(" ", "\n"),
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2F80ED),
                                  ),
                                  maxLines: 1,
                                ),
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: height * 0.027,
                              child: AutoSizeText(
                                state.originalList[index].option,
                                style: TextStyle(
                                  fontSize: 50,
                                  letterSpacing: -0.0615,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: height * 0.027,
                                child: state.editButtonPressed
                                    ? InkWell(
                                        child: AutoSizeText(
                                          '삭제',
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2D9CDB),
                                          ),
                                          maxLines: 1,
                                        ),
                                        onTap: () {
                                          _rssMainBloc.add(DeleteRss(
                                              deleteRss:
                                                  state.originalList[index]));
                                        })
                                    : InkWell(
                                        child: FittedBox(
                                            child:
                                                Icon(Icons.arrow_forward_ios)),
                                        onTap: () {},
                                      ),
                              )),
                        ]),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: state.originalList.isNotEmpty &&
                      state.editButtonPressed == true
                  ? OutlineButton(
                      borderSide: BorderSide(color: Color(0xFF2D9CDB)),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          '추가하기',
                          style: TextStyle(color: Color(0xFF2D9CDB)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: _rssMainBloc,
                                    child: RssAdd(),
                                  )),
                        );
                      },
                    )
                  : Container(
                      padding: EdgeInsets.only(bottom: 20),
                      height: 0,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget emptyList() {
    return Container(
      height: height / 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/rss_default.png'),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              width: width * 0.9,
              height: height * 0.065,
              child: ButtonTheme(
                minWidth: width * 0.5,
                child: FlatButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                                value: _rssMainBloc,
                                child: RssAdd(),
                              )),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF2F80ED)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
