import 'package:flutter/material.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/style.dart';

class ButtonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 143,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('card tapped');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FacilityCreateScreen()));
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                    size: 35.0,
                  ),
                  Expanded(
                    child: Text(
                      '농사 프로젝트 추가하기',
                      style: cardWidgetAddProjButton,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
