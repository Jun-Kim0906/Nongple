import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongple/blocs/background_image_bloc/bloc.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/create_facility/bottom_Navigation_button.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';
import 'package:nongple/widgets/loading/Loading.dart';

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
  String testImage =
      'https://firebasestorage.googleapis.com/v0/b/nongple2-9440e.appspot.com/o/dan-meyers-IQVFVH0ajag-unsplash.jpg?alt=media&token=17b310ec-1f38-480c-b418-daca94ebb920';
  String blank =
      'https://firebasestorage.googleapis.com/v0/b/nongple2-9440e.appspot.com/o/white.png?alt=media&token=44ff38dd-2022-4954-9235-d3ea40caabac';
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _bgBloc = BlocProvider.of<BgBloc>(context);
  }

  Future<String> uploadImageFile(File file) async {
    String url = '';
    final StorageReference ref =
        storage.ref().child('background_pictures/kk.png');
//            .child(UserUtil.getUser().uid).child('${widget.facList.fid}.jpg');
    print('test');
    final StorageUploadTask uploadTask = ref.putFile(await resizePicture(file));
    print(uploadTask.isComplete);
    await (await uploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((value) => url = value);
    print(url);
    return url;
  }

  getImage() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('imageFile : ${imageFile.path}');
    String bgUrl = await uploadImageFile(imageFile);
    print('bgUrl : $bgUrl');
    print('Upload background image to firestore');
    if(imageFile != null) {
      _bgBloc.add(UpdateBgUrl(bgUrl));
    } else {
      throw Exception('Image file does not exist');
    }
    print("Background state changed");
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
                                child: state.bgUrl.isNotEmpty
                                    ? Image.network(
                                        state.bgUrl,
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
                                style: TextStyle(fontSize: 20),
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
                              Icon(Icons.collections),
                              Text('사진 선택하기'),
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
                  await Firestore.instance
                      .collection('Facility')
                      .document(widget.facList.fid)
                      .updateData({
                    'bgUrl': state.bgUrl,
                  });
                  Navigator.pop(context);
                },
              ));
        } else {
          return Loading();
        }
      },
    );
  }
}
