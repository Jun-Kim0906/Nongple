import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {

  @override
  AppTab get initialState => AppTab.journal;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
