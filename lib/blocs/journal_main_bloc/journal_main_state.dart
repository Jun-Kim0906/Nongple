import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';


class JournalMainState {
  final List<Journal> journalList;

  JournalMainState({
    @required this.journalList,
  });

  factory JournalMainState.empty(){
    return JournalMainState(
      journalList: [],
    );
  }

  JournalMainState copyWith({
  List<Journal> journalList,
}) {
    return JournalMainState(
      journalList: journalList,
    );
  }
  JournalMainState update({
  List<Journal> journalList,
}){
    return copyWith(
      journalList: journalList,
    );
  }

  @override
  String toString() {
    return '''JournalMainState{
    journalList: $journalList,
    }''';
  }
}