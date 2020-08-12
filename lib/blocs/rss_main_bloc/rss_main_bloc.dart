import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/data_repository/data_repository.dart';
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
    if (event is GetRss) {
      yield* _mapGetRssToState();
    } else if(event is SelectedRssChanged) {
      yield* _mapSelectedRssChangedToState(event);
    } else if(event is CompleteButtonPressed){
      yield* _mapCompleteButtonPressedToState();
    } else if(event is EditButtonPressed){
      yield* _mapEditButtonPressedToState();
    }
  }

  Stream<RssMainState> _mapGetRssToState() async* {
    List<RssOption> originalList = await RssRepository().loadRss(uid: UserUtil.getUser().uid);

    yield state.update(originalList: originalList);
  }

  Stream<RssMainState> _mapSelectedRssChangedToState (SelectedRssChanged event) async* {
    List<SearchRss> tmpRss = state.selectedList;
    List<RssOption> tmpAddedList = state.addedList;
    List<RssOption> tmpDeletedList = state.deletedList;

    String rid= Firestore.instance.collection('Rss').document().documentID;
    String uid = UserUtil.getUser().uid;

    if (event.isChecked){
      tmpRss.add(SearchRss(name: event.name, option: event.option, url: event.url));
      if(state.originalList.where((element) => element.url == event.url).isEmpty){
        tmpAddedList.add(RssOption(name: event.name, option: event.option, url: event.url, uid: uid, rid: rid));
      }
      tmpDeletedList.removeWhere((element) => element.url == event.url);
    }else{
      tmpRss.removeWhere((element) => element.url == event.url);
      RssOption tmpDelete = tmpAddedList.where((element) => element.url == event.url).single;
      tmpAddedList.removeWhere((element) => element.url == event.url);
      if(state.originalList.where((element) => element.url == event.url).isNotEmpty){
        tmpDeletedList.add(tmpDelete);
      }
    }

    yield state.update(selectedList: tmpRss, addedList: tmpAddedList, deletedList: tmpDeletedList);
  }

  Stream<RssMainState> _mapCompleteButtonPressedToState() async*{
    List<RssOption> addedList  = state.addedList;
    List<RssOption> deletedList = state.deletedList;
    List<RssOption> originalList = state.originalList;

    if (addedList.isNotEmpty) {
       addedList.forEach((element)  {
         RssRepository().uploadRss(
          rss: element
        );
      });
    }
    if(deletedList.isNotEmpty){
       deletedList.forEach((element){
         RssRepository().deleteRss(
          rss: element
        );
      });
    }
    originalList.addAll(addedList);
    deletedList.forEach((delete) {
      originalList.removeWhere((origin) => origin.rid == delete.rid);
    });

    yield state.update(originalList: originalList);
  }

  Stream<RssMainState> _mapEditButtonPressedToState()async*{
    yield state.update(editButtonPressed: !state.editButtonPressed);
  }
}