import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/picture/picture.dart';
import 'package:nongple/screens/journal/journal_edit_screen.dart';
import 'package:nongple/utils/todays_date.dart';


class JournalDetail extends StatefulWidget {

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
    return BlocBuilder<JournalMainBloc, JournalMainState>(
      builder: (context, state) {
        var date = state.detailPageDate.toDate();
        var formatDate = DateFormat('yyyy.MM.dd').format(date);
        String weekday = daysOfWeek(index: date.weekday);
        List<Picture> _image = state.pictureList;
        _image =
            _image.where((data) => data.jid == state.detailPageJid).toList();
        print('[journal detail] image length : ${state.pictureList.length}');
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
                  _settingModalBottomSheet(context, state, _image);
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
                          layout: SwiperLayout.STACK,
//                    layout: SwiperLayout.DEFAULT,
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
                            state.detailPageContent,
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

  void _settingModalBottomSheet(
      context, JournalMainState state, List<Picture> _image) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Wrap(
            children: <Widget>[
              Column(
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
                                                  selectedDate:
                                                      state.detailPageDate))
                                              ..add(SetCopyImageList(
                                                  copyOfExistingImage: _image)),
                                      ),
                                      BlocProvider.value(
                                        value: _journalMainBloc,
                                      ),
                                    ],
                                    child: JournalEditScreen(
                                      content: state.detailPageContent,
                                    ),
                                  )));
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
                      showAlertDialog(context, state);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  showAlertDialog(BuildContext context, JournalMainState state) {
    // set up the buttons
    Widget cancelButton = GestureDetector(
      child: Text("아니요"),
      onTap: () {
//        Navigator.pop(context);
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
            .add(DeleteAll(fid: state.facility.fid, jid: state.detailPageJid));
        _journalMainBloc.add(GetJournalPictureList(fid: state.facility.fid));
        _journalMainBloc
            .add(AllDateSeleted(selectedDate: state.detailPageDate));
        _journalMainBloc.add(OnLoading());
        Navigator.pop(context);
        Navigator.pop(context);
//        Navigator.pop(context);
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
