import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

abstract class JournalMainEvent extends Equatable {
  const JournalMainEvent();

  @override
  List<Object> get props => [];
}

class MainPageLoad extends JournalMainEvent{}

class AllPageLoad extends JournalMainEvent{}

class PicturePageLoad extends JournalMainEvent{}

class DetailPageLoad extends JournalMainEvent{
  final bool loadJournal;
  const DetailPageLoad({bool loadJournal}):this.loadJournal=loadJournal??false;
}

class PageLoaded extends JournalMainEvent{}

class GetMainPageJournalPictureList extends JournalMainEvent{}

class GetAllPageJournalList extends JournalMainEvent{
  final Timestamp selectTime;

  const GetAllPageJournalList({@required this.selectTime});

  @override
  String toString() {
    return '''GetAllPageJournalList{
        selectTime: ${selectTime.toDate()},
        ''';
  }
}

class GetDetailPagePictureList extends JournalMainEvent{}

class PassJournal extends JournalMainEvent{
  final Journal journal;

  const PassJournal({@required this.journal});

  @override
  String toString() {
    return 'PassJournal{ journal: $journal}';
  }
}

class PassFacility extends JournalMainEvent{
  final Facility facility;

  const PassFacility({@required this.facility});

  @override
  String toString() {
    return 'PassFacility{ facility: $facility}';
  }
}

class SelectMonthChanged extends JournalMainEvent{
  final Timestamp changedMonth;
  const SelectMonthChanged({@required this.changedMonth});

  @override
  String toString() {
    return 'SelectMonthChanged{changedMonth: ${changedMonth.toDate()}';
  }
}

class DeleteJournal extends JournalMainEvent{
  @override
  String toString() {
    return 'DeleteJournal';
  }
}

class GetAllPicture extends JournalMainEvent{}