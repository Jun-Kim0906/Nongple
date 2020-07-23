import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class JournalMainEvent extends Equatable{
  const JournalMainEvent();

  @override
  List<Object> get props => [];
}

class GetJournalPictureList extends JournalMainEvent{
  final String fid;
  const GetJournalPictureList({@required this.fid});

  @override
  String toString() =>'fid : $fid';
}

class AllDateSeleted extends JournalMainEvent{
  final Timestamp selectedDate;
  const AllDateSeleted({@required this.selectedDate});

  @override
  String toString()=>'SelectedDate: $selectedDate';
}