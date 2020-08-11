import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/widgets/loading/loading.dart';

class JournalDetail extends StatefulWidget {
  @override
  _JournalDetailState createState() => _JournalDetailState();
}

class _JournalDetailState extends State<JournalDetail> {
  JournalMainBloc _journalMainBloc;
  bool isBeforePageChanged = false;
  bool isChanged = false;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
    _journalMainBloc.add(DetailPageLoad());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _journalMainBloc,
      listener: (BuildContext context, JournalMainState state) {
        if(state.isLoading==true && state.isDetailPageLoading ==true){
          LoadingDialog.onLoading(context);
          _journalMainBloc.add(GetDetailPagePictureList());
        }else if(state.isLoading==false && state.isDetailPageLoading==true){
          LoadingDialog.dismiss(context, (){
            _journalMainBloc.add(PageLoaded());
          });
        }
      },
      child: BlocBuilder<JournalMainBloc, JournalMainState>(
          builder: (context, state) {
        var date = state.journal.date.toDate();
        var formatDate = DateFormat('yyyy.MM.dd').format(date);
        String weekday = daysOfWeek(index: date.weekday);
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
                Navigator.pop(context, isBeforePageChanged);
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
                  _settingModalBottomSheet(context, state);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              (state.detailPictureList.isNotEmpty)
                  ? Container(
                      height: height * 0.498,
                      child: Swiper(
                          layout: SwiperLayout.STACK,
                          itemHeight: height * 0.498,
                          itemWidth: width,
                          loop: true,
                          itemCount: state.detailPictureList.length,
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
                                  state.detailPictureList[index].url,
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
                        width * 0.055, height*0.0625, width * 0.055, 0.0),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.033,
                            child: AutoSizeText(
                              formatDate.toString() + ' ' + weekday,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Color(0xFFB8B8B8),
                              ),
                              minFontSize: 6,
                              stepGranularity: 2,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.029,
                          ),
                          Text(
                            state.journal.content,
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
      }),
    );
  }

  void _settingModalBottomSheet(
      context, JournalMainState state) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              Container(
                height: height * 0.222,
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      onTap: () async {
                        isChanged = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider<JournalCreateBloc>(
                                create: (BuildContext context) =>
                                    JournalCreateBloc()..add(PassFid(fid: state.facility.fid))
                                    ..add(PassExistJournalPictures(journal: state.journal, pictureList: state.detailPictureList)
                                    )
                                    ,
                                child: JournalEditScreen(),
                              ),
                            ));
                        if(isChanged==true){
                          _journalMainBloc.add(DetailPageLoad(loadJournal: true));
                          isBeforePageChanged = true;
                        }
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      title: Text(
                        '삭제하기',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      onTap: () {
                        showAlertDialog(context, state);
                      },
                    ),
                  ],
                ),
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
        Navigator.pop(context);
      },
    );
    Widget continueButton = GestureDetector(
      child: Text(
        "네",
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _journalMainBloc.add(DeleteJournal());
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context,true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Container(
        height: height * 0.25,
        width: width * 0.7,
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
