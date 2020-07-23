import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class JournalAll extends StatefulWidget {
  Facility facility;

  JournalAll({@required this.facility});

  @override
  _JournalAllState createState() => _JournalAllState();
}

class _JournalAllState extends State<JournalAll> {
  JournalMainBloc _journalMainBloc;
  double height;

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
//    _journalMainBloc.add(prefix0.GetJournalPictureList(fid: widget.facility.fid));
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
                  '일지 전체보기',
                  style: tabAppBarTitleStyle,
                ),
                Text(
                  widget.facility.name,
                  style: tabAppBarSubtitleStyle,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DateFormat('yyyy년 MM월')
                            .format(state.selectedDate.toDate()),
                        style:
                            TextStyle(color: Color(0xFF929292), fontSize: 13.6),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF929292),
                      ),
                    ],
                  ),
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,

                      showTitleActions: true,
                      onConfirm: (date) {
                        print('confirm $date');
                        _journalMainBloc.add(AllDateSeleted(
                            selectedDate: Timestamp.fromDate(date)));
                      },
                      currentTime: state.selectedDate.toDate(),
                      locale: LocaleType.ko,
                    );
                  },
                ),
                state.monthJournalList.isNotEmpty
                    ? ListView.builder(
                  itemCount: state.monthJournalList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Journal now = state.monthJournalList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
              ],
            ),
          ),
        );
      },
    );
  }
}