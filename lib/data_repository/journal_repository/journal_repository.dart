import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/models/journal/journal.dart';

class JournalRepository{
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  void uploadJournal({
    Journal journal,
  }) async {
    DocumentReference reference = _firestore.collection('Journal').document(journal.jid);
    await reference.setData(journal.toMap());
  }

  void updateJournal({
  Journal journal,
}) async {
    DocumentReference reference = _firestore.collection('Journal').document(journal.jid);
    await reference.updateData(journal.toMap());
  }
}