import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class JournalMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        leading: IconButton(
          color: journalGoBackArrowColor,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text(
              '일지',
              style: tabAppBarTitleStyle,
            ),
            Text(
              '성운이네 딸기농장',
              style: tabAppBarSubtitleStyle,
            ),
          ],
        ),
        centerTitle: true,
      ),
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
                      '메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 메모 내용 '),
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
        onPressed: () {},
        label: Text('오늘의 활동 기록하기'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
