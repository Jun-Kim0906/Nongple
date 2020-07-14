import 'package:meta/meta.dart';

@immutable
class HomeState {
  final bool settingBtnPressed;
  final bool customBackgroundImgSelected;
  final String backgroundImg;

  HomeState({
    @required this.settingBtnPressed,
    @required this.customBackgroundImgSelected,
    @required this.backgroundImg,
  });

  factory HomeState.empty() {
    return HomeState(
      settingBtnPressed: false,
      customBackgroundImgSelected: false,
      backgroundImg: "",
    );
  }

  HomeState update({
    bool settingBtnPressed,
    bool customBackgroundImgSelected,
    String backgroundImg,
  }) {
    return copyWith(
      settingBtnPressed: settingBtnPressed,
      customBackgroundImgSelected: customBackgroundImgSelected,
      backgroundImg: backgroundImg,
    );
  }

  HomeState copyWith({
    bool settingBtnPressed,
    bool customBackgroundImgSelected,
    String backgroundImg,
  }) {
    return HomeState(
      settingBtnPressed: settingBtnPressed ?? this.settingBtnPressed,
      customBackgroundImgSelected: customBackgroundImgSelected ?? this.customBackgroundImgSelected,
      backgroundImg: backgroundImg ?? this.backgroundImg,
    );
  }

  @override
  String toString(){
    return '''
    HomeState{
      settingBtnPressed: $settingBtnPressed,
      customBackgroundImgSelected: $customBackgroundImgSelected,
      backgroundImg: $backgroundImg,
    }
    ''';
  }
}
