import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/data_repository/data_repository.dart';

class Facility {
  static const ADDR = 'addr';
  static const BGURL = 'bgUrl';
  static const CATEGORY = 'category';
  static const FID = 'fid';
  static const NAME = 'name';
  static const TEMPERATURE = 'temperature';
  static const UID = 'uid';

  String _addr;
  String _bgUrl;
  int _category;
  String _fid;
  String _name;
  String _temperature;
  String _uid;

  String get addr => _addr;
  String get bgUrl => _bgUrl;
  int get category => _category;
  String get fid => _fid;
  String get name => _name;
  String get temperature => _temperature;
  String get uid => _uid;

  Facility.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    _addr=data[ADDR];
    _bgUrl=data[BGURL];
    _category=data[CATEGORY];
    _fid=data[FID];
    _name=data[NAME];
    _temperature=data[TEMPERATURE];
    _uid=data[UID];
  }
}