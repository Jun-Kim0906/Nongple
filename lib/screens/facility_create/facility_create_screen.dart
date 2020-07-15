import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/style.dart';
import 'package:nongple/widgets/widgets.dart';

class FacilityCreateScreen extends StatefulWidget {
  @override
  _FacilityCreateScreenState createState() => _FacilityCreateScreenState();
}

class _FacilityCreateScreenState extends State<FacilityCreateScreen> {
  TextEditingController facilityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        leading: IconButton(
          color: facilityGoBackButtonColor,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Text(
                '시설 이름을 \n입력해 주세요 ' + EmojiParser().emojify('🙂'),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 33.6),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            Text('시설 이름',
              style: facilitySearchTitle,
            ),
            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              controller: facilityNameController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: '이름 입력하기',
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
