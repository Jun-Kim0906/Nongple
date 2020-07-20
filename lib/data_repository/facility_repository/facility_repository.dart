import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/data_repository/data_repository.dart';

class FacilityRepository{
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  void uploadFacility({
    Facility facility,
  }) async {
    DocumentReference reference = _firestore.collection('Facility').document(facility.fid);
    await reference.setData(facility.toMap());
  }
}