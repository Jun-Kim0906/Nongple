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
    }else if(event is DateSeleted){
      yield* _mapDateSeletedToState(event.selectedDate);
    }else if(event is ContentChanged){
      yield* _mapContentChangedToState(event.content);
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

  Stream<JournalMainState> _mapDateSeletedToState(Timestamp selectedDate) async*{
    yield state.update(isDateSeleted: true, selectedDate: selectedDate);
  }

  Stream<JournalMainState> _mapContentChangedToState(String content) async*{
    yield state.update(content: content);
  }

}