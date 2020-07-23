import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/models/models.dart';

class PictureRepository{
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  void uploadPicture({
    Picture picture,
  }) async {
    DocumentReference reference = _firestore.collection('Picture').document(picture.pid);
    await reference.setData(picture.toMap());
  }
}