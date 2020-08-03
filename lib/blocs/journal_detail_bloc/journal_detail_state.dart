
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class JournalDetailState extends Equatable {
  const JournalDetailState();

  @override
  List<Object> get props => [];
}

class JournalDetailInitialized extends JournalDetailState{}

class DetailArgsUpdated extends JournalDetailState {
  final String jid;
  final Timestamp date;
  final String content;

  const DetailArgsUpdated({this.jid, this.date, this.content});

  @override
  String toString() =>
      'DetailArgsUpdated { jid : $jid, date : $date, content : $content}';
}