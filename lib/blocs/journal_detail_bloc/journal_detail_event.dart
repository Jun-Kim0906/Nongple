import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/facility/facility.dart';

abstract class JournalDetailEvent extends Equatable{
  const JournalDetailEvent();

  @override
  List<Object> get props => [];
}

class UpdateJournalDetailPage extends JournalDetailEvent{
  final String jid;
  final Timestamp date;
  final String content;
  final Facility facility;

  const UpdateJournalDetailPage({this.jid, this.date, this.content, this.facility});

  @override
  String toString() =>'UpdateJournalDetailPage { jid : $jid, date : $date, content : $content, facility : $facility }';
}