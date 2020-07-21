import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';


class JournalMainState {
  final List<Journal> journalList;
  final Timestamp selectedDate;
  final bool isDateSeleted;
  final String content;

  JournalMainState({
    @required this.journalList,
    @required this.selectedDate,
    @required this.isDateSeleted,
    @required this.content,
  });

  factory JournalMainState.empty(){
    return JournalMainState(
      journalList: [],
      selectedDate: null,
      isDateSeleted: false,
      content: '',
    );
  }

  JournalMainState copyWith({
    List<Journal> journalList,
    Timestamp selectedDate,
    bool isDateSeleted,
    String content
  }) {
    return JournalMainState(
      journalList: journalList ?? this.journalList,
      selectedDate: selectedDate ?? this.selectedDate,
      isDateSeleted: isDateSeleted ?? this.isDateSeleted,
      content: content ?? this.content,
    );
  }

  JournalMainState update({
    List<Journal> journalList,
    Timestamp selectedDate,
    bool isDateSeleted,
    String content,
  }) {
    return copyWith(
      journalList: journalList,
      selectedDate: selectedDate ,
      isDateSeleted: isDateSeleted,
      content: content,
    );
  }

  @override
  String toString() {
    return '''JournalMainState{
    journalList: $journalList,
    selectedDate: $selectedDate,
    isDateSeleted: $isDateSeleted,
    content: $content,
    }''';
  }
}