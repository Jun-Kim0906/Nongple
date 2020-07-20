import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/testPage2.dart';

@immutable
class HomeState {
  const HomeState();

  @override
  List<Object> get props => [];
}

class Initial extends HomeState{}

class FacilityListSet extends HomeState{
  final List<Facility> facList;

  const FacilityListSet(this.facList);

  List<Object> get props => [facList];

  @override
  String toString()=>'FacilityListSet { facList : $facList }';
}


