import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/data_repository/data_repository.dart';
import 'package:meta/meta.dart';

class Facility {
  static const ADDR = 'addr';
  static const BGURL = 'bgUrl';
  static const CATEGORY = 'category';
  static const FID = 'fid';
  static const NAME = 'name';
  static const TEMPERATURE = 'temperature';
  static const UID = 'uid';
  static const LAT = 'lat';
  static const LNG = 'lng';

  String addr;
  String bgUrl;
  int category;
  String fid;
  String name;
  String temperature;
  String uid;
  String lat;
  String lng;

  Facility({
    @required this.addr,
    this.bgUrl,
    @required this.category,
    this.fid,
    @required this.name,
    this.temperature,
    this.uid,
    this.lat,
    this.lng,
  });

  factory Facility.fromSnapshot(DocumentSnapshot snapshot) {
    return Facility(
      addr: snapshot[ADDR],
      bgUrl: snapshot[BGURL],
      category: snapshot[CATEGORY],
      fid: snapshot[FID],
      name: snapshot[NAME],
      temperature: snapshot[TEMPERATURE],
      uid: snapshot[UID],
      lat: snapshot[LAT],
      lng: snapshot[LNG],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addr': addr,
      'bgUrl': bgUrl ?? '',
      'category': category,
      'fid': fid,
      'name': name,
      'temperature': temperature ?? '',
      'uid': uid,
      'lat': lat,
      'lng': lng,
    };
  }
}
