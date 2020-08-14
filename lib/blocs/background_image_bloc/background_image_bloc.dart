import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/data_repository/bg_repository/bg_repository.dart';
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
    }
  }

  Stream<BgState> _mapUpdateBgUrlToState(UpdateBgUrl event) async* {
    yield state.update(imageFile: event.imageFile);
  }

  Stream<BgState> _mapSaveBgImageToState(File imageFile, String fid) async* {
    List<Background> bg = [];
    String uid = UserUtil.getUser().uid;
    // get new id for image name
    String bgid = '';
    bgid = await Firestore.instance.collection('Background').document().documentID;

    // upload to storage and return image url
    String bgUrl = await uploadImageFile(imageFile, bgid);

    // update facility with new background
    await BgRepository().updateImage(fid: fid, bgUrl: bgUrl);

    // add new background to the image list
    await BgRepository().uploadImage(
        bg: Background(
          fid: fid,
          uid: uid,
          bgid: bgid,
          bgUrl: bgUrl,
        ));

    bg = await BgRepository().getImageList(uid: uid, fid: fid);

    yield state.update(bg: bg);
  }

  Future<String> uploadImageFile(File file, String bgid) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url = '';
    final StorageReference ref = storage
        .ref()
        .child('background_image')
        .child(UserUtil.getUser().uid)
        .child('${bgid}.jpg');
    final StorageUploadTask uploadTask = ref.putFile(await resizePicture(file));
    await (await uploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((value) => url = value);
    print(url);
    return url;
  }
}