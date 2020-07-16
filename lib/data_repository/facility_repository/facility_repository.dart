import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/data_repository/data_repository.dart';

class FacilityRepository{
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  void uploadFacility({
    String addr,
    int category,
    String name,
  }) async {
    DocumentReference reference = _firestore.collection('Facility').document();
    await reference.setData({
      'addr' : addr,
      'bgUrl' : '',
      'category' : category,
      'fid': reference.documentID,
      'name': name,
      'temperature':'',
      'uid': (await UserRepository().getUser()).uid,
    });
  }
}