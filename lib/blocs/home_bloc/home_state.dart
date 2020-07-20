import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/testPage2.dart';

@immutable
class HomeState {
  const HomeState();

  @override
  List<Object> get props => [];
//  final bool settingBtnPressed;
//  final bool customBackgroundImgSelected;
//  final String backgroundImg;
//
//  HomeState({
//    @required this.settingBtnPressed,
//    @required this.customBackgroundImgSelected,
//    @required this.backgroundImg,
//  });
//
//  factory HomeState.empty() {
//    return HomeState(
//      settingBtnPressed: false,
//      customBackgroundImgSelected: false,
//      backgroundImg: "",
//    );
//  }
//
//  HomeState update({
//    bool settingBtnPressed,
//    bool customBackgroundImgSelected,
//    String backgroundImg,
//  }) {
//    return copyWith(
//      settingBtnPressed: settingBtnPressed,
//      customBackgroundImgSelected: customBackgroundImgSelected,
//      backgroundImg: backgroundImg,
//    );
//  }
//
//  HomeState copyWith({
//    bool settingBtnPressed,
//    bool customBackgroundImgSelected,
//    String backgroundImg,
//  }) {
//    return HomeState(
//      settingBtnPressed: settingBtnPressed ?? this.settingBtnPressed,
//      customBackgroundImgSelected: customBackgroundImgSelected ?? this.customBackgroundImgSelected,
//      backgroundImg: backgroundImg ?? this.backgroundImg,
//    );
//  }
//
//  @override
//  String toString(){
//    return '''
//    HomeState{
//      settingBtnPressed: $settingBtnPressed,
//      customBackgroundImgSelected: $customBackgroundImgSelected,
//      backgroundImg: $backgroundImg,
//    }
//    ''';
//  }
}

class Initial extends HomeState{}

class FacilityListSet extends HomeState{
  final List<Facility> facList;

  const FacilityListSet(this.facList);

  List<Object> get props => [facList];

  @override
  String toString()=>'FacilityListSet { facList : $facList }';
}


