import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddFacilityEvent extends Equatable{
  const AddFacilityEvent();

  @override
  List<Object> get props => [];
}

class FacilityNameChanged extends AddFacilityEvent{
  final String facilityname;
  const FacilityNameChanged({@required this.facilityname});

  @override
  String toString() => 'Facility Name Changed: $facilityname';
}


class FacilityAddrChanged extends AddFacilityEvent{
  final String facilityAddr;
  const FacilityAddrChanged({@required this.facilityAddr});

  @override
  String toString() => 'Facility Addr Changed: $facilityAddr';
}

class FacilityCategoryChanged extends AddFacilityEvent{
  final int facilityCategory;
  const FacilityCategoryChanged({@required this.facilityCategory});

  @override
  String toString() => 'Facility Category Changed: $facilityCategory';
}

class FacilityUpload extends AddFacilityEvent{}