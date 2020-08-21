import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nongple/models/models.dart';

class JournalCreateState {
  final Timestamp selectedDate;
  final String content;
  final String fid;
  final List<Asset> assetList;
  final List<File> imageList;
  final bool dateConfirmed;
  final bool datePickerState;
  final bool checkSameDateDialog;
  final bool createCompletePressed;
  final bool uploadComplete;
  
  ///for Edit Screen
  final List<Picture> existPictureList;
  final List<Picture> removedPictureList;
  final Journal existJournal;
  final bool editPageLoading;
  final bool isLoading;

  ///test

  JournalCreateState({
    @required this.selectedDate,
    @required this.content,
    @required this.fid,
    @required this.assetList,
    @required this.imageList,
    @required this.existPictureList,
    @required this.removedPictureList,
    @required this.dateConfirmed,
    @required this.datePickerState,
    @required this.checkSameDateDialog,
    @required this.createCompletePressed,
    @required this.uploadComplete,
    @required this.editPageLoading,
    @required this.isLoading,
    @required this.existJournal,

  });

  factory JournalCreateState.empty() {
    String month;
    String day;
    if(DateTime.now().month<10){
      month='0${DateTime.now().month}';
    }else{
      month='${DateTime.now().month}';
    }
    if(DateTime.now().day<10){
      day='0${DateTime.now().day}';
    }else{
      day='${DateTime.now().day}';
    }
    return JournalCreateState(
      selectedDate: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.parse('${DateTime.now().year}${month}${day}')
              .millisecondsSinceEpoch),
      content: '',
      fid: '',
      assetList: [],
      imageList: [],
      existPictureList: [],
      removedPictureList: [],
      dateConfirmed: false,
      datePickerState: false,
      checkSameDateDialog: false,
      createCompletePressed: false,
      uploadComplete: false,
      isLoading: false,
      editPageLoading: false,
      existJournal: Journal(content: '',date: Timestamp.now()),
    );
  }

  JournalCreateState copyWith({
    Timestamp selectedDate,
    String content,
    String fid,
    List<Asset> assetList,
    List<File> imageList,
    List<Picture> existPictureList,
    List<Picture> removedPictureList,
    bool dateConfirmed,
    bool datePickerState,
    bool checkSameDateDialog,
    bool createCompletePressed,
    bool uploadComplete,
    bool editPageLoading,
    bool isLoading,
    Journal existJournal,
  }) {
    return JournalCreateState(
      selectedDate: selectedDate ?? this.selectedDate,
      content: content ?? this.content,
      fid: fid ?? this.fid,
      assetList: assetList ?? this.assetList,
      imageList: imageList ?? this.imageList,
      existPictureList: existPictureList ?? this.existPictureList,
      removedPictureList: removedPictureList ?? this.removedPictureList,
      dateConfirmed: dateConfirmed ?? this.dateConfirmed,
      datePickerState: datePickerState ?? this.datePickerState,
      checkSameDateDialog: checkSameDateDialog ?? this.checkSameDateDialog,
      createCompletePressed: createCompletePressed ?? this.createCompletePressed,
      uploadComplete: uploadComplete ?? this.uploadComplete,
      editPageLoading: editPageLoading ?? this.editPageLoading,
      isLoading: isLoading ?? this.isLoading,
      existJournal: existJournal ?? this.existJournal,
    );
  }

  JournalCreateState update({
    Timestamp selectedDate,
    String content,
    String fid,
    List<Asset> assetList,
    List<File> imageList,
    List<Picture> existPictureList,
    List<Picture> removedPictureList,
    bool dateConfirmed,
    bool datePickerState,
    bool checkSameDateDialog,
    bool createCompletePressed,
    bool uploadComplete,
    bool editPageLoading,
    bool isLoading,
    Journal existJournal,
  }) {
    return copyWith(
      selectedDate: selectedDate,
      content: content,
      fid: fid,
      assetList: assetList,
      imageList: imageList,
      existPictureList: existPictureList,
      removedPictureList: removedPictureList,
      dateConfirmed: dateConfirmed,
      datePickerState: datePickerState,
      checkSameDateDialog: checkSameDateDialog,
      createCompletePressed: createCompletePressed,
      uploadComplete: uploadComplete,
      editPageLoading: editPageLoading,
      isLoading: isLoading,
      existJournal: existJournal,
    );
  }

  @override
  String toString() {
    return '''JournalCreateState{
    selectedDate: ${selectedDate.toDate()},
    content: $content,
    fid: $fid,
    assetList: ${assetList.length},
    imageList: ${imageList.length},
    existPictureList: ${existPictureList.length},
    removedPictureList: ${removedPictureList.length},
    dateConfirmed: $dateConfirmed,
    datePickerState: $datePickerState,
    checkSameDateDialog: $checkSameDateDialog,
    createCompletePressed: $createCompletePressed,
    uploadComplete: $uploadComplete,
    editPageLoading: $editPageLoading,
    isLoading: $isLoading,
    }''';
  }
}
