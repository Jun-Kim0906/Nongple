import 'package:meta/meta.dart';

class DictionaryState {
  String searchText;

  DictionaryState({@required this.searchText});

  factory DictionaryState.empty() {
    return DictionaryState(
      searchText: '',
    );
  }

  DictionaryState update({
    String searchText,
  }) {
    return copyWith(
      searchText: searchText,
    );
  }

  DictionaryState copyWith({
    String searchText,
  }) {
    return DictionaryState(
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  String toString() {
    return '''
    \nDictionaryState{
      searchText: $searchText,
    }
    ''';
  }
}
