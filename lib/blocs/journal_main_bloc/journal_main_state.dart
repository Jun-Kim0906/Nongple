import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';


class JournalMainState {
  final List<Journal> journalList;
  final List<Picture> pictureList;

  JournalMainState({
    @required this.journalList,
    @required this.pictureList,
  });

  factory JournalMainState.empty(){
    return JournalMainState(
      journalList: [],
      pictureList: [],
    );
  }

  JournalMainState copyWith({
    List<Journal> journalList,
    List<Picture> pictureList,
  }) {
    return JournalMainState(
      journalList: journalList ?? this.journalList,
      pictureList: pictureList ?? this.pictureList,
    );
  }

  JournalMainState update({
    List<Journal> journalList,
    List<Picture> pictureList,
  }) {
    return copyWith(
      journalList: journalList,
      pictureList: pictureList,
    );
  }

  @override
  String toString() {
    return '''JournalMainState{
    journalList: $journalList,
    pictureList: $pictureList,
    }''';
  }
}