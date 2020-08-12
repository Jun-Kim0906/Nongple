import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';

class JournalPictureDetail extends StatelessWidget {
  String url;
  bool ismain;
  double height;

  JournalPictureDetail({@required this.url, @required this.ismain});

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
          color: goBackArrowColor,
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Hero(
            tag: ismain?'$url+main':'$url+all',
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fitWidth,
            )),
      ),
    );
  }
}
