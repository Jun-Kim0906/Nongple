import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';


class JournalCreateScreen extends StatefulWidget {
  @override
  _JournalCreateScreenState createState() => _JournalCreateScreenState();
}

class _JournalCreateScreenState extends State<JournalCreateScreen> {
  JournalMainBloc _journalMainBloc;
  double height;
  TextEditingController _contentTextEditingController = TextEditingController();
//  List<Asset> imageList = List<Asset>();

  @override
  void initState() {
    super.initState();
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
    _contentTextEditingController.addListener(() {
      _journalMainBloc.add(ContentChanged(content: _contentTextEditingController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    return BlocBuilder<JournalMainBloc, JournalMainState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                color: journalGoBackArrowColor,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0.0,
              title: Text(
                '일지작성',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.isDateSeleted
                              ? DateFormat('yyyy년 MM월 dd일')
                              .format(state.selectedDate.toDate())
                              : '$year년 $month월 $day일',
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
                          _journalMainBloc.add(
                              DateSeleted(
                                  selectedDate: Timestamp.fromDate(date)));
                        },
                        currentTime: state.isDateSeleted ? state.selectedDate
                            .toDate() : DateTime.now(),
                        locale: LocaleType.ko,
                      );
                    },
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: height * 0.45,
                      padding: EdgeInsets.all(18.0),
                      child: TextFormField(
                        controller: _contentTextEditingController,
                        minLines: 25,
                        maxLines: null,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: ' 오늘 일지를 수기로 작성해 주세요.',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                            height: height * 0.07,
                            child: OutlineButton(
                              color: Colors.white,
                              borderSide: BorderSide(
                                color: Color(0xFFDEDEDE),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.photo,
                                    color: Color(0xFF757575),
                                    size: height * 0.03,
                                  ),
                                  Text(
                                    ' 갤러리',
                                    style: TextStyle(
                                        fontSize: 21.6,
                                        color: Color(0xFF757575),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onPressed: () {
//                                getImage();
                              },
                            )),
                      ),
                      Expanded(
                        child: Container(
                          height: height * 0.07,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          child: OutlineButton(
                            color: Colors.white,
                            borderSide: BorderSide(
                              color: Color(0xFFDEDEDE),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Color(0xFF757575),
                                  size: height * 0.03,
                                ),
                                Text(
                                  ' 사진 촬영',
                                  style: TextStyle(
                                      fontSize: 21.6,
                                      color: Color(0xFF757575),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.031,
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Container(
                            height: height * 0.143,
                            width: height * 0.143,
                            child: Stack(
                              children: <Widget>[
                                Image.asset('assets/launcher_icon.png'),
                                Align(
                                  alignment: FractionalOffset.topRight,
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            height: height * 0.143,
                            width: height * 0.143,
                            child: Stack(
                              children: <Widget>[
                                Image.asset('assets/launcher_icon.png'),
                                Align(
                                  alignment: FractionalOffset.topRight,
                                  child: Icon(Icons.play_circle_filled),
                                ),
                              ],
                            )),
                        Container(
                            height: height * 0.143,
                            width: height * 0.143,
                            child: Stack(
                              children: <Widget>[
                                Image.asset('assets/launcher_icon.png'),
                                Align(
                                  alignment: FractionalOffset.topRight,
                                  child: Icon(Icons.play_circle_filled),
                                ),
                              ],
                            )),
                        Container(
                            height: height * 0.143,
                            width: height * 0.143,
                            child: Stack(
                              children: <Widget>[
                                Image.asset('assets/launcher_icon.png'),
                                Align(
                                  alignment: FractionalOffset.topRight,
                                  child: Icon(Icons.play_circle_filled),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationButton(
              title: '완료',
              onPressed: () {
//                getImage();
                },
            ),
          );
        });
  }
//  getImage() async {
//    List<Asset> resultList = List<Asset>();
//    resultList =
//    await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true, selectedAssets: imageList);
//    setState(() {
//      imageList = resultList;
//    });
//  }
}
