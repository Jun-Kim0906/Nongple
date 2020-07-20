import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class AddFacilityState {
  final bool isNameValid;
  final bool isAddrValid;
  final bool isCategoryValid;

  final String facilityName;
  final String facilityAddr;
  final int facilityCategory;
  final String fid;
  final String uid;

  AddFacilityState(
      {@required this.isNameValid,
      @required this.isAddrValid,
      @required this.isCategoryValid,
      @required this.facilityName,
      @required this.facilityAddr,
      @required this.facilityCategory,
      @required this.fid,
      @required this.uid});

  factory AddFacilityState.empty() {
    return AddFacilityState(
      isNameValid: false,
      isAddrValid: false,
      isCategoryValid: false,
      facilityName: '',
      facilityAddr: '',
      facilityCategory: 0,
      fid: '',
      uid: '',
    );
  }

  AddFacilityState copyWith({
    bool isNameValid,
    bool isAddrValid,
    bool isCategoryValid,
    String facilityName,
    String facilityAddr,
    int facilityCategory,
    String fid,
    String uid,
  }) {
    return AddFacilityState(
      isNameValid: isNameValid ?? this.isNameValid,
      isAddrValid: isAddrValid ?? this.isAddrValid,
      isCategoryValid: isCategoryValid ?? this.isCategoryValid,
      facilityName: facilityName ?? this.facilityName,
      facilityAddr: facilityAddr ?? this.facilityAddr,
      facilityCategory: facilityCategory ?? this.facilityCategory,
      uid: uid ?? this.uid,
      fid: fid ?? this.fid,
    );
  }

  AddFacilityState update({
    bool isNameValid,
    bool isAddrValid,
    bool isCategoryValid,
    String facilityName,
    String facilityAddr,
    int facilityCategory,
    String fid,
    String uid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isAddrValid: isAddrValid,
      isCategoryValid: isCategoryValid,
      facilityName: facilityName,
      facilityAddr: facilityAddr,
      facilityCategory: facilityCategory,
      uid: uid,
      fid: fid,
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
    uid: $uid,
    fid: $fid,
    ''';
  }
}
