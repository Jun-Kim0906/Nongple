import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ListLoading extends HomeEvent{}

class GetFacilityList extends HomeEvent{}

class DeleteFacility extends HomeEvent {
  final String fid;
  const DeleteFacility({this.fid});

  List<Object> get props => [fid];

  @override
  String toString() {
    return '''DeleteFacility { 
    fid : $fid,
    }''';
  }
}