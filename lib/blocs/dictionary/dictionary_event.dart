
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DictionaryEvent extends Equatable{
  const DictionaryEvent();

  @override
  List<Object> get props => [];
}

class SearchTextChanged extends DictionaryEvent{
  final String searchText;

  const SearchTextChanged({@required this.searchText});

  @override
  String toString() {
    return 'SearchTextChanged{ searchText: $searchText }\n';
  }
}

class SearchedItemLoad extends DictionaryEvent{
  final String wordNo;

  const SearchedItemLoad({@required this.wordNo});

  @override
  String toString() => 'SearchedItemLoad { wordNo: $wordNo}';
}

class DetailContentDelete extends DictionaryEvent{
  @override
  String toString() {
    return 'DetailContentDelete';
  }
}

class TextOnSubmitted extends DictionaryEvent{
  final String searchText;
  const TextOnSubmitted({@required this.searchText});

  @override
  String toString() {
    return 'TextOnSubmitted';
  }
}