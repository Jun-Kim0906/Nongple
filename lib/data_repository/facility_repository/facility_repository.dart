import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/resize_picture.dart';
import 'package:nongple/utils/user_util/user_util.dart';

class FacilityRepository {
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  void uploadFacility({
    Facility facility,
  }) async {
    DocumentReference reference =
        _firestore.collection('Facility').document(facility.fid);
    await reference.setData(facility.toMap());
  }

  Future<void> uploadImage({Background bg}) async {
    DocumentReference reference =
        _firestore.collection('Background').document(bg.bgid);
    await reference.setData(bg.toMap());
  }

  Future<void> updateImage({String fid, String bgUrl}) async {
    await Firestore.instance.collection('Facility').document(fid).updateData({
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

  Future<void> deleteFacility({
    String uid,
    String fid,
  }) async {
    List<Background> bg = [];
    List<Picture> pic = [];
    List<Journal> journal = [];
    Facility facility;

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('Background')
        .where('fid', isEqualTo: fid)
        .where('uid', isEqualTo: uid)
        .getDocuments();
    querySnapshot.documents.forEach((element) async {
      bg.add(Background.fromSnapshot(element));
    });

    print('bg length : ${bg.length}');

    if(bg.isNotEmpty) {
      print('bg is not empty');
      await Future.forEach(bg, (element) async {
        if (element.bgUrl != null) {
          StorageReference photoRef = await FirebaseStorage.instance
              .ref()
              .getStorage()
              .getReferenceFromUrl(element.bgUrl);
          await photoRef.delete();
        }

        await Firestore.instance
            .collection('Background')
            .document(element.bgid)
            .delete();
      });
    }

    querySnapshot = await Firestore.instance
        .collection('Picture')
        .where('fid', isEqualTo: fid)
        .getDocuments();
    querySnapshot.documents.forEach((element) async {
      pic.add(Picture.fromSnapshot(element));
    });

    if(pic.isNotEmpty) {
      print('pic is not empty');
      await Future.forEach(pic, (element) async {
        if (element.url != null) {
          StorageReference photoRef = await FirebaseStorage.instance
              .ref()
              .getStorage()
              .getReferenceFromUrl(element.url);
          await photoRef.delete();
        }

        await Firestore.instance
            .collection('Picture')
            .document(element.pid)
            .delete();
      });
    }

    print('pic length : ${pic.length}');

    querySnapshot = await Firestore.instance
        .collection('Journal')
        .where('fid', isEqualTo: fid)
        .getDocuments();
    querySnapshot.documents.forEach((element) async {
      journal.add(Journal.fromSnapshot(element));
    });

    print('journal length : ${journal.length}');

    if(journal.isNotEmpty) {
      print('journal is not empty');
      await Future.forEach(journal, (element) async {
        await Firestore.instance
            .collection('Journal')
            .document(element.jid)
            .delete();
      });
    }

    querySnapshot = await Firestore.instance
        .collection('Facility')
        .where('uid', isEqualTo: uid)
        .where('fid', isEqualTo: fid)
        .getDocuments();
    querySnapshot.documents.forEach((element) async {
      facility = Facility.fromSnapshot(element);
    });

//    if (facility.bgUrl != null && facility.bgUrl.length > 0) {
//      print('facility bgUrl is not empty');
//      StorageReference photoRef = await FirebaseStorage.instance
//          .ref()
//          .getStorage()
//          .getReferenceFromUrl(facility.bgUrl);
//      await photoRef.delete();
//    }

    await Firestore.instance
        .collection('Facility')
        .document(facility.fid)
        .delete();
  }
}
