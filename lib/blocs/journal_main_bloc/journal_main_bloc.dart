import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/models/models.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';

class JournalMainBloc extends Bloc<JournalMainEvent, JournalMainState>{

  @override
  JournalMainState get initialState => JournalMainState.empty();

  @override
  Stream<JournalMainState> mapEventToState(JournalMainEvent event) async* {
    if(event is GetJournalList){
      yield* _mapGetJournalListToState(event.fid);
    }
  }

  Stream<JournalMainState> _mapGetJournalListToState(String fid) async*{
    List<Journal> journalList = [];
    QuerySnapshot qs = await Firestore.instance.collection('Journal').where('fid',isEqualTo: fid).getDocuments();
    qs.documents.forEach((ds) {
      journalList.add(Journal.fromSnapshot(ds));
    });
    yield state.update(journalList: journalList);
  }
}