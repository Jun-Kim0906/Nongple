import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'journal.dart';
import 'package:nongple/blocs/blocs.dart';


class JournalMain extends StatefulWidget {
  @override
  _JournalMainState createState() => _JournalMainState();
}

class _JournalMainState extends State<JournalMain> {
  JournalMainBloc _journalMainBloc;
  double height;
  double width;
  bool isChanged;


  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
    _journalMainBloc.add(MainPageLoad());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _journalMainBloc,
      listener: (BuildContext context, JournalMainState state){
        if(state.isLoading==true && state.isMainPageLoading ==true){
          LoadingDialog.onLoading(context);
          _journalMainBloc.add(GetMainPageJournalPictureList());
        }else if(state.isLoading ==false && state.isMainPageLoading==true){
          LoadingDialog.dismiss(context, (){
            _journalMainBloc.add(PageLoaded());
          });
        }
      },
      child: BlocBuilder<JournalMainBloc, JournalMainState>(
        builder: (context, state) {
          width = MediaQuery.of(context).size.width;
          return Scaffold(
            backgroundColor: bodyColor,
            body: Padding(
              padding: EdgeInsets.fromLTRB(width*0.055, 0.0, width*0.055, 0.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.043,
                        width: width * 0.241,
                        child: FittedBox(
                          child: Text(
                            '일자별 기록',
                            style: journalBodyTitleStyle1,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          isChanged = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BlocProvider.value(
                                        value: _journalMainBloc,
                                        child: JournalAll(),
                                      )));
                          if(isChanged==true){
                            _journalMainBloc.add(MainPageLoad());
                          }
                        },
                        child: SizedBox(
                          height: height * 0.027,
                          width: width * 0.177,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '전체보기 >',
                              style: journalViewAllButtonStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.023,
                  ),
                  state.mainThreeJournalList.isNotEmpty
                      ? ListView.builder(
                    itemCount: state.mainThreeJournalList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      bool differentMonth = true;
                      Journal before;
                      Journal now = state.mainThreeJournalList[index];
                      if (index != 0) {
                        before = state.mainThreeJournalList[index - 1];
                        if (before.date.toDate().year ==
                            now.date.toDate().year &&
                            before.date.toDate().month ==
                                now.date.toDate().month) {
                          differentMonth = false;
                        }
                      }
                      return InkWell(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            if (differentMonth)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    5.0, 0.0, 0.0, 8.0),
                                child: SizedBox(
                                  height: height * 0.023,
                                  width: width * 0.127,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(DateFormat('yyyy.MM')
                                        .format(state
                                        .mainThreeJournalList[index].date
                                        .toDate()),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
//                                Text(DateFormat('yyyy.MM').format(state.journalList[index].date.toDate())),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 0.0, 8.0, 8.0),
                                  child: DateIcon(
                                    date: now.date,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    now.content == ''
                                        ? '입력한 내용이 없습니다.'
                                        : now.content,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Color(0xFFB8B8B8)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        onTap: () async {
                            isChanged = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BlocProvider.value(
                                        value: _journalMainBloc
                                          ..add(PassJournal(journal: now)),
                                        child: JournalDetail(),
                                      ),
                                ));
                            if(isChanged==true){
                              _journalMainBloc.add(MainPageLoad());
                            }
                        },
                      );
                    },
                  )
                      : Container(
                    height: height * 0.3,
                    child: Image.asset(
                      'assets/journal_default.png',
                      fit: BoxFit.contain,
                    ),
                  ),
//                  SizedBox(
//                    height: height * 0.063,
//                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.043,
                        width: width * 0.19,
                        child: FittedBox(
//                          fit: BoxFit.fitWidth,
                          child: Text(
                            '사진 기록',
                            style: journalBodyTitleStyle1,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BlocProvider.value(
                                        value: _journalMainBloc,
                                        child: JournalAllPictures(),
                                      )));
                        },
                        child: SizedBox(
                          height: height * 0.027,
                          width: width * 0.177,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '전체보기 >',
                              style: journalViewAllButtonStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: width * 0.2778,
                    child: state.mainThreePictureList.isNotEmpty
                        ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.mainThreePictureList.length,
                      itemBuilder: (BuildContext context, index) {
                        return _imagewidget(context, index, state);
                      },
                    )
                        : Container(
                      height: height * 0.3,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: SizedBox(
                height: height * 0.019,
                width: width * 0.019,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                      child: Icon(Icons.add)
                  ),
              ),
              onPressed: () async {
                bool isChanged = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>BlocProvider<JournalCreateBloc>(
                          create: (BuildContext context) =>
                          JournalCreateBloc()..add(PassFid(fid: state.facility.fid)),
                          child: JournalCreateScreen(),
                        )));
                if(isChanged){
                  _journalMainBloc.add(MainPageLoad());
                }
              },
              label: SizedBox(
                height: height * 0.019,
                  width: width * 0.325,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                      child: Text('오늘의 활동 기록하기')
                  ),
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
          );
        }
      ),
    );
  }

  Widget _imagewidget(BuildContext context, int index, JournalMainState state) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: width * 0.2778,
        height: width * 0.2778,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (_, __, ___) => JournalPictureDetail(
                url: state.mainThreePictureList[index].url,
                ismain: true,
              ),
              fullscreenDialog: true,
              transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                  ) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
            ));
          },
          child: Hero(
            tag: '${state.mainThreePictureList[index].url}+main',
            child: Container(
              height: height * 0.108,
              width: height * 0.108,
//            height: height * 0.126,
//              width: height * 0.126,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        state.mainThreePictureList[index].url)),
              ),
            ),
          ),
        ));
  }
}
