import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/data_repository/data_repository.dart';
import 'package:nongple/utils/rss_list/rss_list.dart';
import 'package:nongple/utils/user_util/user_util.dart';

class RssMainBloc extends Bloc<RssMainEvent, RssMainState> {
  @override
  RssMainState get initialState => RssMainState.empty();

  @override
  Stream<RssMainState> mapEventToState(event) async* {
    if (event is GetRss) {
      yield* _mapGetRssToState();
    } else if (event is SelectedRssChanged) {
      yield* _mapSelectedRssChangedToState(event);
    } else if (event is CompleteButtonPressed) {
      yield* _mapCompleteButtonPressedToState();
    } else if (event is EditButtonPressed) {
      yield* _mapEditButtonPressedToState();
    } else if (event is DeleteRss) {
      yield* _mapDeleteRssToState(event.deleteRss);
    } else if (event is MoveToAddPage) {
      yield* _mapMoveToAddPageToState();
    } else if (event is SearchOnChanged) {
      yield* _mapSearchOnChangedToState(event.search);
    } else if (event is LoadRssPage) {
      yield* _mapLoadRssPageToState();
    } else if (event is RssPageLoaded) {
      yield* _mapRssPageLoadedToState();
    }
  }

  Stream<RssMainState> _mapGetRssToState() async* {
    List<RssOption> originalList =
        await RssRepository().loadRss(uid: UserUtil.getUser().uid);

    yield state.update(originalList: originalList, isLoading: false);
  }

  Stream<RssMainState> _mapSelectedRssChangedToState(
      SelectedRssChanged event) async* {
    List<SearchRss> tmpRss = state.selectedList;
    List<RssOption> tmpAddedList = state.addedList;
    List<RssOption> tmpDeletedList = state.deletedList;

    String rid = Firestore.instance.collection('Rss').document().documentID;
    String uid = UserUtil.getUser().uid;

    if (event.isChecked) {
      tmpRss.add(
          SearchRss(name: event.name, option: event.option, url: event.url));
      if (state.originalList
          .where((element) => element.url == event.url)
          .isEmpty) {
        tmpAddedList.add(RssOption(
            name: event.name,
            option: event.option,
            url: event.url,
            uid: uid,
            rid: rid));
      }
      tmpDeletedList.removeWhere((element) => element.url == event.url);
    } else {
      tmpRss.removeWhere((element) => element.url == event.url);
      tmpAddedList.removeWhere((element) => element.url == event.url);
      if (state.originalList
          .where((element) => element.url == event.url)
          .isNotEmpty) {
        RssOption tmpDelete = state.originalList
            .where((element) => element.url == event.url)
            .single;
        tmpDeletedList.add(tmpDelete);
      }
    }

    yield state.update(
        selectedList: tmpRss,
        addedList: tmpAddedList,
        deletedList: tmpDeletedList);
  }

  Stream<RssMainState> _mapCompleteButtonPressedToState() async* {
    List<RssOption> addedList = state.addedList;
    List<RssOption> deletedList = state.deletedList;
    List<RssOption> originalList = state.originalList;

    if (addedList.isNotEmpty) {
      addedList.forEach((element) {
        RssRepository().uploadRss(rss: element);
      });
    }
    if (deletedList.isNotEmpty) {
      deletedList.forEach((element) {
        RssRepository().deleteRss(rss: element);
      });
    }
    originalList.addAll(addedList);
    deletedList.forEach((delete) {
      originalList.removeWhere((origin) => origin.rid == delete.rid);
    });

    yield state.update(originalList: originalList);
  }

  Stream<RssMainState> _mapEditButtonPressedToState() async* {
    yield state.update(editButtonPressed: !state.editButtonPressed);
  }

  Stream<RssMainState> _mapDeleteRssToState(RssOption deleteRss) async* {
    List<RssOption> originalList = state.originalList;

    originalList.removeWhere((element) => element.rid == deleteRss.rid);

    RssRepository().deleteRss(rss: deleteRss);

    yield state.update(originalList: originalList);
  }

  Stream<RssMainState> _mapMoveToAddPageToState() async* {
    List<RssOption> del = state.deletedList;
    List<RssOption> add = state.addedList;
    List<RssOption> originalList = state.originalList;
    List<SearchRss> selectedList = [];

    del.clear();
    add.clear();

    originalList.forEach((element) {
      selectedList.add(SearchRss(
          name: element.name, option: element.option, url: element.url));
    });

    yield state.update(
        deletedList: del,
        addedList: add,
        selectedList: selectedList,
        suggestion: rssHardCoding,
        editButtonPressed: false);
  }

  Stream<RssMainState> _mapSearchOnChangedToState(String search) async* {
    List<Rss> rssList = [];

    if (search.isEmpty) {
      rssList = rssHardCoding;
    } else {
      rssList = rssHardCoding
          .where((element) => element.name.contains(search))
          .toList();
    }
    yield state.update(search: search, suggestion: rssList);
  }

  Stream<RssMainState> _mapLoadRssPageToState() async* {
    yield state.update(isLoading: true, isMainPageLoading: true);
  }

  Stream<RssMainState> _mapRssPageLoadedToState() async* {
    yield state.update(isMainPageLoading: false);
  }
}
