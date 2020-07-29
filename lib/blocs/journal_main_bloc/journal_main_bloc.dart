import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/models/models.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';

class JournalMainBloc extends Bloc<JournalMainEvent, JournalMainState> {
  @override
  JournalMainState get initialState => JournalMainState.empty();

  @override
  Stream<JournalMainState> mapEventToState(JournalMainEvent event) async* {
    if (event is GetJournalPictureList) {
      yield* _mapGetJournalPictureListToState(event.fid);
    } else if (event is AllDateSeleted) {
      yield* _mapAllDateSeletedToState(event.selectedDate);
    } else if (event is DeleteAll) {
      yield* _mapDeleteAllToState(event);
    }
  }

  Stream<JournalMainState> _mapGetJournalPictureListToState(String fid) async* {
    List<Journal> journalList = [];
    List<Picture> pictureList = [];
    QuerySnapshot jqs = await Firestore.instance
        .collection('Journal')
        .where('fid', isEqualTo: fid)
        .getDocuments();
    jqs.documents.forEach((ds) {
      journalList.add(Journal.fromSnapshot(ds));
    });
    journalList.sort((a, b) => b.date.compareTo(a.date));

    QuerySnapshot pqs = await Firestore.instance
        .collection('Picture')
        .where('fid', isEqualTo: fid)
        .getDocuments();
    pqs.documents.forEach((ds) {
      pictureList.add(Picture.fromSnapshot(ds));
    });
    pictureList.sort((a, b) => b.dttm.compareTo(a.dttm));


    yield state.update(
      journalList: journalList,
      pictureList: pictureList,
    );
  }

  Stream<JournalMainState> _mapAllDateSeletedToState(
      Timestamp selectedDate) async* {
    List<Journal> monthList = state.journalList;

    monthList=monthList.where((element) => element.date.toDate().month == selectedDate.toDate().month &&
        element.date.toDate().year == selectedDate.toDate().year).toList();
//    monthList.forEach((element) =>
//    element.date.toDate().month == selectedDate.toDate().month &&
//        element.date.toDate().year == selectedDate.toDate().year);

    yield state.update(selectedDate: selectedDate, monthJournalList: monthList);
  }

  Stream<JournalMainState> _mapDeleteAllToState(DeleteAll event) async* {
    await Firestore.instance.collection('Journal').document(event.jid).delete();
    state.pictureList.forEach((doc) async {
      if(doc.jid == event.jid) {
        await await Firestore.instance.collection('Picture').document(doc.pid).delete();
      } else {
        ;
      }
    });
  }
}
