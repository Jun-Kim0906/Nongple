import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/random_id.dart';
import 'package:nongple/utils/user_util/user_util.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class RssMainBloc extends Bloc<RssMainEvent, RssMainState> {
  @override
  RssMainState get initialState => RssMainState.empty();

  @override
  Stream<RssMainState> mapEventToState(event) async* {
    if (event is GetFeed) {
      yield* _mapGetFeedToState();
    } else if(event is SelectedRssChanged) {
      yield* _mapSelectedRssChangedToState(event);
    }
  }

  Stream<RssMainState> _mapGetFeedToState() async* {}

  Stream<RssMainState> _mapSelectedRssChangedToState (SelectedRssChanged event) async* {
    List<SearchRss> tmpRss = state.selectedList;
    List<RssOption> tmpAddedList = state.copiedList;
    List<RssOption> tmpDeletedList = state.deletedList;

    String rid= Firestore.instance.collection('Rss').document().documentID;
    String uid = UserUtil.getUser().uid;

    if (event.isChecked){
      tmpRss.add(SearchRss(name: event.name, option: event.option, url: event.url));
      tmpAddedList.add(RssOption(name: event.name, option: event.option, url: event.url, uid: uid, rid: rid));
      tmpDeletedList.removeWhere((element) => element.url == event.url);
    }else{
      tmpRss.removeWhere((element) => element.url == event.url);
      RssOption tmpDelete = tmpAddedList.where((element) => element.url == event.url).single;
      tmpAddedList.removeWhere((element) => element.url == event.url);
      if(state.originalList.where((element) => element.url == event.url).isNotEmpty){
        tmpDeletedList.add(tmpDelete);
      }
    }

    yield state.update(selectedList: tmpRss, copiedList: tmpAddedList, deletedList: tmpDeletedList);
  }
}