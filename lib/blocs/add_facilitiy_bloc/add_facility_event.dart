import 'package:equatable/equatable.dart';

abstract class AddFacilityEvent extends Equatable{
  const AddFacilityEvent();

  @override
  List<Object> get props => [];
}

class FirstPageButtonPressed extends AddFacilityEvent{
  final String facilityName;

  FirstPageButtonPressed(this.facilityName);

  @override
  String toString() => 'First Page Button Pressed';
}