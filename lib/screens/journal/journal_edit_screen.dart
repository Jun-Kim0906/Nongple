import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class JournalEditScreen extends StatefulWidget {
  @override
  _JournalEditScreenState createState() => _JournalEditScreenState();
}

class _JournalEditScreenState extends State<JournalEditScreen> {
  JournalCreateBloc _journalCreateBloc;
  bool textController = true;
  TextEditingController _textEditingController;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _journalCreateBloc,
      listener: (BuildContext context, JournalCreateState state) {
        if (state.isLoading == true && state.editPageLoading == true) {
          LoadingDialog.onLoading(context);
          _journalCreateBloc.add(LoadExistJournal());
        } else if (state.isLoading == false && state.editPageLoading == true) {
          LoadingDialog.dismiss(context, () {
            _journalCreateBloc.add(EditPageLoaded());
            _textEditingController =
                TextEditingController(text: state.content);
            textController=false;
          });
        } else if (state.createCompletePressed == true &&
            state.uploadComplete == false) {
          LoadingDialog.onLoading(context);
          _journalCreateBloc.add(UpdateJournal());
        } else if (state.createCompletePressed == true &&
            state.uploadComplete == true) {
          LoadingDialog.dismiss(context, () {});
          Navigator.pop(context,true);
          Navigator.pop(context, true);
        }
      },
      child: BlocBuilder<JournalCreateBloc, JournalCreateState>(
          builder: (context, state) {
        if (textController&&state.existJournal.jid!=null) {
          _textEditingController =
              TextEditingController(text: state.existJournal.content);
          textController = false;
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              color: journalGoBackArrowColor,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, false);
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
                                .format(state.existJournal.date.toDate()),
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
                        child: state.editPageLoading
                            ? TextFormField(
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
                              )
                            : TextFormField(
                                onChanged: (value) {
                                  _journalCreateBloc
                                      .add(ContentChanged(content: value));
                                },
                                minLines: 25,
                                maxLines: null,
                                autocorrect: false,
                                controller: _textEditingController,
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
                child: Container(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    height: height * 0.143,
                    child: ListView.builder(
                      shrinkWrap: true,
                      dragStartBehavior: DragStartBehavior.start,
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      itemCount: state.existPictureList.length == 0
                          ? 1
                          : state.existPictureList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            'copy list length : ${state.existPictureList.length}');
                        return Row(
                          children: [
                            (state.existPictureList.length == 0)
                                ? Container()
                                : _existingImageWidget(context, index, state),
                            (state.existPictureList.length == 0 ||
                                    index == state.existPictureList.length - 1)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: state.imageList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return index == 0
                                          ? Row(
                                              children: <Widget>[
                                                _imageWidget(
                                                    context, index, state),
                                              ],
                                            )
                                          : _imageWidget(context, index, state);
                                    },
                                  )
                                : Container(),
                          ],
                        );
                      },
                    )),
              )),
            ],
          ),
          bottomNavigationBar: BottomNavigationButton(
            title: '수정',
            onPressed: () {
              _journalCreateBloc.add(CompletePressed());
            },
          ),
        );
      }),
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
          ByteData a = await resultList[i].getByteData();
          File file = await writeToFile(a, i);
          _journalCreateBloc.add(AddImageFile(imageFile: file));
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

  Widget _imageWidget(
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

  Widget _existingImageWidget(
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
                    image: CachedNetworkImageProvider(
                      state.existPictureList[index].url,
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: FractionalOffset.topRight,
                child: InkWell(
                  onTap: () {
                    _journalCreateBloc.add(DeleteExistPicture(index: index));
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
