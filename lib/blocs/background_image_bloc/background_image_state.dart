import 'dart:io';

import 'package:meta/meta.dart';
import 'package:nongple/models/background/background.dart';

@immutable
class BgState {
  final File imageFile;
  final List<Background> bg;
  final bool editState;
  final bool checkBoxState;
  final List<Background> checkedList;
  final String fid;
  final List<String> checkedListWithBgid;
  final String currentBgUrl;
  final bool isCurrBgDeleted;

  BgState({
    @required this.imageFile,
    @required this.bg,
    @required this.editState,
    @required this.checkBoxState,
    @required this.checkedList,
    @required this.fid,
    @required this.checkedListWithBgid,
    @required this.currentBgUrl,
    @required this.isCurrBgDeleted,
  });

  factory BgState.empty() {
    return BgState(
      imageFile: null,
      bg: [],
      editState: false,
      checkBoxState: false,
      checkedList: [],
      fid: '',
      checkedListWithBgid: [],
      currentBgUrl: '',
      isCurrBgDeleted: false,
    );
  }

  BgState copyWith({
    File imageFile,
    List<Background> bg,
    bool editState,
    bool checkBoxState,
    List<Background> checkedList,
    String fid,
    List<String> checkedListWithBgid,
    String currentBgUrl,
    bool isCurrBgDeleted,
  }) {
    return BgState(
      imageFile: imageFile ?? this.imageFile,
      bg: bg ?? this.bg,
      editState: editState ?? this.editState,
      checkBoxState: checkBoxState ?? this.checkBoxState,
      checkedList: checkedList ?? this.checkedList,
      fid: fid ?? this.fid,
      checkedListWithBgid: checkedListWithBgid ?? this.checkedListWithBgid,
      currentBgUrl: currentBgUrl ?? this.currentBgUrl,
      isCurrBgDeleted: isCurrBgDeleted ?? this.isCurrBgDeleted,
    );
  }

  BgState update({
    File imageFile,
    List<Background> bg,
    bool editState,
    bool checkBoxState,
    List<Background> checkedList,
    String fid,
    List<String> checkedListWithBgid,
    String currentBgUrl,
    bool isCurrBgDeleted,
  }) {
    return copyWith(
      imageFile: imageFile,
      bg: bg,
      editState: editState,
      checkBoxState: checkBoxState,
      checkedList: checkedList,
      fid: fid,
      checkedListWithBgid: checkedListWithBgid,
      currentBgUrl: currentBgUrl,
      isCurrBgDeleted: isCurrBgDeleted,
    );
  }

  @override
  String toString() {
    return '''BgState { 
    imageFile : $imageFile, 
    bg list : ${bg.length},
    editState : $editState,
    checkBoxState : $checkBoxState,
    checkedList : ${checkedList.length},
    fid : $fid,
    checkedListWithBgid, : ${checkedListWithBgid.length},
    currentBgUrl : $currentBgUrl,
    isCurrBgDeleted : $isCurrBgDeleted,
    }''';
  }
}
