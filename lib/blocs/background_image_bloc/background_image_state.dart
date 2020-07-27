
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
class BgState extends Equatable{
  const BgState();

  @override
  List<Object> get props => [];
}

class InitialBgUrl extends BgState{}

class BgUrlSet extends BgState{
  final File imageFile;

  const BgUrlSet(this.imageFile);

  List<Object> get props => [imageFile];

  @override
  String toString()=>'BgUrlSet { imageFile : $imageFile }';
}