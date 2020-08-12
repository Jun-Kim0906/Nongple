import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/rss_list/rss_list.dart';

class RssMainState {
  final List<Rss> suggestion;
  final List<SearchRss> selectedList;
  final List<RssOption> deletedList;
  final List<RssOption> copiedList;
  final List<RssOption> originalList;


  RssMainState({
    @required this.suggestion,
    @required this.selectedList,
    @required this.deletedList,
    @required this.copiedList,
    @required this.originalList,
  });

  factory RssMainState.empty() {
    return RssMainState(
      suggestion: rssHardCoding,
      selectedList: [],
        deletedList: [],
        copiedList: [],
      originalList: [],
    );
  }

  RssMainState copyWith({
    List<Rss> suggestion,
    List<SearchRss> selectedList,
    List<RssOption> deletedList,
    List<RssOption> copiedList,
    List<RssOption> originalList,
  }) {
    return RssMainState(
      suggestion: suggestion ?? this.suggestion,
      selectedList: selectedList ?? this.selectedList,
      deletedList: deletedList ?? this.deletedList,
        copiedList: copiedList ?? this.copiedList,
      originalList: originalList ?? this.originalList,
    );
  }

  RssMainState update({
    List<Rss> suggestion,
    List<SearchRss> selectedList,
    List<RssOption> deletedList,
    List<RssOption> copiedList,
    List<RssOption> originalList,
  }) {
    return copyWith(
      suggestion: suggestion,
      selectedList: selectedList,
      deletedList: deletedList,
        copiedList: copiedList,
      originalList: originalList,
    );
  }

  @override
  String toString() {
    return '''RssMainState{
    suggestion: ${suggestion.length},
    selectedList: ${selectedList.length},
    deletedList: ${deletedList.length},
    copiedList: ${copiedList.length},
    originalList: ${originalList.length},
    }''';
  }
}
