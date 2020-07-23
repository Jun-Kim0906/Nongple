import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/blocs/blocs.dart' as prefix0;
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/journal/journal.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class JournalMain extends StatefulWidget {
  Facility facility;

  JournalMain({this.facility});

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
    _journalMainBloc.add(prefix0.GetJournalPictureList(fid: widget.facility.fid));
  }

  Widget _imagewidget(BuildContext context, int index, JournalMainState state) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: height * 0.143,
        height: height * 0.143,
        child: Container(
          height: height * 0.108,
          width: height * 0.108,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                state.pictureList[index].url,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocBuilder<JournalMainBloc, JournalMainState>(
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
                                    BlocProvider<JournalMainBloc>.value(
                                      value: _journalMainBloc..add(AllDateSeleted(selectedDate: Timestamp.now())),
                                      child: JournalAll(facility: widget.facility),
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
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if (differentmonth)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5.0, 0.0, 0.0, 8.0),
                                      child: Text(DateFormat('yyyy.MM').format(
                                          state.journalList[index].date
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
                              );
                            },
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '사진 기록',
                      style: journalBodyTitleStyle1,
                        ),
                        FlatButton(
                          onPressed: () {

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
                    : Container(),
              )),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BlocProvider<JournalCreateBloc>(
                            create: (BuildContext context) =>
                                JournalCreateBloc(),
                            child: JournalCreateScreen(facility: widget.facility),
                          ))).then((value) =>
                  _journalMainBloc.add(GetJournalPictureList(fid: widget.facility.fid)));
            },
            label: Text('오늘의 활동 기록하기'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
