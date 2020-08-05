import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nongple/models/picture/picture.dart';

class JournalCreateState {
  final Timestamp selectedDate;
  final bool isDateSeleted;
  final bool isUploaded;
  final String content;
  final String jid;
  final String fid;
  final List<Asset> assetList;
  final List<File> imageList;
  final List<Picture> copyOfExistingImage; // journal edit screen
  final bool modifyPressed;
  final bool createPressed;

  JournalCreateState({
    @required this.selectedDate,
    @required this.isDateSeleted,
    @required this.content,
    @required this.assetList,
    @required this.imageList,
    @required this.fid,
    @required this.jid,
    @required this.copyOfExistingImage,
    @required this.isUploaded,
    @required this.modifyPressed,
    @required this.createPressed,
  });

  factory JournalCreateState.empty() {
    return JournalCreateState(
      selectedDate: Timestamp.now(),
      isDateSeleted: false,
      content: '',
      assetList: [],
      imageList: [],
      jid: '',
      fid: '',
      copyOfExistingImage: [],
      isUploaded: false,
      modifyPressed: false,
      createPressed: false,
    );
  }

  JournalCreateState copyWith({
    Timestamp selectedDate,
    bool isDateSeleted,
    String content,
    String jid,
    String fid,
    List<Asset> assetList,
    List<File> imageList,
    List<Picture> copyOfExistingImage,
    bool isUploaded,
    bool modifyPressed,
    bool createPressed,
  }) {
    return JournalCreateState(
      selectedDate: selectedDate ?? this.selectedDate,
      isDateSeleted: isDateSeleted ?? this.isDateSeleted,
      content: content ?? this.content,
      jid: jid ?? this.jid,
      fid: fid ?? this.fid,
      assetList: assetList ?? this.assetList,
      imageList: imageList ?? this.imageList,
      copyOfExistingImage: copyOfExistingImage ?? this.copyOfExistingImage,
      isUploaded: isUploaded ?? this.isUploaded,
      modifyPressed: modifyPressed ?? this.modifyPressed,
      createPressed: createPressed ?? this.createPressed,
    );
  }

  JournalCreateState update({
    Timestamp selectedDate,
    bool isDateSeleted,
    String content,
    String fid,
    String jid,
    List<Asset> assetList,
    List<File> imageList,
    List<Picture> copyOfExistingImage,
    bool isUploaded,
    bool modifyPressed,
    bool createPressed,
  }) {
    return copyWith(
      selectedDate: selectedDate,
      isDateSeleted: isDateSeleted,
      content: content,
      jid: jid,
      fid: fid,
      assetList: assetList,
      imageList: imageList,
      copyOfExistingImage: copyOfExistingImage,
      isUploaded: isUploaded,
      modifyPressed: modifyPressed,
      createPressed: createPressed,
    );
  }

  @override
  String toString() {
    return '''JournalCreateState{
    selectedDate: ${selectedDate.toDate()},
    isDateSeleted: $isDateSeleted,
    content: $content,
    fid: $fid,
    jid: $jid,
    assetList: $assetList,
    imageList: ${imageList.length},
    copyOfExistingImage: ${copyOfExistingImage.length},
    isUploaded: $isUploaded,
    createPressed: $createPressed,
    }''';
  }
}
