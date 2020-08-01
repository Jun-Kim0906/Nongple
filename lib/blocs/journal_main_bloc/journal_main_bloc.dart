
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    } else if (event is CheckSameDate) {
      yield* _mapCheckSameDateToState(event.date);
    } else if (event is OnLoading) {
      yield* _mapOnLoadingToState();
    } else if (event is DeleteOnlyPicture) {
      yield* _mapDeleteOnlyPictureToState(event);
    } else if (event is LoadJournal) {
      yield* _mapLoadJournalToState();
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
      isLoaded: true,
    );
  }

  Stream<JournalMainState> _mapAllDateSeletedToState(
      Timestamp selectedDate) async* {
    List<Journal> monthList = state.journalList;

    monthList = monthList
        .where((element) =>
            element.date.toDate().month == selectedDate.toDate().month &&
            element.date.toDate().year == selectedDate.toDate().year)
        .toList();
//    monthList.forEach((element) =>
//    element.date.toDate().month == selectedDate.toDate().month &&
//        element.date.toDate().year == selectedDate.toDate().year);

    yield state.update(selectedDate: selectedDate, monthJournalList: monthList);
  }

  Stream<JournalMainState> _mapDeleteAllToState(DeleteAll event) async* {
    await Firestore.instance.collection('Journal').document(event.jid).delete();
    state.pictureList.forEach((doc) async {
      if (doc.jid == event.jid) {
        StorageReference photoRef =
            await FirebaseStorage.instance.getReferenceFromUrl(doc.url);
        await photoRef.delete();
        await await Firestore.instance
            .collection('Picture')
            .document(doc.pid)
            .delete();
      } else {
        ;
      }
    });
  }

  Stream<JournalMainState> _mapCheckSameDateToState(Timestamp date) async* {
    state.update(isSameDate: false);
    print('[journal main bloc] reset isSameDate to ${state.isSameDate}');
    print('[journal main bloc] inside check same date');
    List<Journal> dayList = state.journalList;
    bool isSameDate;
    dayList = dayList
        .where((element) =>
            element.date.toDate().year == date.toDate().year &&
            element.date.toDate().month == date.toDate().month &&
            element.date.toDate().day == date.toDate().day)
        .toList();
    print('[journal main bloc] middle of check same date');
    print('[journal main bloc] length of dayList : ${dayList.length}');
    (dayList.length > 0) ? isSameDate = true : isSameDate = false;
    print('[journal main bloc] end of check same date');
    yield state.update(isSameDate: isSameDate);
  }

  Stream<JournalMainState> _mapOnLoadingToState() async* {
    yield state.update(isLoaded: false);
    Stream<JournalMainState> _mapDeleteOnlyPictureToState(
        DeleteOnlyPicture event) async* {
      event.deleteList.forEach((element) async {
        StorageReference photoRef =
            await FirebaseStorage.instance.getReferenceFromUrl(element.url);
        await photoRef.delete();
        await await Firestore.instance
            .collection('Picture')
            .document(element.pid)
            .delete();
      });
    }

    Stream<JournalMainState> _mapLoadJournalToState() async* {
      yield JournalMainStateLoading();
    }
  }
  Stream<JournalMainState> _mapDeleteOnlyPictureToState(
      DeleteOnlyPicture event) async* {

    event.deleteList.forEach((element) async {
      StorageReference photoRef =
      await FirebaseStorage.instance.getReferenceFromUrl(element.url);
      await photoRef.delete();
      await await Firestore.instance
          .collection('Picture')
          .document(element.pid)
          .delete();
    });
  }

  Stream<JournalMainState> _mapLoadJournalToState() async* {
    yield JournalMainStateLoading();
  }

}
