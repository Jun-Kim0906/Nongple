import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/background/background.dart';

@immutable
class BgState {
  final File imageFile;
  final List<Background> bg;
  final bool editState;
  final bool checkBoxState;

  BgState({
    @required this.imageFile,
    @required this.bg,
    @required this.editState,
    @required this.checkBoxState,
  });

  factory BgState.empty() {
    return BgState(
      imageFile: null,
      bg: [],
      editState: false,
      checkBoxState: false,
    );
  }

  BgState copyWith({
    File imageFile,
    List<Background> bg,
    bool editState,
    bool checkBoxState,
  }) {
    return BgState(
      imageFile: imageFile ?? this.imageFile,
      bg: bg ?? this.bg,
      editState: editState ?? this.editState,
      checkBoxState: checkBoxState ?? this.checkBoxState,
    );
  }

  BgState update({
    File imageFile,
    List<Background> bg,
    bool editState,
    bool checkBoxState,
  }) {
    return copyWith(
      imageFile: imageFile,
      bg: bg,
      editState: editState,
      checkBoxState: checkBoxState,
    );
  }

  @override
  String toString() {
    return '''BgState { 
    imageFile : $imageFile, 
    bg list : ${bg.length},
    editState : $editState,
    checkBoxState : $checkBoxState,
    }''';
  }
}
