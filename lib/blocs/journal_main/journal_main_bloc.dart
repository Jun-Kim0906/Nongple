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
    if (event is MainPageLoad) {
      yield* _mapMainPageLoadToState();
    } else if (event is AllPageLoad) {
      yield* _mapAllPageLoadToState();
    } else if (event is PicturePageLoad) {
      yield* _mapPicturePageLoadToState();
    } else if (event is DetailPageLoad) {
      yield* _mapDetailPageLoadToState(event.loadJournal);
    } else if (event is PageLoaded) {
      yield* _mapPageLoadedToState();
    } else if (event is GetMainPageJournalPictureList) {
      yield* _mapGetMainPageJournalPictureListToState();
    } else if (event is GetDetailPagePictureList) {
      yield* _mapGetDetailPagePictureListToState();
    } else if (event is PassFacility) {
      yield* _mapPassFacilityToState(event.facility);
    } else if (event is PassJournal) {
      yield* _mapPassJournalToState(event.journal);
    } else if (event is GetAllPageJournalList) {
      yield* _mapGetAllPageJournalListToState(event.selectTime);
    } else if (event is SelectMonthChanged) {
      yield* _mapSelectMonthChangedToState(event.changedMonth);
    } else if (event is DeleteJournal) {
      yield* _mapDeleteJournalToState();
    } else if (event is GetAllPicture){
      yield* _mapGetAllPictureToState();
    }
  }

  Stream<JournalMainState> _mapMainPageLoadToState() async* {
    yield state.update(isLoading: true, isMainPageLoading: true);
  }

  Stream<JournalMainState> _mapAllPageLoadToState() async* {
    yield state.update(isLoading: true, isAllPageLoading: true);
  }

  Stream<JournalMainState> _mapPicturePageLoadToState() async* {
    yield state.update(isLoading: true, isPicturePageLoading: true);
  }

  Stream<JournalMainState> _mapDetailPageLoadToState(bool loadJournal) async* {
    yield state.update(isLoading: true, isDetailPageLoading: true, loadJournal: loadJournal);
  }

  Stream<JournalMainState> _mapPageLoadedToState() async* {
    yield state.update(
      isMainPageLoading: false,
      isAllPageLoading: false,
      isPicturePageLoading: false,
      isDetailPageLoading: false,
    );
  }

  Stream<JournalMainState> _mapGetMainPageJournalPictureListToState() async* {
    List<Journal> journalList = [];
    List<Picture> pictureList = [];

    QuerySnapshot jqs = await Firestore.instance
        .collection('Journal')
        .where('fid', isEqualTo: state.facility.fid)
        .orderBy('date', descending: true)
        .limit(3)
        .getDocuments();

    jqs.documents.forEach((ds) {
      journalList.add(Journal.fromSnapshot(ds));
    });


    QuerySnapshot pqs = await Firestore.instance
        .collection('Picture')
        .where('fid', isEqualTo: state.facility.fid)
        .orderBy('dttm', descending: true)
        .limit(3)
        .getDocuments();
    pqs.documents.forEach((ds) {
      pictureList.add(Picture.fromSnapshot(ds));
    });

    yield state.update(
      mainThreeJournalList: journalList,
      mainThreePictureList: pictureList,
      isLoading: false,
    );
  }

  Stream<JournalMainState> _mapGetDetailPagePictureListToState() async* {
    List<Picture> pictureList = [];

    QuerySnapshot pqs = await Firestore.instance
        .collection('Picture')
        .where('jid', isEqualTo: state.journal.jid)
        .getDocuments();
    pqs.documents.forEach((ds) {
      pictureList.add(Picture.fromSnapshot(ds));
    });
    
    if(state.loadJournal){
      DocumentSnapshot ds = await Firestore.instance.collection('Journal').document(state.journal.jid).get();
      Journal journal = Journal.fromSnapshot(ds);
      yield state.update(
        detailPictureList: pictureList,
        isLoading: false,
        journal: journal,
      );
    }else{
      yield state.update(
        detailPictureList: pictureList,
        isLoading: false,
      );
    }
  }

  Stream<JournalMainState> _mapGetAllPageJournalListToState(
      Timestamp selectTime) async* {
    List<Journal> journalList = [];
    int _year = state.selectMonth.toDate().year;
    int _month = state.selectMonth.toDate().month;
    String fid = state.facility.fid;
    String formatMonth = '$_month';
    String formatNextMonth = '${_month + 1}';
    if (_month < 10) {
      formatMonth = '0$_month';
    }
    if (_month < 9) {
      formatNextMonth = '0${_month + 1}';
    }

    QuerySnapshot jqs = await Firestore.instance
        .collection('Journal')
        .where('fid', isEqualTo: fid)
        .where('date',
            isLessThan: Timestamp.fromMillisecondsSinceEpoch(
                DateTime.parse('$_year${formatNextMonth}01')
                    .millisecondsSinceEpoch))
        .where('date',
            isGreaterThanOrEqualTo: Timestamp.fromMillisecondsSinceEpoch(
                DateTime.parse('$_year${formatMonth}01')
                    .millisecondsSinceEpoch))
        .orderBy('date')
        .getDocuments();

    jqs.documents.forEach((ds) {
      journalList.add(Journal.fromSnapshot(ds));
    });

    yield state.update(
      monthlyJournalList: journalList,
      isLoading: false,
    );
  }

  Stream<JournalMainState> _mapPassFacilityToState(Facility facility) async* {
    yield state.update(facility: facility);
  }

  Stream<JournalMainState> _mapPassJournalToState(Journal journal) async* {
    yield state.update(journal: journal);
  }

  Stream<JournalMainState> _mapSelectMonthChangedToState(
      Timestamp changedMonth) async* {
    yield state.update(
        selectMonth: changedMonth, isLoading: true, isAllPageLoading: true);
  }

  Stream<JournalMainState> _mapDeleteJournalToState() async* {
    await Firestore.instance
        .collection('Journal')
        .document(state.journal.jid)
        .delete();
    QuerySnapshot qs = await Firestore.instance
        .collection('Picture')
        .where('jid', isEqualTo: state.journal.jid)
        .getDocuments();
    qs.documents.forEach((element) async {
      StorageReference photoRef =
          await FirebaseStorage.instance.getReferenceFromUrl(element['url']);
      await photoRef.delete();
      await Firestore.instance
          .collection('Picture')
          .document(element['pid'])
          .delete();
    });
  }

  Stream<JournalMainState> _mapGetAllPictureToState()async*{
    List<Picture> pictureList=[];

    QuerySnapshot pqs = await Firestore.instance
        .collection('Picture')
        .where('fid', isEqualTo: state.facility.fid)
        .orderBy('dttm', descending: true)
        .getDocuments();
    pqs.documents.forEach((ds) {
      pictureList.add(Picture.fromSnapshot(ds));
    });

    yield state.update(allPictureList: pictureList, isLoading: false);
  }
}
