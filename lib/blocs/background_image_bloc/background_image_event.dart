import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BgEvent extends Equatable{
  const BgEvent();

  @override
  List<Object> get props => [];
}

class UpdateBgUrl extends BgEvent{
  final File imageFile;
  const UpdateBgUrl(this.imageFile);

  @override
  List<Object> get props => [imageFile];

  @override
  String toString()=>'UpdateBgUrl { imageFile : $imageFile }';
}

class SaveBgImage extends BgEvent {
  final File imageFile;
  final String fid;
  const SaveBgImage({this.imageFile, this.fid});

  @override
  List<Object> get props => [imageFile, fid];

  @override
  String toString() {
    return 'SaveBgImage { imageFile : $imageFile, fid : $fid }';
  }
}

class GetImageList extends BgEvent {
  final String fid;
  final String currentBgUrl;

  const GetImageList({this.fid, this.currentBgUrl});

  @override
  List<Object> get props => [fid, currentBgUrl];

  @override
  String toString() {
    return 'GetImageList { fid : $fid, currentBgUrl : $currentBgUrl }';
  }
}

class EditImageList extends BgEvent {}

class PressCheckBox extends BgEvent {
  final String bgid;
  final String bgUrl;
  final String fid;
  const PressCheckBox({this.bgid, this.bgUrl, this.fid});

  @override
  List<Object> get props => [bgid, bgUrl, fid];

  @override
  String toString() {
    return '''PressCheckBox { 
    bgid : $bgid, 
    bgUrl : $bgUrl,
    fid : $fid,
    }''';
  }
}

class RevertToInitialState extends BgEvent {}

class DeleteSelectedImage extends BgEvent {}