import 'package:cloud_firestore/cloud_firestore.dart';

class Journal {
  String fid;
  String jid;
  String content;
  Timestamp date;
  Timestamp moddttm;

//  String get fid=> _fid;
//  String get jid=> _jid;
//  String get content=>_content;
//  Timestamp get date=> _date;
//  Timestamp get moddttm=> _moddttm;

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
