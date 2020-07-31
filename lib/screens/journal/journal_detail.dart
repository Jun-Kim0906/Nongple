import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/models/journal/journal.dart';
import 'package:nongple/models/picture/picture.dart';
import 'package:nongple/screens/journal/journal_create_screen.dart';
import 'package:nongple/screens/journal/journal_edit_screen.dart';
import 'package:nongple/utils/todays_date.dart';
import 'package:nongple/widgets/loading/loading.dart';

class JournalDetail extends StatefulWidget {
  final String jid;
  final Timestamp date;
  final String content;
  final Facility facility;

  JournalDetail({this.jid, this.date, this.content, this.facility});

  @override
  _JournalDetailState createState() => _JournalDetailState();
}

class _JournalDetailState extends State<JournalDetail> {
  JournalMainBloc _journalMainBloc;

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var date = widget.date.toDate();
    var formatDate = DateFormat('yyyy.MM.dd').format(date);
    String weekday = daysOfWeek(index: date.weekday);
    return BlocBuilder<JournalMainBloc, JournalMainState>(
      builder: (context, mState) {
        List<Journal> _journal = mState.journalList;
        _journal = _journal.where((doc) {
          return doc.jid == widget.jid;
        }).toList();
        List<Picture> _image = mState.pictureList;
        _image = _image.where((data) => data.jid == widget.jid).toList();
        print('[journal detail] image length : ${_image.length}');
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF828282),
              ),
              onPressed: () {
                _image.clear();
                print('image clear status [0 for clear] : ${_image.length}');
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Color(0xFF828282),
                ),
                onPressed: () {
                  _settingModalBottomSheet(
                      context, _journal[0].content, _image);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              (_image.isNotEmpty)
                  ? Container(
                      height: height * 0.6,
//                        width: double.infinity,
                      child: Swiper(
//                          layout: SwiperLayout.STACK,
                          layout: SwiperLayout.DEFAULT,
                          itemHeight: height * 0.6,
                          itemWidth: width,
                          loop: true,
                          itemCount: _image.length,
                          control: SwiperControl(
                              color: Color(0x00000000),
                              disableColor: Color(0x00000000)),
                          viewportFraction: 1.0,
                          scale: 1.0,
                          pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              activeColor: Color(0xFF2F80ED),
                            ),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: EdgeInsets.all(0.0),
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Image(
                                image: CachedNetworkImageProvider(
                                  _image[index].url,
                                ),
                                fit: BoxFit.fill,
                              ),
                            );
                          }),
                    )
                  : Container(),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.1, height / 11, width * 0.1, 0.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            formatDate.toString() + ' ' + weekday,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Color(0xFFB8B8B8),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          Text(
                            _journal[0].content,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Color(0xFFB8B8B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet(context, String content, List<Picture> _image) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.create,
                    color: Colors.black,
                  ),
                  title: Text(
                    '수정하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MultiBlocProvider(
                                  providers: [
                                    BlocProvider<JournalCreateBloc>(
                                      create: (BuildContext context) =>
                                          JournalCreateBloc()
                                            ..add(DateSeleted(
                                                selectedDate: widget.date))
                                            ..add(SetCopyImageList(
                                                copyOfExistingImage: _image)),
                                    ),
                                    BlocProvider.value(
                                      value: _journalMainBloc,
                                    ),
                                  ],
                                  child: JournalEditScreen(
                                    facility: widget.facility,
                                    date: widget.date,
                                    content: content,
                                    jid: widget.jid,
                                  ),
                                ))).then((value) => _journalMainBloc
                      ..add(GetJournalPictureList(fid: widget.facility.fid)));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  title: Text(
                    '삭제하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    showAlertDialog(context, widget.date, content, widget.jid,
                        widget.facility);
                  },
                ),
              ],
            ),
          );
        });
  }

  showAlertDialog(BuildContext context, Timestamp date, String content,
      String jid, Facility facility) {
    // set up the buttons
    Widget cancelButton = GestureDetector(
      child: Text("아니요"),
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    Widget continueButton = GestureDetector(
      child: Text(
        "네",
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _journalMainBloc
            .add(DeleteAll(fid: widget.facility.fid, jid: widget.jid));
        _journalMainBloc.add(GetJournalPictureList(fid: widget.facility.fid));
        _journalMainBloc.add(AllDateSeleted(selectedDate: widget.date));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height - 550,
        width: MediaQuery.of(context).size.width - 30,
        padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '알림',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('정말로 삭제 하시겠습니까?'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 1,
                  child: continueButton,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  flex: 1,
                  child: cancelButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
