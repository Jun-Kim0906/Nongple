
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/journal_detail_bloc/journal_detail.dart';

class JournalDetailBloc extends Bloc<JournalDetailEvent, JournalDetailState> {
  @override
  JournalDetailState get initialState => JournalDetailInitialized();

  @override
  Stream<JournalDetailState> mapEventToState(JournalDetailEvent event) async* {
    if (event is SetJournalDetailArgs) {
      yield* _mapSetJournalDetailArgsToState(event);
    }
  }

  Stream<JournalDetailState> _mapSetJournalDetailArgsToState(SetJournalDetailArgs event) async* {
    yield DetailArgsUpdated(jid: event.jid, date: event.date, content: event.content);
  }

}