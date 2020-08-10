import 'package:cloud_firestore/cloud_firestore.dart';

class Journal {
  String fid;
  String jid;
  String content;
  Timestamp date;
  Timestamp moddttm;

  Journal({this.fid, this.content, this.date, this.jid, this.moddttm});

  factory Journal.fromSnapshot(DocumentSnapshot snapshot) {
    return Journal(
      fid: snapshot['fid'],
      jid: snapshot['jid'],
      content: snapshot['content'],
      date: snapshot['date'],
      moddttm: snapshot['moddttm'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'date': date,
      'fid': fid,
      'jid': jid,
      'moddttm': moddttm,
    };
  }
}
