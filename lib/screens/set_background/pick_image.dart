import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongple/blocs/background_image_bloc/bloc.dart';
import 'package:nongple/blocs/home_bloc/home.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/screens/set_background/image_list.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/create_facility/bottom_Navigation_button.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';
import 'package:random_string/random_string.dart';

class PickBackground extends StatefulWidget {
  final Facility facility;

  PickBackground({
    Key key,
    this.facility,
  }) : super(key: key);

  @override
  _PickBackgroundState createState() => _PickBackgroundState();
}

class _PickBackgroundState extends State<PickBackground> {
  BgBloc _bgBloc;
  HomeBloc _homeBloc;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _bgBloc = BlocProvider.of<BgBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<BgBloc, BgState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: bodyColor,
            appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0.0,
              leading: IconButton(
                color: Colors.blue[600],
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: SizedBox(
                height: height * 0.04,
                child: AutoSizeText(
                  '배경화면 관리',
                  style: settingAppBarStyle,
                ),
              ),
              centerTitle: true,
              actions: [
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BgImageList(bg: state.bg)),
                    );
                  },
                  child: Text(
                    '사진목록',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F80ED),
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.05, height * 0.03, width * 0.05, 0),
              child: Column(children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  leading: SizedBox(
                    height: height * 0.06,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Card(
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.grey[200])),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: (widget.facility.category == 1 ||
                              widget.facility.category == 2)
                              ? Icon(
                            CustomIcons.tractor,
                            color: Color(0xFF2F80ED),
                            size: 30,
                          )
                              : (widget.facility.category == 3)
                              ? Icon(
                            CustomIcons.cow,
                            color: Color(0xFF2F80ED),
                            size: 30,
                          )
                              : Icon(
                            CustomIcons.plant,
                            color: Color(0xFF2F80ED),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: SizedBox(
                    height: height * 0.04,
                    width: width * 0.644,
                    child: AutoSizeText(
                      widget.facility.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 23),
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 6,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: height / 5,
                    width: width / 1,
                    child: Card(
                      elevation: 3.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: state.imageFile != null
                                  ? Image.file(
                                state.imageFile,
                                fit: BoxFit.cover,
                                color:
                                Color.fromRGBO(255, 255, 255, 100),
                                colorBlendMode: BlendMode.modulate,
                              )
                                  : Image.asset("assets/white.png"),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Background',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF2F80ED)),
                            ),
                          ),
                        ],
                      ),
//                Center(child: Text('Background', style: TextStyle(fontSize: 20),),),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 15,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    child: OutlineButton(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.01,
                            height * 0.01, width * 0.01, height * 0.01),
                        child: SizedBox(
                          height: height * 0.04,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.collections,
                                  color: Color(0xFF2F80ED),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                AutoSizeText(
                                  '사진 선택하기',
                                  style: TextStyle(
                                    color: Color(0xFF2F80ED),
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        getImage();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Color(0xFF2F80ED)),
                    ),
                  ),
                ),
              ]),
            ),
            bottomNavigationBar: BottomNavigationButton(
              title: '저장',
              onPressed: () async {
                showAlertDialog(context, state);
              },
            ));
      },
    );
  }

  getImage() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _bgBloc.add(UpdateBgUrl(imageFile));
    } else {
      throw Exception('Image file does not exist');
    }
  }

  showAlertDialog(BuildContext context, BgState state) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // set up the buttons
    Widget cancelButton = GestureDetector(
      child: AutoSizeText(
        "아니요",
        maxLines: 1,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = GestureDetector(
      child: AutoSizeText(
        "네",
        style: TextStyle(color: Colors.blue),
        maxLines: 1,
      ),
      onTap: () async {
        _bgBloc.add(SaveBgImage(imageFile: state.imageFile, fid: widget.facility.fid));
        _homeBloc.add((ListLoading()));
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Container(
        height: height * 0.2,
        width: width,
//        padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.04,
              child: AutoSizeText(
                '배경화면 저장',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            SizedBox(
              height: height * 0.03,
              width: width * 0.502,
              child: FittedBox(
                child: Text('정말로 이 배경화면으로 저장 하시겠습니까?'),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            SizedBox(
              height: height * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: continueButton,
                  ),
                  SizedBox(
                    width: width * 0.09,
                  ),
                  Flexible(
                    flex: 1,
                    child: cancelButton,
                  ),
                ],
              ),
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
