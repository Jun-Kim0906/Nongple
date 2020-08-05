import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:nongple/utils/colors.dart';

class RssAddFacility extends StatefulWidget {
  @override
  _RssAddFacilityState createState() => _RssAddFacilityState();
}

class _RssAddFacilityState extends State<RssAddFacility> {
  RssMainBloc _rssMainBloc;
  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rssMainBloc = BlocProvider.of<RssMainBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF979797),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: appBarColor,
        title: Text(
            'RSS 기관 등록하기',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(width*0.05, height*0.03, width*0.05, height*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '원하시는 지역 및 기관을 검색하세요',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: height*0.04,),
            TextField(
              autofocus: true,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2F80ED))
                ),
                prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF2F80ED),
                ),
                hintText: '입력하세요',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: _search,
              onChanged: (value) {
                _rssMainBloc.add(GetFeed());
              },
//              onSubmitted: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
