import 'package:cloud_firestore/cloud_firestore.dart';

class Picture {
  String fid;
  String jid;
  String pid;
  String url;
  Timestamp dttm;


  Picture({this.fid, this.jid, this.pid, this.url, this.dttm});

  factory Picture.fromSnapshot(DocumentSnapshot snapshot) {
    return Picture(
      fid: snapshot['fid'],
      jid: snapshot['jid'],
      pid: snapshot['pid'],
      url: snapshot['url'],
      dttm: snapshot['dttm'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fid': fid,
      'jid': jid,
      'pid': pid,
      'url': url,
      'dttm': dttm,
    };
  }
}
