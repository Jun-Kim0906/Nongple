
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.Dart';
import 'package:nongple/utils/utils.dart';

class SplashScreen extends StatefulWidget {

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Image.asset('assets/launcher_icon2.png'),
            ),
            Flexible(
              flex: 2,
              child: Text('농 플', style: splashScreenTitleStyle,),
            )
          ],
        ),
      ),
    );
  }
}
