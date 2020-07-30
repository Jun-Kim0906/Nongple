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
  String toString() =>'Get Journal Picture List { fid : $fid }';
}

class AllDateSeleted extends JournalMainEvent{
  final Timestamp selectedDate;
  const AllDateSeleted({@required this.selectedDate});

  @override
  String toString()=>'All Date Seleted {SelectedDate: $selectedDate}';
}

class DeleteAll extends JournalMainEvent {
  final String fid;
  final String jid;
  const DeleteAll({@required this.fid, @required this.jid});

  @override
  String toString() => 'DeleteAll { fid : $fid, jid : $jid }';
}

class CheckSameDate extends JournalMainEvent {
  final Timestamp date;

  const CheckSameDate({@required this.date});

  @override
  String toString() => 'CheckSameDate { date : $date }';
}
