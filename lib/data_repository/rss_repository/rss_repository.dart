import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/models/models.dart';

class RssRepository {
  Firestore _firestore = Firestore.instance;
  DocumentReference reference;

  Future<List<RssOption>> loadRss({String uid}) async {
    List<RssOption> originalList = [];
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('Rss')
        .where('uid', isEqualTo: uid)
        .getDocuments();
    querySnapshot.documents.forEach((element) {
      originalList.add(RssOption.fromDs(element));
    });
    return originalList;
  }

  uploadRss({
    RssOption rss,
  }) {
    DocumentReference reference =
        _firestore.collection('Rss').document(rss.rid);
    reference.setData(rss.toMap());
  }

  deleteRss({
    RssOption rss,
  }) {
    _firestore.collection('Rss').document(rss.rid).delete();
  }
}
