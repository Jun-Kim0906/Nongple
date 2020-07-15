import 'package:flutter/cupertino.dart';

class AddFacilityState {
  final bool firstPageButtonPressed;

  final String facilityName;

  AddFacilityState({
    @required this.firstPageButtonPressed,

    @required this.facilityName
  });

  factory AddFacilityState.empty() {
    return AddFacilityState(
      firstPageButtonPressed: false,

      facilityName: '',
    );
  }

  AddFacilityState copyWith({
    bool firstPageButtonPressed,
    String facilityName,
  }) {
    return AddFacilityState(
      firstPageButtonPressed:
          firstPageButtonPressed ?? this.firstPageButtonPressed,
      facilityName: facilityName ?? this.facilityName,
    );
  }

  AddFacilityState update({
    bool firstPageButtonPressed,
    String facilityName
  }) {
    return copyWith(
      firstPageButtonPressed: firstPageButtonPressed,
      facilityName: facilityName,
    );
  }

  @override
  String toString() {
    return '''AddFacilityState{
    firstPageButtonPressed: $firstPageButtonPressed,
    facilityName: $facilityName,
    ''';
  }
}
