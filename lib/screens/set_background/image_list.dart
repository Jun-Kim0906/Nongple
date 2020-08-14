import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nongple/models/background/background.dart';
import 'package:nongple/utils/colors.dart';

class BgImageList extends StatefulWidget {
  final List<Background> bg;
  const BgImageList({this.bg});

  @override
  _BgImageListState createState() => _BgImageListState();
}

class _BgImageListState extends State<BgImageList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('사진목록', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(widget.bg.length, (index) {
          return Container(
            child: Image(
              image: CachedNetworkImageProvider(widget.bg[index].bgUrl),
            ),
          );
        }),
      ),
    );
  }
}
