import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

class RssMainState {
  final List<Journal> journalList;

  RssMainState({
    @required this.journalList,
  });

  factory RssMainState.empty() {
    return RssMainState(
      journalList: [],
    );
  }

  RssMainState copyWith({
    List<Journal> journalList,
  }) {
    return RssMainState(
      journalList: journalList ?? this.journalList,
    );
  }

  RssMainState update({
    List<Journal> journalList,
  }) {
    return copyWith(
      journalList: journalList,
    );
  }

  @override
  String toString() {
    return '''RssMainState{
    journalList: ${journalList.length},
    }''';
  }
}