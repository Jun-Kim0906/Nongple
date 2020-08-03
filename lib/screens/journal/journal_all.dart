import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/journal/journal.dart';
import 'package:nongple/screens/journal/journal_create_screen.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class JournalAll extends StatefulWidget {
//  Facility facility;
//
//  JournalAll({@required this.facility});

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
                  state.facility.name,
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
                      onConfirm: (date, i) {
                        print('confirm $date');
                        _journalMainBloc.add(AllDateSeleted(
                            selectedDate: Timestamp.fromDate(date)));
                      },
                      dateFormat: 'yyyy-MM',
                      initialDateTime: state.selectedDate.toDate(),
                      locale: DateTimePickerLocale.ko,
                      onClose: () => print("----- onClose -----"),
                      onCancel: () => print('onCancel'),
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
                          print(
                              'journal all listview builder item content: ${now.content}');
                          return InkWell(
                            child: Container(
                              child: Column(
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
                              ),
                            ),
                            onTap: () {
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
                                          )));
                            },
                          );
                        },
                      )
                    : Container(
//                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset('assets/journal_default.png'),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.5,
//                                  height: ,
                                  child: RaisedButton(
                                    color: Color(0xFF2F80ED),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '일지 작성하러 가기',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MultiBlocProvider(
                                                    providers: [
                                                      BlocProvider<
                                                          JournalCreateBloc>(
                                                        create: (BuildContext
                                                                context) =>
                                                            JournalCreateBloc(),
                                                      ),
                                                      BlocProvider.value(
                                                        value: _journalMainBloc,
                                                      )
                                                    ],
                                                    child:
                                                        JournalCreateScreen(),
                                                  )));
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
