import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/data_repository/data_repository.dart';
import 'package:nongple/models/models.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';

class AddFacilityBloc extends Bloc<AddFacilityEvent, AddFacilityState> {
  @override
  AddFacilityState get initialState => AddFacilityState.empty();

  @override
  Stream<AddFacilityState> mapEventToState(AddFacilityEvent event) async* {
    if (event is FacilityNameChanged) {
      yield* _mapFacilityNameChangedToState(event.facilityname);
    } else if (event is FacilityAddrChanged) {
      yield* _mapFacilityAddrChangedToState(event.facilityAddr);
    } else if (event is FacilityCategoryChanged) {
      yield* _mapFacilityCategoryChangedToState(event.facilityCategory);
    } else if (event is FacilityUpload) {
      yield* _mapFacilityUploadToState();
    }
  }

  Stream<AddFacilityState> _mapFacilityNameChangedToState(
      String facilityName) async* {
    yield state.update(
        isNameValid: facilityName.isNotEmpty, facilityName: facilityName);
  }

  Stream<AddFacilityState> _mapFacilityAddrChangedToState(
      String facilityAddr) async* {
    yield state.update(
        isAddrValid: facilityAddr.isNotEmpty, facilityAddr: facilityAddr);
  }

  Stream<AddFacilityState> _mapFacilityCategoryChangedToState(
      int facilityCatgory) async* {
    yield state.update(
        isCategoryValid: true, facilityCategory: facilityCatgory);
  }

  Stream<AddFacilityState> _mapFacilityUploadToState() async* {
    print('여기는');
    FacilityRepository().uploadFacility(
        facility: Facility(
      addr: state.facilityAddr,
      name: state.facilityName,
      category: state.facilityCategory,
      uid: (await UserRepository().getUser()).uid,
      fid: Firestore.instance.collection('Facility').document().documentID,
    ));
    yield state.update(
        uid: (await UserRepository().getUser()).uid,
        fid: Firestore.instance.collection('Facility').document().documentID);
  }
}
