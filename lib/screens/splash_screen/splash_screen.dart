import 'package:flutter/material.dart';
import 'package:nongple/utils/utils.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/launcher_icon.png',
                scale: 0.4,
              ),
              Text(
                '농 플',
                style: splashScreenTitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
