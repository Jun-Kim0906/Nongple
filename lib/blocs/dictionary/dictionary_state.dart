import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

class DictionaryState {
  String searchText;
  List<Dictionary> searchedItems;
  String detailContent;
  bool searching;
  bool detailLoading;

  DictionaryState(
      {@required this.searchText,
      @required this.searchedItems,
      @required this.detailContent,
      @required this.searching,
        @required this.detailLoading,
      });

  factory DictionaryState.empty() {
    return DictionaryState(
      searchText: '',
      searchedItems: [],
      detailContent: '',
      searching: false,
      detailLoading: false,
    );
  }

  DictionaryState update({
    String searchText,
    String detailContent,
    List<Dictionary> searchedItems,
    bool searching,
    bool detailLoading,
  }) {
    return copyWith(
      searchText: searchText,
      detailContent: detailContent,
      searchedItems: searchedItems,
      searching: searching,
        detailLoading: detailLoading,
    );
  }

  DictionaryState copyWith({
    String searchText,
    String detailContent,
    List<Dictionary> searchedItems,
    bool searching,
    bool detailLoading,
  }) {
    return DictionaryState(
      searchText: searchText ?? this.searchText,
      detailContent: detailContent ?? this.detailContent,
      searchedItems: searchedItems ?? this.searchedItems,
      searching: searching ?? this.searching,
        detailLoading: detailLoading ?? this.detailLoading,
    );
  }

  @override
  String toString() {
    return '''
    \nDictionaryState{
      searchText: $searchText,
      detailContent: $detailContent,
      searchedItems: $searchedItems,
      searching: $searching,
      detailLoading:$detailLoading,
    }
    ''';
  }
}
