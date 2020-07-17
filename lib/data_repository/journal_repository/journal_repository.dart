import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/data_repository/data_repository.dart';

class JournalRepository{
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  void uploadJournal({
    String fid,
    String content,
    Timestamp moddttm,
  }) async {
    DocumentReference reference = _firestore.collection('Journal').document();
    await reference.setData({
      'content' : content,
      'date' : FieldValue.serverTimestamp(),
      'fid': '',
      'jid': reference.documentID,
      'moddttm':FieldValue.serverTimestamp(),
    });
  }
}