import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/models/models.dart';

class BgRepository{
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

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
}