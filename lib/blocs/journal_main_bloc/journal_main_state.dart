import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

class JournalMainState {
  final List<Journal> journalList;
  final List<Picture> pictureList;
  final List<Journal> monthJournalList;
  final Timestamp selectedDate;
  final bool isSameDate;
  final bool isLoaded;

  JournalMainState({
    @required this.journalList,
    @required this.pictureList,
    @required this.selectedDate,
    @required this.monthJournalList,
    @required this.isSameDate,
    @required this.isLoaded,
  });

  factory JournalMainState.empty() {
    return JournalMainState(
      journalList: [],
      pictureList: [],
      selectedDate: Timestamp.now(),
      monthJournalList: [],
      isSameDate: false,
      isLoaded: false,
    );
  }

  JournalMainState copyWith({
    List<Journal> journalList,
    List<Picture> pictureList,
    Timestamp selectedDate,
    List<Journal> monthJournalList,
    bool isSameDate,
    bool isLoaded,
  }) {
    return JournalMainState(
      journalList: journalList ?? this.journalList,
      pictureList: pictureList ?? this.pictureList,
      selectedDate: selectedDate ?? this.selectedDate,
      monthJournalList: monthJournalList ?? this.monthJournalList,
      isSameDate: isSameDate ?? this.isSameDate,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  JournalMainState update({
    List<Journal> journalList,
    List<Picture> pictureList,
    Timestamp selectedDate,
    List<Journal> monthJournalList,
    bool isSameDate,
    bool isLoaded,
  }) {
    return copyWith(
      journalList: journalList,
      pictureList: pictureList,
      selectedDate: selectedDate,
      monthJournalList: monthJournalList,
      isSameDate: isSameDate,
      isLoaded: isLoaded,
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
    isLoaded: $isLoaded,
    }''';
  }
}

class JournalMainStateLoading extends JournalMainState{}
