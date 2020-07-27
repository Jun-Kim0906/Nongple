import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';

class JournalPictureDetail extends StatelessWidget {
  String url;
  double height;
//  GlobalKey _globalKey = GlobalKey();

  JournalPictureDetail({@required this.url});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        excludeHeaderSemantics: false,
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
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fitWidth,
            )),
      ),
    );
  }
}
