import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String year = DateFormat('yyyy').format(now);
String month = DateFormat('MM').format(now);
String day = DateFormat('dd').format(now);
String weekday = DateFormat('EEEE').format(now);