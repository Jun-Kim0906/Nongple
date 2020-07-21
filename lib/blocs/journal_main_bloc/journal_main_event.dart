import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class JournalMainEvent extends Equatable{
  const JournalMainEvent();

  @override
  List<Object> get props => [];
}

class GetJournalList extends JournalMainEvent{
  final String fid;
  const GetJournalList({@required this.fid});

  @override
  String toString() =>'Journal fid : $fid';
}

class DateSeleted extends JournalMainEvent{
  final Timestamp selectedDate;
  const DateSeleted({@required this.selectedDate});

  @override
  String toString()=>'SelectedDate: $selectedDate';
}

class ContentChanged extends JournalMainEvent{
  final String content;
  const ContentChanged({@required this.content});

  @override
  String toString() =>'content: $content';
}