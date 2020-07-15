import 'bloc.dart';
import 'package:bloc/bloc.dart';

class AddFacilityBloc extends Bloc<AddFacilityEvent, AddFacilityState> {
  @override
  AddFacilityState get initialState => AddFacilityState.empty();

  @override
  Stream<AddFacilityState> mapEventToState(AddFacilityEvent event) async* {
    if(event is FirstPageButtonPressed){
      yield* _mapFirstPageButtonPressedToState(event.facilityName);
    }
  }

  Stream<AddFacilityState> _mapFirstPageButtonPressedToState(String facilityName)async*{
    yield state.update(facilityName: facilityName);
  }
}