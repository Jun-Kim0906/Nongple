import 'bloc.dart';
import 'package:bloc/bloc.dart';

class AddFacilityBloc extends Bloc<AddFacilityEvent, AddFacilityState> {
  @override
  AddFacilityState get initialState => AddFacilityState.empty();

  @override
  Stream<AddFacilityState> mapEventToState(AddFacilityEvent event) async* {
    if(event is FirstPageButtonPressed){
      yield* _mapFirstPageButtonPressedToState(event.facilityName);
    }else if(event is FacilityNameChanged){
      yield* _mapFacilityNameChangedToState(event.facilityname);
    }else if (event is SecondPageButtonPressed){
      yield* _mapSecondPageButtonPressedToState(event.facilityAddr);
    }else if (event is FacilityAddrChanged){
      yield* _mapFacilityAddrChangedToState(event.facilityAddr);
    }
  }

  Stream<AddFacilityState> _mapFirstPageButtonPressedToState(String facilityName)async*{
    yield state.update(firstPageButtonPressed: true, facilityName: facilityName);
  }

  Stream<AddFacilityState> _mapFacilityNameChangedToState(String facilityName) async*{
    yield state.update(isNameValid: facilityName.isNotEmpty);
  }

  Stream<AddFacilityState> _mapSecondPageButtonPressedToState(String facilityAddr) async*{
    yield state.update(secondPageButtonPressed: true, facilityAddr: facilityAddr);
  }

  Stream<AddFacilityState> _mapFacilityAddrChangedToState(String facilityAddr) async*{
    yield state.update(isAddrValid: facilityAddr.isNotEmpty);
  }
}