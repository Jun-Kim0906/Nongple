import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SettingBtnPressed extends HomeEvent{
  @override
  String toString()=>'Setting Button Pressed';
}

class BackgroundImgChanged extends HomeEvent{
  String backgroundImg;

  BackgroundImgChanged({@required this.backgroundImg});

  @override
  String toString()=>'Background Image: $backgroundImg';
}