import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

class DictionaryState {
  String searchText;
  List<Dictionary> searchedItems;
  String detailContent;

  DictionaryState(
      {@required this.searchText,
      @required this.searchedItems,
      @required this.detailContent});

  factory DictionaryState.empty() {
    return DictionaryState(
      searchText: '',
      searchedItems: [],
      detailContent: '',
    );
  }

  DictionaryState update({
    String searchText,
    String detailContent,
    List<Dictionary> searchedItems,
  }) {
    return copyWith(
      searchText: searchText,
      detailContent: detailContent,
      searchedItems: searchedItems,
    );
  }

  DictionaryState copyWith({
    String searchText,
    String detailContent,
    List<Dictionary> searchedItems,
  }) {
    return DictionaryState(
      searchText: searchText ?? this.searchText,
      detailContent: detailContent ?? this.detailContent,
      searchedItems: searchedItems ?? this.searchedItems,
    );
  }

  @override
  String toString() {
    return '''
    \nDictionaryState{
      searchText: $searchText,
      detailContent: $detailContent,
      searchedItems: $searchedItems,
    }
    ''';
  }
}
