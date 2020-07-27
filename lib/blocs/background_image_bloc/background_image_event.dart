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