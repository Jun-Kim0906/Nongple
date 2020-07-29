
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.Dart';
import 'package:nongple/utils/utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  final int duration;
  const SplashScreen({this.duration});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('두번 나올껄');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Image.asset('assets/launcher_icon2.png'),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: 250.0,
                child: TextLiquidFill(
                 text: '농플',
                  waveColor: Colors.blueAccent,
                  loadDuration: Duration(seconds: widget.duration),
                  waveDuration: Duration(seconds: widget.duration),
                  boxBackgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ),
                  boxHeight: 300.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
