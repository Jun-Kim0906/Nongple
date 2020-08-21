import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class AddFacilityState {
  final bool isNameValid;
  final bool isAddrValid;
  final bool isCategoryValid;
  final String lng;
  final String lat;

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
      @required this.uid,
      @required this.lat,
      @required this.lng,
      });

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
      lat: '37.553467',
      lng: '126.970794'
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
    String lat,
    String lng,
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
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
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
    String lat,
    String lng,
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
      lat: lat,
      lng: lng,
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
    lat: $lat,
    lng: $lng,
    ''';
  }
}
