import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/resize_picture.dart';
import 'package:nongple/utils/user_util/user_util.dart';

class FacilityRepository{
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  void uploadFacility({
    Facility facility,
  }) async {
    DocumentReference reference = _firestore.collection('Facility').document(facility.fid);
    await reference.setData(facility.toMap());
  }

  Future<void> uploadImage({Background bg}) async {
    DocumentReference reference = _firestore.collection('Background').document(bg.bgid);
    await reference.setData(bg.toMap());
  }

  Future<void> updateImage({String fid, String bgUrl}) async {
    await Firestore.instance
        .collection('Facility')
        .document(fid)
        .updateData({
      'bgUrl': bgUrl,
    });
  }

  Future<List<Background>> getImageList({String uid, String fid}) async {
    List<Background> bg = [];
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('Background')
        .where('uid', isEqualTo: uid)
        .where('fid', isEqualTo: fid)
        .getDocuments();
    querySnapshot.documents.forEach((element) {
      bg.add(Background.fromSnapshot(element));
    });
    return bg;
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