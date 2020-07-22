import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/journal/journal.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class JournalMain extends StatefulWidget {
  String fid;
  JournalMain({this.fid});
  @override
  _JournalMainState createState() => _JournalMainState();
}

class _JournalMainState extends State<JournalMain> {
  JournalMainBloc _journalMainBloc;

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalMainBloc, JournalMainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: bodyColor,
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '일자별 기록',
                      style: journalBodyTitleStyle1,
                    ),
                    FlatButton(
                      onPressed: () {
                        print('전체보기 클릭');
                      },
                      child: Text(
                        '전체보기 >',
                        style: journalViewAllButtonStyle,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('2020.07'),
                  ],
                ),
                Row(
                  children: [
                    DateIcon(
                      date: Timestamp.fromDate(DateTime.now()),
                    ),
                    Expanded(
                      child: Text(
//                          state.journalList[0].content
                      '',
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      backgroundColor: journalIconColor3,
                      label: Column(
                        children: [
                          Text('12'),
                          Text('Sun'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                          '메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 '),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('2020.06'),
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      backgroundColor: journalIconColor2,
                      label: Column(
                        children: [
                          Text('11'),
                          Text('Mon'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                          '메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 '),
                    )
                  ],
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
                        print('전체보기 클릭');
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
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                      BlocProvider<JournalCreateBloc>(
                        create: (BuildContext context)=>JournalCreateBloc(),
                        child: JournalCreateScreen(fid: widget.fid),
                      ))).then((value) => _journalMainBloc.add(GetJournalList()));
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
