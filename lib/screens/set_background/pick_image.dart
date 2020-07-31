import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongple/blocs/background_image_bloc/bloc.dart';
import 'package:nongple/blocs/home_bloc/home.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/create_facility/bottom_Navigation_button.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';

class PickBackground extends StatefulWidget {
  final Facility facList;

  PickBackground({
    Key key,
    this.facList,
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
    return BlocBuilder<BgBloc, BgState>(
      builder: (context, state) {
        if (state is BgUrlSet) {
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
                title: Text(
                  '배경화면 관리',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
                child: Column(children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: (widget.facList.category == 1 ||
                                widget.facList.category == 2)
                            ? Icon(CustomIcons.tractor,
                                color: Color(0xFF2F80ED))
                            : (widget.facList.category == 3)
                                ? Icon(CustomIcons.cow,
                                    color: Color(0xFF2F80ED))
                                : Icon(CustomIcons.plant,
                                    color: Color(0xFF2F80ED)),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: 10.0,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(widget.facList.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 1,
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
                                style: TextStyle(fontSize: 20, color: Colors.blue[700]),
                              ),
                            ),
                          ],
                        ),
//                Center(child: Text('Background', style: TextStyle(fontSize: 20),),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: OutlineButton(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.collections, color: Colors.blue[700],),
                              Text('사진 선택하기', style: TextStyle(color: Colors.blue[700]),),
                            ],
                          ),
                        ),
                        onPressed: () {
                          getImage();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
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
        } else {
          return Container();
        }
      },
    );
  }

  Future<String> uploadImageFile(File file) async {
    String url = '';
    final StorageReference ref = storage.ref().child('background_pictures/${file.toString()}');
//            .child(UserUtil.getUser().uid).child('${widget.facList.fid}.jpg');
    final StorageUploadTask uploadTask = ref.putFile(await resizePicture(file));
    await (await uploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((value) => url = value);
    print(url);
    return url;
  }

  getImage() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _bgBloc.add(UpdateBgUrl(imageFile));
    } else {
      throw Exception('Image file does not exist');
    }
  }

  showAlertDialog(BuildContext context, BgUrlSet state) {
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
      onTap: () async {
        String bgUrl = await uploadImageFile(state.imageFile);
        await Firestore.instance
            .collection('Facility')
            .document(widget.facList.fid)
            .updateData({
          'bgUrl': bgUrl,
        });
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
        height: MediaQuery.of(context).size.height - 550,
        width: MediaQuery.of(context).size.width - 30,
        padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '배경화면 저장',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('정말로 이 배경화면으로 저장하시겠습니까?'),
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
