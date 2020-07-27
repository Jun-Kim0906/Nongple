
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:http/http.dart'as http;
import 'package:nongple/utils/utils.dart';
import 'package:nongple/models/models.dart';
import 'package:xml2json/xml2json.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState>{
  @override
  DictionaryState get initialState => DictionaryState.empty();

  @override
  Stream<DictionaryState> mapEventToState(DictionaryEvent event) async*{
    if(event is SearchTextChanged){
      yield* _mapSearchTextChangedToState(event.searchText);
    }
  }

  Stream<DictionaryState> _mapSearchTextChangedToState(String searchText) async*{
    final response = await http.get('$equalWord=$searchText');
    if(response.statusCode ==200){
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(response.body);
      var json1 = xml2json.toParker();
      var data = jsonDecode(json1);
      print(data['response']['body']['items']);
    }
    yield state.update(searchText: searchText);
  }
}