import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/facility/facility.dart';


@immutable
class HomeState extends Equatable{
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
  String toString()=>'FacilityListSet { facList : ${facList} }';
}


