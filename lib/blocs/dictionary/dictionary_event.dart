
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