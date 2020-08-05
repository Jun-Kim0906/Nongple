import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/journal/journal.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class JournalMain extends StatefulWidget {

  @override
  _JournalMainState createState() => _JournalMainState();
}

class _JournalMainState extends State<JournalMain> {
  JournalMainBloc _journalMainBloc;
  double height;

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
    _journalMainBloc.add(OnLoading());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocListener(
      bloc: _journalMainBloc,
      listener: (BuildContext context, JournalMainState state) {
        if (state.isLoaded == true && state.mainDialog==true) {
          print('로딩창 팝되는거 한번만 되야함');
          LoadingDialog.dismiss(context, (){
            _journalMainBloc.add(MainDialogToFalse());
          });
        } else if(state.isLoaded ==false && state.mainDialog==true){
          print('[journal main screen] get journal picture list is called');
          _journalMainBloc.add(GetJournalPictureList(fid: state.facility.fid));
          LoadingDialog.onLoading(context);
        }
      },
      child: BlocBuilder<JournalMainBloc, JournalMainState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bodyColor,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '일자별 기록',
                            style: journalBodyTitleStyle1,
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BlocProvider.value(
                                            value: _journalMainBloc
                                              ..add(AllDateSeleted(
                                                  selectedDate:
                                                      Timestamp.now())),
                                            child: JournalAll(),
                                          )));
                            },
                            child: Text(
                              '전체보기 >',
                              style: journalViewAllButtonStyle,
                            ),
                          ),
                        ],
                      ),
                      state.journalList.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.journalList.length > 3
                                  ? 3
                                  : state.journalList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                bool differentmonth = true;
                                Journal before;
                                Journal now = state.journalList[index];
                                if (index != 0) {
                                  before = state.journalList[index - 1];
                                  if (before.date.toDate().year ==
                                          now.date.toDate().year &&
                                      before.date.toDate().month ==
                                          now.date.toDate().month) {
                                    differentmonth = false;
                                  }
                                }
                                return InkWell(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      if (differentmonth)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5.0, 0.0, 0.0, 8.0),
                                          child: Text(DateFormat('yyyy.MM')
                                              .format(state
                                                  .journalList[index].date
                                                  .toDate())),
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
                                  onTap: () {
                                    if (state.isLoaded == true) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                BlocProvider.value(
                                              value: _journalMainBloc
                                                ..add(PassJournalDetailArgs(
                                                    jid: now.jid,
                                                    date: now.date,
                                                    content: now.content)),
                                              child: JournalDetail(),
                                            ),
                                          ));
                                    } else {
                                      throw Exception(
                                          '[journal main screen] page is not loaded');
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '사진 기록',
                            style: journalBodyTitleStyle1,
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BlocProvider<JournalMainBloc>.value(
                                            value: _journalMainBloc,
                                            child: JournalAllPictures(),
                                          )));
                            },
                            child: Text(
                              '전체보기 >',
                              style: journalViewAllButtonStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                    child: Container(
                  height: height * 0.143,
                  child: state.pictureList.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.pictureList.length,
                          itemBuilder: (BuildContext context, index) {
                            return index == 0
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      _imagewidget(context, index, state),
                                    ],
                                  )
                                : _imagewidget(context, index, state);
                          },
                        )
                      : Container(
                          height: height * 0.3,
                        ),
                )),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: _journalMainBloc,
                                ),
                                BlocProvider<JournalCreateBloc>(
                                  create: (BuildContext context) =>
                                      JournalCreateBloc(),
                                )
                              ],
                              child: JournalCreateScreen(),
                            )));
              },
              label: Text('오늘의 활동 기록하기'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  Widget _imagewidget(BuildContext context, int index, JournalMainState state) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: height * 0.143,
        height: height * 0.143,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (_, __, ___) => JournalPictureDetail(
                url: state.pictureList[index].url,
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
            tag: '${state.pictureList[index].url}+main',
            child: Container(
              height: height * 0.108,
              width: height * 0.108,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        state.pictureList[index].url)),
              ),
            ),
          ),
        ));
  }
}
