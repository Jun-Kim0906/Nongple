import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nongple/utils/utils.dart';
import 'package:nongple/models/models.dart';
import 'package:xml2json/xml2json.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  @override
  DictionaryState get initialState => DictionaryState.empty();

  @override
  Stream<DictionaryState> mapEventToState(DictionaryEvent event) async* {
    if (event is SearchTextChanged) {
      yield* _mapSearchTextChangedToState(event.searchText);
    } else if (event is SearchedItemLoad) {
      yield* _mapSearchedItemLoadToState(event.wordNo);
    } else if (event is DetailContentDelete) {
      yield* _mapDetailContentDelete();
    } else if (event is TextOnSubmitted) {
      yield* _mapTextOnSubmittedToState(event.searchText);
    }
  }

  Stream<DictionaryState> _mapSearchTextChangedToState(
      String searchText) async* {
    yield state.update(searchText: searchText);
  }

  Stream<DictionaryState> _mapSearchedItemLoadToState(String wordNo) async* {
    http.Response response = await http.get('$detailWord=$wordNo');
    String content = "";
    try {
      if (response.statusCode == 200) {
        Xml2Json myTransformer = Xml2Json();
        myTransformer.parse(response.body);
        var jsondata2 = myTransformer.toParker();
        Map<String, dynamic> data = json.decode(jsondata2);
        content = data["response"]["body"]["item"]["wordDc"];
      }
    } catch (e) {
      print("response error : $e");
    } finally {
      yield state.update(detailContent: content);
    }
  }

  Stream<DictionaryState> _mapDetailContentDelete() async* {
    yield state.update(detailContent: '');
  }

  Stream<DictionaryState> _mapTextOnSubmittedToState(String searchText) async* {
    List<Dictionary> dicTempList = [];
    final response = await http.get('$equalWord=$searchText');
    try {
      if (response.statusCode == 200) {
        Xml2Json xml2json = Xml2Json();
        xml2json.parse(response.body);
        var json1 = xml2json.toParker();
        var data = jsonDecode(json1);
        print(data['response']['body']['items']['item']);
        if (data['response']['body']['items']['item'].runtimeType.toString() ==
            "List<dynamic>") {
          List<dynamic> matchData = data["response"]["body"]["items"]["item"];
          matchData.forEach((js) async {
            Dictionary temp = Dictionary.fromJson(js);
            dicTempList.add(temp);
          });
        } else {
          Dictionary temp =
              Dictionary.fromJson(data["response"]["body"]["items"]["item"]);
          dicTempList.add(temp);
        }

        http.Response response2 = await http.get('$frontMatch=$searchText');
        if (response2.statusCode == 200) {
          Xml2Json myTransformer = Xml2Json();
          myTransformer.parse(response2.body);
          var jsondata2 = myTransformer.toParker();

          Map<String, dynamic> data = json.decode(jsondata2);
          List<dynamic> allData = data["response"]["body"]["items"]["item"];
          allData.forEach((ds) {
            dicTempList.add(Dictionary.fromJson(ds));
          });
        }
      }
    } catch (e) {
      print(e);
    } finally {
      yield state.update(searchedItems: dicTempList);
    }
  }
}
