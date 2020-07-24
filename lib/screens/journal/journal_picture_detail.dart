import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';

class JournalPictureDetail extends StatelessWidget {
  String url;
  JournalPictureDetail({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        leading: IconButton(
          color: journalGoBackArrowColor,
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Hero(
          tag: url,
            child: Image.network(
//                url,
                'https://cdnweb01.wikitree.co.kr/webdata/editor/202005/27/img_20200527081152_f8e2150d.jpg',
                fit: BoxFit.cover
            )),
      ),
    );
  }
}
