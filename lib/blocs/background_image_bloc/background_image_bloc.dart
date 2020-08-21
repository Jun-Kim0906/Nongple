import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      yield* _mapGetImageListToState(event.fid, event.currentBgUrl);
    } else if (event is EditImageList) {
      yield* _mapEditImageListToState();
    } else if (event is PressCheckBox) {
      yield* _mapPressCheckBoxToState(event);
    } else if (event is RevertToInitialState) {
      yield* _mapRevertToInitialStateToState();
    } else if (event is DeleteSelectedImage) {
      yield* _mapDeleteSelectedImageToState();
    }
  }

  Stream<BgState> _mapUpdateBgUrlToState(UpdateBgUrl event) async* {
    yield state.update(imageFile: event.imageFile);
  }

  Stream<BgState> _mapSaveBgImageToState(File imageFile, String fid) async* {
    String uid = UserUtil.getUser().uid;

    // get new id for image name
    String bgid = '';
    bgid =
        await Firestore.instance.collection('Background').document().documentID;

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

  Stream<BgState> _mapGetImageListToState(
      String fid, String currentBgUrl) async* {
    List<Background> bg = [];
    String uid = UserUtil.getUser().uid;

    bg = await FacilityRepository().getImageList(uid: uid, fid: fid);
    yield state.update(bg: bg, fid: fid, currentBgUrl: currentBgUrl);
  }

  Stream<BgState> _mapEditImageListToState() async* {
    yield state.update(editState: !state.editState);
  }

  Stream<BgState> _mapPressCheckBoxToState(PressCheckBox event) async* {
    List<Background> checkedList = state.checkedList;
    List<String> checkedListWithBgid = state.checkedListWithBgid;

    if (checkedListWithBgid.contains(event.bgid)) {
      checkedListWithBgid.remove(event.bgid);
      checkedList.removeWhere((element) => element.bgid == event.bgid);
    } else {
      checkedListWithBgid.add(event.bgid);
      checkedList.add(Background(
          fid: state.fid,
          uid: await UserUtil.getUser().uid,
          bgid: event.bgid,
          bgUrl: event.bgUrl));
    }

    yield state.update(
        checkBoxState: !state.checkBoxState,
        checkedList: checkedList,
        checkedListWithBgid: checkedListWithBgid);
  }

  Stream<BgState> _mapRevertToInitialStateToState() async* {
    yield state.update(
      checkBoxState: false,
      editState: false,
      checkedList: [],
      checkedListWithBgid: [],
      isCurrBgDeleted: false,
    );
  }

  Stream<BgState> _mapDeleteSelectedImageToState() async* {
    List<Background> checkedList = state.checkedList;
    List<Background> bg = state.bg;
    bool isCurrBgDeleted = false;

    if (checkedList.isNotEmpty &&
        checkedList.length == state.checkedListWithBgid.length) {
      // remove and update bg list in current state
      checkedList.forEach((checkedListElement) {
        bg.removeWhere(
            (bgElement) => bgElement.bgid == checkedListElement.bgid);
      });

      // delete from firebase and storage
      await Future.forEach(checkedList, (element) async {
        // remove from firebase storage
        StorageReference photoRef =
            await FirebaseStorage.instance.getReferenceFromUrl(element.bgUrl);
        await photoRef.delete();

        // remove from firebase background collection
        await Firestore.instance
            .collection('Background')
            .document(element.bgid)
            .delete();

        // set the current background to empty
        if (element.bgUrl == state.currentBgUrl) {
          await Firestore.instance
              .collection('Facility')
              .document(state.fid)
              .updateData({
            'bgUrl': "",
          });

          isCurrBgDeleted = true;
        }
      });
    }

    yield state.update(
      bg: bg,
      checkedList: [],
      checkedListWithBgid: [],
      checkBoxState: false,
      editState: false,
      isCurrBgDeleted: isCurrBgDeleted,
    );
  }
}
