import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/data_repository/data_repository.dart';
import 'package:nongple/models/background/background.dart';
import 'package:nongple/utils/utils.dart';

class BgBloc extends Bloc<BgEvent, BgState> {
  @override
  BgState get initialState => BgState.empty();

  @override
  Stream<BgState> mapEventToState(BgEvent event) async* {
    if (event is UpdateBgUrl) {
      yield* _mapUpdateBgUrlToState(event);
    } else if (event is SaveBgImage) {
      yield* _mapSaveBgImageToState(event.imageFile, event.fid);
    } else if (event is GetImageList) {
      yield* _mapGetImageListToState(event.fid);
    } else if (event is EditImageList) {
      yield* _mapEditImageListToState();
    } else if (event is PressCheckBox) {
      yield* _mapPressCheckBoxToState(event);
    } else if (event is RevertToInitialState) {
      yield* _mapRevertToInitialStateToState();
    }
  }

  Stream<BgState> _mapUpdateBgUrlToState(UpdateBgUrl event) async* {
    yield state.update(imageFile: event.imageFile);
  }

  Stream<BgState> _mapSaveBgImageToState(File imageFile, String fid) async* {
    String uid = UserUtil.getUser().uid;

    // get new id for image name
    String bgid = '';
    bgid = await Firestore.instance.collection('Background').document().documentID;

    // upload to storage and return image url
    String bgUrl = await FacilityRepository().uploadImageFile(imageFile, bgid);

    // update facility with new background
    await FacilityRepository().updateImage(fid: fid, bgUrl: bgUrl);

    // add new background to the image list
    await FacilityRepository().uploadImage(
        bg: Background(
          fid: fid,
          uid: uid,
          bgid: bgid,
          bgUrl: bgUrl,
        ));

    yield state.update();
  }

  Stream<BgState> _mapGetImageListToState(String fid) async* {
    List<Background> bg = [];
    String uid = UserUtil.getUser().uid;

    bg = await FacilityRepository().getImageList(uid: uid, fid: fid);
    yield state.update(bg: bg);
  }

  Stream<BgState> _mapEditImageListToState() async* {
    yield state.update(editState: !state.editState);
  }

  Stream<BgState> _mapPressCheckBoxToState(PressCheckBox event) async* {
    List<Background> checkedList = [];


    yield state.update(checkBoxState: !state.checkBoxState);
  }

  Stream<BgState> _mapRevertToInitialStateToState() async* {
    yield state.update(checkBoxState: false, editState: false);
  }
}