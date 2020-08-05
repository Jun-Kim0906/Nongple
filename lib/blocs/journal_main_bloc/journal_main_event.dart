import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/models/picture/picture.dart';

abstract class JournalMainEvent extends Equatable {
  const JournalMainEvent();

  @override
  List<Object> get props => [];
}

class GetJournalPictureList extends JournalMainEvent {
  final String fid;

  const GetJournalPictureList({@required this.fid});

  @override
  String toString() => 'Get Journal Picture List { fid : $fid }';
}

class AllDateSeleted extends JournalMainEvent {
  final Timestamp selectedDate;

  const AllDateSeleted({@required this.selectedDate});

  @override
  String toString() => 'All Date Seleted {SelectedDate: $selectedDate}';
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

class OnLoading extends JournalMainEvent {
  @override
  String toString() => 'OnLoading';
}

class DeleteOnlyPicture extends JournalMainEvent {
  final List<Picture> deleteList;

  const DeleteOnlyPicture({@required this.deleteList});

  @override
  String toString() => 'DeleteOnlyPicture { deleteList : $deleteList }';
}

class LoadJournal extends JournalMainEvent {}

class PassFacilityItemToJournal extends JournalMainEvent {
  final Facility facility;

  const PassFacilityItemToJournal({@required this.facility});

  @override
  String toString() =>
      'PassFacilityItemToJournal { facility : ${facility.fid} }';
}

class PassJournalDetailArgs extends JournalMainEvent {
  final String jid;
  final Timestamp date;
  final String content;
  final List<Picture> image;

  const PassJournalDetailArgs({
    @required this.jid,
    @required this.date,
    @required this.content,
    @required this.image,
  });

  @override
  String toString() =>
      'PassJournalDetailArgs { jid : $jid, date : $date, content : $content, image : ${image.length}';
}

class ShowDialog extends JournalMainEvent {}

class HideDialog extends JournalMainEvent {}

class SetAsContentLoaded extends JournalMainEvent {}

class EndLoading extends JournalMainEvent {}

class SetModifyState extends JournalMainEvent {}
