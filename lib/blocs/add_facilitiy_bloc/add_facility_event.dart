import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddFacilityEvent extends Equatable{
  const AddFacilityEvent();

  @override
  List<Object> get props => [];
}

class FirstPageButtonPressed extends AddFacilityEvent{
  final String facilityName;

  const FirstPageButtonPressed({@required this.facilityName});

  @override
  String toString() => 'First Page Button Pressed';
}

class FacilityNameChanged extends AddFacilityEvent{
  final String facilityname;
  const FacilityNameChanged({@required this.facilityname});

  @override
  String toString() => 'Facility Name Changed: $facilityname';
}

class SecondPageButtonPressed extends AddFacilityEvent{
  final String facilityAddr;
  const SecondPageButtonPressed({@required this.facilityAddr});

  @override
  String toString() => 'Second Page Button Pressed';
}

class FacilityAddrChanged extends AddFacilityEvent{
  final String facilityAddr;
  const FacilityAddrChanged({@required this.facilityAddr});

  @override
  String toString() => 'Facility Addr Changed: $facilityAddr';
}