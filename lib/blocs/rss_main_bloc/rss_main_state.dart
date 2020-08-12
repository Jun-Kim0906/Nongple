import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/rss_list/rss_list.dart';

class RssMainState {
  final List<Rss> suggestion;
  final List<SearchRss> selectedList;
  final List<RssOption> deletedList;
  final List<RssOption> addedList;
  final List<RssOption> originalList;

  final bool editButtonPressed;

  RssMainState({
    @required this.suggestion,
    @required this.selectedList,
    @required this.deletedList,
    @required this.addedList,
    @required this.originalList,
    @required this.editButtonPressed,
  });

  factory RssMainState.empty() {
    return RssMainState(
      suggestion: rssHardCoding,
      selectedList: [],
      deletedList: [],
      addedList: [],
      originalList: [],
      editButtonPressed: false,
    );
  }

  RssMainState copyWith({
    List<Rss> suggestion,
    List<SearchRss> selectedList,
    List<RssOption> deletedList,
    List<RssOption> addedList,
    List<RssOption> originalList,
    bool editButtonPressed,
  }) {
    return RssMainState(
      suggestion: suggestion ?? this.suggestion,
      selectedList: selectedList ?? this.selectedList,
      deletedList: deletedList ?? this.deletedList,
      addedList: addedList ?? this.addedList,
      originalList: originalList ?? this.originalList,
      editButtonPressed: editButtonPressed ?? this.editButtonPressed,
    );
  }

  RssMainState update({
    List<Rss> suggestion,
    List<SearchRss> selectedList,
    List<RssOption> deletedList,
    List<RssOption> addedList,
    List<RssOption> originalList,
    bool editButtonPressed,
  }) {
    return copyWith(
      suggestion: suggestion,
      selectedList: selectedList,
      deletedList: deletedList,
      addedList: addedList,
      originalList: originalList,
      editButtonPressed: editButtonPressed,
    );
  }

  @override
  String toString() {
    return '''RssMainState{
    suggestion: ${suggestion.length},
    selectedList: ${selectedList.length},
    deletedList: ${deletedList.length},
    addedList: ${addedList.length},
    originalList: ${originalList.length},
    editButtonPressed: $editButtonPressed,
    }''';
  }
}
