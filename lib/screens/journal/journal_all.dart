import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

class JournalAll extends StatefulWidget {
  @override
  _JournalAllState createState() => _JournalAllState();
}

class _JournalAllState extends State<JournalAll> {
  JournalMainBloc _journalMainBloc;
  bool isChanged = false;
  bool isBeforePageChanged = false;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
    _journalMainBloc.add(AllPageLoad());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _journalMainBloc,
      listener: (BuildContext context, JournalMainState state) {
        if (state.isLoading == true && state.isAllPageLoading == true) {
          LoadingDialog.onLoading(context);
          _journalMainBloc
              .add(GetAllPageJournalList(selectTime: state.selectMonth));
        } else if (state.isLoading == false && state.isAllPageLoading == true) {
          LoadingDialog.dismiss(context, () {
            _journalMainBloc.add(PageLoaded());
          });
        }
      },
      child: BlocBuilder<JournalMainBloc, JournalMainState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bodyColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0.0,
              leading: IconButton(
                color: goBackArrowColor,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context, isBeforePageChanged);
                },
              ),
              title: Column(
                children: [
                  SizedBox(
                    height: height * 0.0328,
                    width: width*0.255,
                    child: FittedBox(
                      child: Text(
                        '일지 전체보기',
                        style: tabAppBarTitleStyle,
                      ),
                    ),
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
                    child: SizedBox(
                      width: width*0.25,
                      height: height*0.0356,
                      child: FittedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              DateFormat('yyyy년 MM월')
                                  .format(state.selectMonth.toDate()),
                              style: TextStyle(
                                  color: Color(0xFF929292), fontSize: 13.6),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFF929292),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        onConfirm: (date, i) {
                          if (date != state.selectMonth) {
                            _journalMainBloc.add(SelectMonthChanged(
                                changedMonth: Timestamp.fromDate(date)));
                          }
                        },
                        dateFormat: 'yyyy-MM',
                        initialDateTime: state.selectMonth.toDate(),
                        locale: DateTimePickerLocale.ko,
                        onClose: () => print("----- onClose -----"),
                        onCancel: () => print('onCancel'),
                      );
                    },
                  ),
                  state.monthlyJournalList.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.monthlyJournalList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            Journal now = state.monthlyJournalList[index];
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
                                        SizedBox(width: width*0.03,),
                                        Expanded(
                                          child: Text(
                                            now.content == ''
                                                ? '입력한 내용이 없습니다.'
                                                : now.content,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Color(0xFFB8B8B8)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                isChanged = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            BlocProvider.value(
                                              value: _journalMainBloc
                                                ..add(
                                                    PassJournal(journal: now)),
                                              child: JournalDetail(),
                                            )));
                                if (isChanged == true) {
                                  _journalMainBloc.add(AllPageLoad());
                                  isBeforePageChanged = true;
                                }
                              },
                            );
                          },
                        )
                      : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: height * 0.18,
                            ),
                            Image.asset('assets/journal_default.png'),
                            SizedBox(
                              height: height * 0.029,
                            ),
                            Container(
                              width: width * 0.43,
                              height: height * 0.058,
                              child: ButtonTheme(
                                minWidth: width * 0.43,
                                child: RaisedButton(
                                  color: Color(0xFF2F80ED),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.025,
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            '일지 작성하러 가기',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    isChanged=await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (BuildContext context) =>
                                                    BlocProvider<
                                                        JournalCreateBloc>(
                                                      create: (BuildContext
                                                              context) =>
                                                          JournalCreateBloc()
                                                            ..add(PassFid(
                                                                fid: state
                                                                    .facility
                                                                    .fid))
                                                            ..add(DateSelected(
                                                                selectedDate:
                                                                    state
                                                                        .selectMonth)),
                                                      child:
                                                          JournalCreateScreen(),
                                                    )));
                                    if(isChanged==true){
                                      _journalMainBloc.add(AllPageLoad());
                                      isBeforePageChanged=true;
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
