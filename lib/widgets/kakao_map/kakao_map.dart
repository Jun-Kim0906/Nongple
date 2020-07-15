import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'kopo_model.dart';

class Kopo extends StatefulWidget {
  Kopo({
    Key key,
    this.title = '주소검색',
    this.colour = Colors.white,
    this.apiKey = '',
  }) : super(key: key);

  @override
  KopoState createState() => KopoState();

  final String title;
  final Color colour;
  final String apiKey;
}

class KopoState extends State<Kopo> {
  WebViewController _controller;
  WebViewController get controller => _controller;

  num _stackFlag = 1 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colour,
        title: Text("주소검색"),
        elevation: 1.0,
      ),
      body: IndexedStack(
          index: _stackFlag,
          children: <Widget> [
            WebView(
              initialUrl: 'https://yunhankyu.github.io/2020/04/24/',
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'onComplete',
                    onMessageReceived: (JavascriptMessage message) {
                      //This is where you receive message from
                      //javascript code and handle in Flutter/Dart
                      //like here, the message is just being printed
                      //in Run/LogCat window of android studio
                      Navigator.pop(
                          context, KopoModel.fromJson(jsonDecode(message.message)));
                    }),
              ]),
              onWebViewCreated: (WebViewController webViewController) async {
                _controller = webViewController;
              },
              onPageStarted: _startLoading,
              onPageFinished:_doneLoading,
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ]
      ),
    );
  }

  void _startLoading(String value){
    setState(() {
      _stackFlag = 1 ;
    });
  }

  void _doneLoading(String value){
    setState(() {
      _stackFlag = 0 ;
    });
  }
}