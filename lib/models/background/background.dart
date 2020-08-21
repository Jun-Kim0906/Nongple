import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Background extends Equatable{
  String fid;
  String uid;
  String bgid;
  String bgUrl;

  Background({this.fid, this.uid, this.bgid, this.bgUrl});

  @override
  List<Object> get props => [this.fid, this.uid, this.bgid, this.bgUrl];

  factory Background.fromSnapshot(DocumentSnapshot snapshot) {
    return Background(
      fid: snapshot['fid'],
      uid: snapshot['uid'],
      bgid: snapshot['bgid'],
      bgUrl: snapshot['bgUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fid' : fid,
      'uid' : uid,
      'bgid' : bgid,
      'bgUrl' : bgUrl,
    };
  }
}