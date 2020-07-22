import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


class JournalCreateState {
  final Timestamp selectedDate;
  final bool isDateSeleted;
  final String content;
  final String jid;
  final String fid;
  final List<Asset> assetList;
  final List<File> imageList;

  JournalCreateState({
    @required this.selectedDate,
    @required this.isDateSeleted,
    @required this.content,
    @required this.assetList,
    @required this.imageList,
    @required this.fid,
    @required this.jid,
  });

  factory JournalCreateState.empty(){
    return JournalCreateState(
      selectedDate: null,
      isDateSeleted: false,
      content: '',
      assetList: [],
      imageList: [],
      jid: '',
      fid: '',
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
  }) {
    return JournalCreateState(
      selectedDate: selectedDate ?? this.selectedDate,
      isDateSeleted: isDateSeleted ?? this.isDateSeleted,
      content: content ?? this.content,
      jid: jid ?? this.jid,
      fid: fid ?? this.fid,
      assetList: assetList ?? this.assetList,
      imageList: imageList ?? this.imageList,
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
  }) {
    return copyWith(
      selectedDate: selectedDate ,
      isDateSeleted: isDateSeleted,
      content: content,
      jid: jid,
      fid: fid,
      assetList: assetList,
      imageList: imageList,
    );
  }

  @override
  String toString() {
    return '''JournalMainState{
    selectedDate: $selectedDate,
    isDateSeleted: $isDateSeleted,
    content: $content,
    fid: $fid,
    jid: $jid,
    assetList: $assetList,
    imageList: ${imageList.length},
    }''';
  }
}