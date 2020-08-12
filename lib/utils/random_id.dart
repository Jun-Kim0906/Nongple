import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

final _random = Random();
final Base64Codec _base64 = Base64Codec();
final Utf8Codec _utf8 = Utf8Codec();

getRandomId() {
  String _dttm = Timestamp.now().millisecondsSinceEpoch.toString();
  String _rnd = (10000 + _random.nextInt(89999)).toString();

  return _base64.encode(_utf8.encode(_dttm + _rnd));
}
