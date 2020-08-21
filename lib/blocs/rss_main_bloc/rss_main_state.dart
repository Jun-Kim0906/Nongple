import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/rss_list/rss_list.dart';

class RssMainState {
  final List<Rss> suggestion;
  final List<SearchRss> selectedList;
  final List<RssOption> deletedList;
  final List<RssOption> addedList;
  final List<RssOption> originalList;
  final String search;

  final bool editButtonPressed;
  final bool isLoading;
  final bool isMainPageLoading;

  RssMainState({
    @required this.suggestion,
    @required this.selectedList,
    @required this.deletedList,
    @required this.addedList,
    @required this.originalList,
    @required this.editButtonPressed,
    @required this.search,
    @required this.isLoading,
    @required this.isMainPageLoading,
  });

  factory RssMainState.empty() {
    return RssMainState(
      suggestion: rssHardCoding,
      selectedList: [],
      deletedList: [],
      addedList: [],
      originalList: [],
      search: '',
      editButtonPressed: false,
      isLoading: false,
      isMainPageLoading: false,
    );
  }

  RssMainState copyWith({
    List<Rss> suggestion,
    List<SearchRss> selectedList,
    List<RssOption> deletedList,
    List<RssOption> addedList,
    List<RssOption> originalList,
    String search,
    bool editButtonPressed,
    bool isLoading,
    bool isMainPageLoading,
  }) {
    return RssMainState(
      suggestion: suggestion ?? this.suggestion,
      selectedList: selectedList ?? this.selectedList,
      deletedList: deletedList ?? this.deletedList,
      addedList: addedList ?? this.addedList,
      originalList: originalList ?? this.originalList,
      search: search?? this.search,
      editButtonPressed: editButtonPressed ?? this.editButtonPressed,
      isLoading: isLoading ?? this.isLoading,
      isMainPageLoading: isMainPageLoading ?? this.isMainPageLoading,
    );
  }

  RssMainState update({
    List<Rss> suggestion,
    List<SearchRss> selectedList,
    List<RssOption> deletedList,
    List<RssOption> addedList,
    List<RssOption> originalList,
    String search,
    bool editButtonPressed,
    bool isLoading,
    bool isMainPageLoading,
  }) {
    return copyWith(
      suggestion: suggestion,
      selectedList: selectedList,
      deletedList: deletedList,
      addedList: addedList,
      originalList: originalList,
      search: search,
      editButtonPressed: editButtonPressed,
      isLoading: isLoading,
      isMainPageLoading: isMainPageLoading,
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
    search: $search,
    editButtonPressed: $editButtonPressed,
    isLoading: $isLoading,
    isMainPageLoading: $isMainPageLoading,
    }''';
  }
}
