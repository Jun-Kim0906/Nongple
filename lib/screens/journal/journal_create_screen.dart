import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/utils/utils.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongple/screens/screens.dart';

class JournalCreateScreen extends StatefulWidget {
  @override
  _JournalCreateScreenState createState() => _JournalCreateScreenState();
}

class _JournalCreateScreenState extends State<JournalCreateScreen> {
  JournalCreateBloc _journalCreateBloc;
  DateTime bufferDate;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _journalCreateBloc.add(CheckSameDate());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _journalCreateBloc,
      listener: (BuildContext context, JournalCreateState state) {
        if (state.dateConfirmed == false &&
            state.datePickerState == true &&
            state.checkSameDateDialog == false) {
          pickDate(state);
        } else if (state.dateConfirmed == false &&
            state.datePickerState == false &&
            state.checkSameDateDialog == true) {
          showAlertDialog(context, state);
        } else if (state.createCompletePressed == true &&
            state.uploadComplete == false) {
          LoadingDialog.onLoading(context);
          _journalCreateBloc.add(UploadJournal(fid: state.fid));
        } else if (state.createCompletePressed == true &&
            state.uploadComplete == true) {
          LoadingDialog.dismiss(context, () {
            Navigator.pop(context, true);
          });
        }
      },
      child: BlocBuilder<JournalCreateBloc, JournalCreateState>(
          builder: (context, state) {
        bufferDate = state.selectedDate.toDate();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              color: goBackArrowColor,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            elevation: 0.0,
            title: SizedBox(
              height: height * 0.032,
              child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text('일지작성', style: TextStyle(color: Colors.black))),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.fromLTRB(width * 0.094, 0.0, width * 0.094, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: height * 0.042,
                            width: width * 0.294,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                DateFormat('yyyy년 MM월 dd일')
                                    .format(state.selectedDate.toDate()),
                                style: TextStyle(
                                    color: Color(0xFF929292), fontSize: 13.6),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF929292),
                          ),
                        ],
                      ),
                      onPressed: () {
                        pickDate(state);
                      },
                    ),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: height * 0.449,
                        padding: EdgeInsets.fromLTRB(width * 0.047,
                            height * 0.025, width * 0.047, height * 0.025),
                        child: TextFormField(
                          onChanged: (value) {
                            _journalCreateBloc
                                .add(ContentChanged(content: value));
                          },
                          minLines: 25,
                          maxLines: null,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 13),
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
                        Container(
                            height: height * 0.066,
                            width: width * 0.402,
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
//                            height: height * 0.07,
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
                                  SizedBox(
                                    height: height * 0.0356,
                                    width: width * 0.1361,
                                    child: FittedBox(
                                      child: Text(
                                        ' 갤러리',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                getImage(state);
                              },
                            )),
                        Container(
                          height: height * 0.066,
                          width: width * 0.402,
//                          height: height * 0.07,
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
                                SizedBox(
                                  height: height * 0.0356,
                                  width: width * 0.191,
                                  child: FittedBox(
                                    child: Text(
                                      ' 사진 촬영',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              getCameraImage();
                            },
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
              Container(
                height: width * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? Row(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                              ),
                              _imageWidget(context, index, state),
                            ],
                          )
                        : _imageWidget(context, index, state);
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationButton(
            title: '완료',
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
        _journalCreateBloc.add(ImageSelected(assetList: resultList));
        for (int i = 0; i < resultList.length; i++) {
          ByteData a = await resultList[i].getByteData();
          File file = await writeToFile(a, i);
          _journalCreateBloc.add(AddImageFile(imageFile: file, index: i));
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
    bool isNull = state.imageList[index] == null;
    return Container(
        padding: EdgeInsets.all(5.0),
        height: width*0.3,
        width: width*0.3,
        child: isNull
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 0, 61, 165)),
              ))
            : Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: width * 0.26,
                      width: width * 0.26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: FileImage(
                            state.imageList[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          _journalCreateBloc.add(DeleteImageFile(
                              removedFile: state.imageList[index]));
                        },
                        child: SizedBox(
                          height: width * 0.055,
                          width: width * 0.055,
                          child: FittedBox(
                            child: Icon(
                              Icons.cancel,
                              color: Color(0xFF6F6F6F),
                            ),
                          ),
                        ),
                      )),
                ],
              ));
  }

  showAlertDialog(BuildContext context, JournalCreateState state) {
    // set up the buttons
    Widget cancelButton = GestureDetector(
      child: Text("아니요"),
      onTap: () {
        Navigator.pop(context);
        _journalCreateBloc.add(PopCheckSameDateDialog());
      },
    );
    Widget continueButton = GestureDetector(
      child: Text(
        "네",
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _journalCreateBloc.add(MoveToEdit());
        Navigator.pop(context, false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    BlocProvider<JournalCreateBloc>(
                      create: (context) => JournalCreateBloc()
                        ..add(DateSelected(
                            selectedDate: Timestamp.fromDate(bufferDate)))
                        ..add(PassFid(fid: state.fid))
                        ..add(EditPageLoad()),
                      child: JournalEditScreen(),
                    )));
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
                child: Text('선택한 날짜에 이미 존재하는 일지가 있습니다. 수정하기로 이동하시겠습니까?'),
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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  pickDate(JournalCreateState state) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              DatePickerWidget(
                onConfirm: (date, i) {
                  bufferDate = date;
                  _journalCreateBloc
                      .add(CheckSameDate(date: Timestamp.fromDate(date)));
                  if (state.checkSameDateDialog == false) {
                    _journalCreateBloc.add(
                        DateSelected(selectedDate: Timestamp.fromDate(date)));
                  }
                },
                onCancel: () {
                  _journalCreateBloc.add(CheckSameDate());
                },
                initialDateTime: state.selectedDate.toDate(),
                locale: DateTimePickerLocale.ko,
              ),
            ],
          );
        });
  }
}
