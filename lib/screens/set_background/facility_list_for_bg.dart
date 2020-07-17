import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nongple/screens/set_background/pick_image.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/widgets/custom_icons/custom_icons.dart';

class FacilityListForBackground extends StatelessWidget {
  final FacilityList facList;

  FacilityListForBackground({
    Key key,
    this.facList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (facList.category == 1 || facList.category == 2)
          ? Icon(CustomIcons.tractor, color: Color(0xFF2F80ED))
          : (facList.category == 3)
              ? Icon(CustomIcons.cow, color: Color(0xFF2F80ED))
              : Icon(CustomIcons.plant, color: Color(0xFF2F80ED)),
      title: Text(facList.name, style: TextStyle(fontWeight: FontWeight.bold)),
//      trailing: Icon(CustomIcons.cow),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PickBackground(facList: facList)),
        );
      },
    );
  }
}
