import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class JournalCreateScreen extends StatefulWidget {
  final String fid;
  JournalCreateScreen({this.fid});

  @override
  _JournalCreateScreenState createState() => _JournalCreateScreenState();
}

class _JournalCreateScreenState extends State<JournalCreateScreen> {
  JournalCreateBloc _journalCreateBloc;
  double height;
  TextEditingController _contentTextEditingController = TextEditingController();
  List<Asset> imageList = List<Asset>();

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _contentTextEditingController.addListener(() {
      _journalCreateBloc
          .add(ContentChanged(content: _contentTextEditingController.text));
    });
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
  }

  getCameraImage() async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    if(imageFile!=null){
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
                    _journalCreateBloc.add(DeleteImageFile(removedFile: state.imageList[index]));
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Color(0xFF6F6F6F),
                  ),
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Column(
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
                          style: TextStyle(
                              color: Color(0xFF929292), fontSize: 13.6),
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
                          _journalCreateBloc.add(DateSeleted(
                              selectedDate: Timestamp.fromDate(date)));
                        },
                        currentTime: state.isDateSeleted
                            ? state.selectedDate.toDate()
                            : DateTime.now(),
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
              child: Container(
                height: height * 0.143,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemCount: state.imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? Row(
                            children: <Widget>[
                              SizedBox(
                                width: 30.0,
                              ),
                              _imagewidget(context, index, state),
                            ],
                          )
                        : _imagewidget(context, index, state);
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationButton(
          title: '완료',
          onPressed: () {
            _journalCreateBloc.add(UploadJournal(fid: widget.fid));
            Navigator.pop(context);
          },
        ),
      );
    });
  }
}
