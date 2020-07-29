import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

class JournalMainState {
  final List<Journal> journalList;
  final List<Picture> pictureList;
  final List<Journal> monthJournalList;
  final Timestamp selectedDate;
  final bool isSameDate;

  JournalMainState({
    @required this.journalList,
    @required this.pictureList,
    @required this.selectedDate,
    @required this.monthJournalList,
    @required this.isSameDate,
  });

  factory JournalMainState.empty() {
    return JournalMainState(
      journalList: [],
      pictureList: [],
      selectedDate: Timestamp.now(),
      monthJournalList: [],
      isSameDate: false,
    );
  }

  JournalMainState copyWith({
    List<Journal> journalList,
    List<Picture> pictureList,
    Timestamp selectedDate,
    List<Journal> monthJournalList,
    bool isSameDate,
  }) {
    return JournalMainState(
      journalList: journalList ?? this.journalList,
      pictureList: pictureList ?? this.pictureList,
      selectedDate: selectedDate ?? this.selectedDate,
      monthJournalList: monthJournalList ?? this.monthJournalList,
      isSameDate: isSameDate ?? this.isSameDate,
    );
  }

  JournalMainState update({
    List<Journal> journalList,
    List<Picture> pictureList,
    Timestamp selectedDate,
    List<Journal> monthJournalList,
    bool isSameDate,
  }) {
    return copyWith(
      journalList: journalList,
      pictureList: pictureList,
      selectedDate: selectedDate,
      monthJournalList: monthJournalList,
      isSameDate: isSameDate,
    );
  }

  @override
  String toString() {
    return '''JournalMainState{
    journalList: $journalList,
    pictureList: $pictureList,
    selectedDate: $selectedDate,
    monthJournalList: $monthJournalList,
    isSameDate: $isSameDate,
    }''';
  }
}
