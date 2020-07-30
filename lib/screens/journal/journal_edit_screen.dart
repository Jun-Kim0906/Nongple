import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongple/models/models.dart';

class JournalEditScreen extends StatefulWidget {
  final Facility facility;
  final Timestamp date;
  final String content;
  final bool isModify;
  final String jid;

  JournalEditScreen(
      {this.facility, this.isModify, this.date, this.content, this.jid});

  @override
  _JournalEditScreenState createState() => _JournalEditScreenState();
}

class _JournalEditScreenState extends State<JournalEditScreen> {
  JournalCreateBloc _journalCreateBloc;
  JournalMainBloc _journalMainBloc;
  double height;
  TextEditingController _contentTextModifyingController;
  List<Asset> imageList = List<Asset>();
  List<Picture> existingImageList;
  List<Picture> copyOfExistingList;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
    _contentTextModifyingController =
        TextEditingController(text: '${widget.content}');
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocBuilder<JournalMainBloc, JournalMainState>(
      builder: (context, mState) {
        return BlocBuilder<JournalCreateBloc, JournalCreateState>(
            builder: (context, state) {
          existingImageList =
              mState.pictureList.where((doc) => doc.jid == widget.jid).toList();
          copyOfExistingList = existingImageList;
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
              title: Text('일지수정', style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
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
                              DateFormat('yyyy년 MM월 dd일')
                                  .format(widget.date.toDate()),
                              style: TextStyle(
                                  color: Color(0xFF929292), fontSize: 13.6),
                            )
                          ],
                        ),
                        onPressed: () {},
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
                            controller: _contentTextModifyingController,
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
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
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
                                    getImage(state);
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
                                onPressed: () {
                                  getCameraImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
                Flexible(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: height * 0.143,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            itemCount: copyOfExistingList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  _existingImageWidget(context, index),
                                  (index == copyOfExistingList.length - 1)
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: state.imageList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return index == 0
                                                ? Row(
                                                    children: <Widget>[
//                                          SizedBox(
//                                            width: 30.0,
//                                          ),
                                                      _imagewidget(context,
                                                          index, state),
                                                    ],
                                                  )
                                                : _imagewidget(
                                                    context, index, state);
                                          },
                                        )
                                      : Container(),
                                ],
                              );
                            },
                          )),
                    ],
                  ),
                )),
              ],
            ),
            bottomNavigationBar: BottomNavigationButton(
              title: '수정',
              onPressed: () {
                _journalCreateBloc.add(ContentChanged(
                    content: _contentTextModifyingController.text));
                _journalCreateBloc.add(DateSeleted(selectedDate: widget.date));
                _journalCreateBloc.add(
                    UpdateJournal(fid: widget.facility.fid, jid: widget.jid));
                Navigator.pop(context);
              },
            ),
          );
        });
      },
    );
  }

  Future<File> writeToFile(ByteData data, int i) async {
    final buffer = data.buffer;
    final String dttm = Timestamp.now().millisecondsSinceEpoch.toString();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath +
        '/file_0${dttm}.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  getImage(JournalCreateState state) async {
    List<Asset> resultList = List<Asset>();
    resultList =
        await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true);

    try {
      if (resultList.isNotEmpty) {
        _journalCreateBloc.add(ImageSeleted(assetList: resultList));
        for (int i = 0; i < resultList.length; i++) {
//        if(state.assetList.where((element) => element.identifier==resultList[i].identifier).length==0){
          ByteData a = await resultList[i].getByteData();
          File file = await writeToFile(a, i);
          _journalCreateBloc.add(AddImageFile(imageFile: file));
//        }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getCameraImage() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      _journalCreateBloc.add(AddImageFile(imageFile: imageFile));
    }
  }

  Widget _imagewidget(
      BuildContext context, int index, JournalCreateState state) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: height * 0.143,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset.bottomLeft,
              child: Container(
                height: height * 0.108,
                width: height * 0.108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      state.imageList[index],
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: FractionalOffset.topRight,
                child: InkWell(
                  onTap: () {
                    _journalCreateBloc.add(
                        DeleteImageFile(removedFile: state.imageList[index]));
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Color(0xFF6F6F6F),
                  ),
                )),
          ],
        ));
  }

  Widget _existingImageWidget(BuildContext context, int index) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: height * 0.143,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset.bottomLeft,
              child: Container(
                height: height * 0.108,
                width: height * 0.108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      copyOfExistingList[index].url,
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: FractionalOffset.topRight,
                child: InkWell(
                  onTap: () {
                    copyOfExistingList.removeAt(index);
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Color(0xFF6F6F6F),
                  ),
                )),
          ],
        ));
  }
}
