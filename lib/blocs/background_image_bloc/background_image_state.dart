import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/background/background.dart';

@immutable
class BgState {
  final File imageFile;
  final List<Background> bg;

//  const BgUrlSet({this.imageFile, this.bg});
  BgState({
    @required this.imageFile,
    @required this.bg,
  });

  factory BgState.empty() {
    return BgState(
      imageFile: null,
      bg: [],
    );
  }

  BgState copyWith({
    File imageFile,
    List<Background> bg,
  }) {
    return BgState(
      imageFile: imageFile ?? this.imageFile,
      bg: bg ?? this.bg,
    );
  }

  BgState update({
    File imageFile,
    List<Background> bg,
  }) {
    return copyWith(
      imageFile: imageFile,
      bg: bg,
    );
  }

  @override
  String toString() {
    return '''BgState { 
    imageFile : $imageFile, 
    bg list : ${bg.length},
    }''';
  }
}

//class InitialBgUrl extends BgState{}
//
//class BgUrlSet extends BgState{
//  final File imageFile;
//  final List<Background> bg;
//
////  const BgUrlSet({this.imageFile, this.bg});
//  BgUrlSet({imageFile, bg})
//      : this.imageFile = imageFile ?? null, this.bg = bg ?? [];
//
//  BgUrlSet copyWith({File imageFile, List<Background> bg}) {
//    return BgUrlSet(
//      imageFile: imageFile ?? this.imageFile,
//      bg: bg ?? this.bg,
//    );
//  }
//
//  List<Object> get props => [imageFile, bg];
//
//  @override
//  String toString() {
//    return '''BgUrlSet {
//    imageFile : $imageFile,
//    bg list : ${bg.length},
//    }''';
//  }
//}
