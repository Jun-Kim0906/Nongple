import 'package:flutter/cupertino.dart';

class AddFacilityState {
  final bool firstPageButtonPressed;
  final bool isNameValid;
  final bool secondPageButtonPressed;
  final bool isAddrValid;

  final String facilityName;
  final String facilityAddr;

  AddFacilityState({
    @required this.firstPageButtonPressed,
    @required this.isNameValid,
    @required this.secondPageButtonPressed,
    @required this.isAddrValid,

    @required this.facilityName,
    @required this.facilityAddr,
  });

  factory AddFacilityState.empty() {
    return AddFacilityState(
      firstPageButtonPressed: false,
      isNameValid: false,
      secondPageButtonPressed: false,
      isAddrValid: false,

      facilityName: '',
      facilityAddr: '',
    );
  }

  AddFacilityState copyWith({
    bool firstPageButtonPressed,
    bool isNameValid,
    bool secondPageButtonPressed,
    bool isAddrValid,
    String facilityName,
    String facilityAddr,
  }) {
    return AddFacilityState(
      firstPageButtonPressed:
          firstPageButtonPressed ?? this.firstPageButtonPressed,
      isNameValid: isNameValid ?? this.isNameValid,
      secondPageButtonPressed: secondPageButtonPressed ?? this.secondPageButtonPressed,
      isAddrValid: isAddrValid ?? this.isAddrValid,
      facilityName: facilityName ?? this.facilityName,
      facilityAddr: facilityAddr ?? this.facilityAddr,
    );
  }

  AddFacilityState update({
    bool firstPageButtonPressed,
    bool isNameValid,
    bool secondPageButtonPressed,
    bool isAddrValid,
    String facilityName,
    String facilityAddr,
  }) {
    return copyWith(
      firstPageButtonPressed: firstPageButtonPressed,
      isNameValid: isNameValid,
      secondPageButtonPressed: secondPageButtonPressed,
      isAddrValid: isAddrValid,
      facilityName: facilityName,
      facilityAddr: facilityAddr,
    );
  }

  @override
  String toString() {
    return '''AddFacilityState{
    firstPageButtonPressed: $firstPageButtonPressed,
    isNameValid: $isNameValid,
    secondPageButtonPressed: $secondPageButtonPressed,
    isAddrValid: $isAddrValid,
    facilityName: $facilityName,
    facilityAddr: $facilityAddr,
    ''';
  }
}
