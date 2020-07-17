import 'package:cloud_firestore/cloud_firestore.dart';

class Journal {
  String _fid;
  String _jid;
  String _content;
  Timestamp _date;
  Timestamp _moddttm;

  String get fid=> _fid;
  String get jid=> _jid;
  String get content=>_content;
  Timestamp get date=> _date;
  Timestamp get moddttm=> _moddttm;


  Journal.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    _content=data['content'];
    _date=data['date'];
    _fid=data['fid'];
    _jid=data['jid'];
    _moddttm=data['moddttm'];
  }

  Map<String, dynamic> toMap() {
    return {
      'content' : this._content,
      'date' : this._date,
      'fid' : this._fid,
      'jid': this._jid,
      'moddttm': this._moddttm,
    };
  }
}