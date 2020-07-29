import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/models/picture/picture.dart';
import 'package:nongple/screens/journal/journal_create_screen.dart';
import 'package:nongple/utils/todays_date.dart';

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
  JournalCreateBloc _journalCreateBloc;
  JournalMainBloc _journalMainBloc;
  List<Picture> _image;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var date = widget.date.toDate();
    var formatDate = DateFormat('yyyy.MM.dd').format(date);
    String weekday = daysOfWeek(index: date.weekday);
    print('weekday : $weekday');
//    print('date : $date');
//    print('format date : $formatDate');
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
//        title: Text('test1', style: TextStyle(color: Colors.black),),
//        centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Color(0xFF828282),
              ),
              onPressed: () {
                _settingModalBottomSheet(context);
              },
            ),
          ],
        ),
        body: BlocBuilder<JournalMainBloc, JournalMainState>(
          builder: (context, state) {
            _image = state.pictureList
                .where((data) => data.jid == widget.jid)
                .toList();
            return Column(
              children: [
                (_image.isNotEmpty)
                    ? Container(
                        height: height * 0.6,
//                        width: double.infinity,
                        child: Swiper(
                            layout: SwiperLayout.STACK,
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
                                      _image[index].url),
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
                              widget.content,
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
            );
          },
        ));
  }

  void _settingModalBottomSheet(context) {
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
                                BlocProvider.value(
                                  value: _journalCreateBloc
                                    ..add(
                                        DateSeleted(selectedDate: widget.date)),
                                  child: JournalCreateScreen(
                                    facility: widget.facility,
                                    isModify: true,
                                    date: widget.date,
                                    content: widget.content,
                                    jid: widget.jid,
                                  ),
                                ))).then((value) => _journalMainBloc
                      ..add(GetJournalPictureList(fid: widget.facility.fid))
                      ..add(AllDateSeleted(selectedDate: widget.date)));
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
//                    _journalMainBloc.add(DeleteAll(fid: widget.facility.fid, jid: widget.jid));
//                    _journalMainBloc.add(GetJournalPictureList(fid: widget.facility.fid));
//                    _journalMainBloc.add(AllDateSeleted(selectedDate: widget.date));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
