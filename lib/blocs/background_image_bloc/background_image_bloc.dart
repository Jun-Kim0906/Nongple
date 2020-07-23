import 'package:bloc/bloc.dart';
import 'package:nongple/blocs/blocs.dart';

class BgBloc extends Bloc<BgEvent, BgState> {
  @override
  BgState get initialState => InitialBgUrl();

  @override
  Stream<BgState> mapEventToState(BgEvent event) async* {
    if (event is UpdateBgUrl) {
      yield* _mapUpdateBgUrlToState(event);
    }
  }

  Stream<BgState> _mapUpdateBgUrlToState(UpdateBgUrl event) async* {
    yield BgUrlSet(event.bgUrl);
  }
}