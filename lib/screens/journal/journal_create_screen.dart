import 'dart:io';

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

class JournalCreateScreen extends StatefulWidget {
  final Facility facility;
  final Timestamp date;
  final String content;
  final bool isModify;
  final String jid;

  JournalCreateScreen(
      {this.facility, this.isModify, this.date, this.content, this.jid});

  @override
  _JournalCreateScreenState createState() => _JournalCreateScreenState();
}

class _JournalCreateScreenState extends State<JournalCreateScreen> {
  JournalCreateBloc _journalCreateBloc;
  JournalMainBloc _journalMainBloc;
  double height;
  TextEditingController _contentTextEditingController = TextEditingController();
  TextEditingController _contentTextModifyingController;
  List<Asset> imageList = List<Asset>();

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _journalMainBloc = BlocProvider.of<JournalMainBloc>(context);
    _contentTextModifyingController =
        TextEditingController(text: '${widget.content}');
    _contentTextEditingController.addListener(() {
      _journalCreateBloc
          .add(ContentChanged(content: _contentTextEditingController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
        builder: (context, state) {
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
          title: (widget.isModify == true)
              ? Text('일지수정', style: TextStyle(color: Colors.black))
              : Text('일지작성', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<JournalMainBloc, JournalMainState>(
          builder: (context, mState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      (widget.isModify == true)
                          ? FlatButton(
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
                      )
                          : FlatButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            onConfirm: (date, i) {
                              print('confirm $date');
                              (widget.isModify == true)
                                  ? null
                                  : _journalMainBloc.add(CheckSameDate(
                                  date: Timestamp.fromDate(date)));
                              if (mState.isSameDate == true) {
                                showAlertDialog(context);
                              } else {
                                _journalCreateBloc.add(DateSeleted(
                                    selectedDate: Timestamp.fromDate(date)));
                              }
                            },
                            initialDateTime: state.selectedDate.toDate(),
                            locale: DateTimePickerLocale.ko,
                            onClose: () => print("----- onClose -----"),
                            onCancel: () => print('onCancel'),
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
                            controller: (widget.isModify == true)
                                ? _contentTextModifyingController
                                : _contentTextEditingController,
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
            );
          },
        ),
        bottomNavigationBar: BottomNavigationButton(
          title: (widget.isModify == true) ? '수정' : '완료',
          onPressed: () {
            if (widget.isModify == true) {
              _journalCreateBloc.add(ContentChanged(
                  content: _contentTextModifyingController.text));
              _journalCreateBloc.add(DateSeleted(selectedDate: widget.date));
              _journalCreateBloc.add(
                  UpdateJournal(fid: widget.facility.fid, jid: widget.jid));
            } else {
              _journalCreateBloc.add(UploadJournal(fid: widget.facility.fid));
            }
            Navigator.pop(context);
          },
        ),
      );
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

  showAlertDialog(BuildContext context) {
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    BlocProvider.value(
                      value: _journalCreateBloc
                        ..add(
                            DateSeleted(selectedDate: widget.date)),
                      child: JournalCreateScreen(
                        facility: widget.facility,
                        isModify: true,
                        date: widget.date,
                        content: widget.content,
                        jid: widget.jid,
                      ),
                    ))).then((value) => _journalMainBloc
          ..add(GetJournalPictureList(fid: widget.facility.fid))
          ..add(AllDateSeleted(selectedDate: widget.date)));
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
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
