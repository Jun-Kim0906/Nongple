
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class JournalDetailEvent extends Equatable{
  const JournalDetailEvent();

  @override
  List<Object> get props => [];
}

class SetJournalDetailArgs extends JournalDetailEvent {
  final String jid;
  final Timestamp date;
  final String content;

  const SetJournalDetailArgs(
      {@required this.jid, @required this.date, @required this.content});

  @override
  String toString() =>
      'SetJournalDetailArgs { jid : $jid, date : $date, content : $content}';
}