import 'package:flutter/cupertino.dart';

class AddFacilityState {
  final bool isNameValid;
  final bool isAddrValid;
  final bool isCategoryValid;

  final String facilityName;
  final String facilityAddr;
  final int facilityCategory;

  AddFacilityState({
    @required this.isNameValid,
    @required this.isAddrValid,
    @required this.isCategoryValid,
    @required this.facilityName,
    @required this.facilityAddr,
    @required this.facilityCategory,
  });

  factory AddFacilityState.empty() {
    return AddFacilityState(
      isNameValid: false,
      isAddrValid: false,
      isCategoryValid: false,
      facilityName: '',
      facilityAddr: '',
      facilityCategory: 0,
    );
  }

  AddFacilityState copyWith({
    bool isNameValid,
    bool isAddrValid,
    bool isCategoryValid,
    String facilityName,
    String facilityAddr,
    int facilityCategory,
  }) {
    return AddFacilityState(
      isNameValid: isNameValid ?? this.isNameValid,
      isAddrValid: isAddrValid ?? this.isAddrValid,
      isCategoryValid: isCategoryValid ?? this.isCategoryValid,
      facilityName: facilityName ?? this.facilityName,
      facilityAddr: facilityAddr ?? this.facilityAddr,
      facilityCategory: facilityCategory ?? this.facilityCategory,
    );
  }

  AddFacilityState update({
    bool isNameValid,
    bool isAddrValid,
    bool isCategoryValid,
    String facilityName,
    String facilityAddr,
    int facilityCategory,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isAddrValid: isAddrValid,
      isCategoryValid: isCategoryValid,
      facilityName: facilityName,
      facilityAddr: facilityAddr,
      facilityCategory: facilityCategory,
    );
  }

  @override
  String toString() {
    return '''AddFacilityState{
    isNameValid: $isNameValid,
    isAddrValid: $isAddrValid,
    isCategoryValid: $isCategoryValid,
    facilityName: $facilityName,
    facilityAddr: $facilityAddr,
    facilityCategory: $facilityCategory,
    ''';
  }
}
