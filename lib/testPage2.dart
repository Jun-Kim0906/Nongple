import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';


class FacilityList {
  String addr;
  String bgUrl;
  int category;
  String fid;
  String name;
  String temperature;
  String uid;

  FacilityList({
    @required this.addr,
    @required this.bgUrl,
    @required this.category,
    @required this.fid,
    @required this.name,
    @required this.temperature,
    @required this.uid,
  });

//  FacilityList({this.email, this.fcmToken, this.name, this.uid})

  factory FacilityList.fromSnapshot(DocumentSnapshot ds){
    return FacilityList(
      addr: ds['addr'],
      bgUrl: ds['bgUrl'],
      category: ds['category'],
      fid: ds['fid'],
      name: ds['name'],
      temperature: ds['temperature'],
      uid: ds['uid'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'addr': addr,
      'bgUrl': bgUrl,
      'category': category,
      'fid': fid,
      'name': name,
      'temperature': temperature,
      'uid': uid,
    };
  }
}
