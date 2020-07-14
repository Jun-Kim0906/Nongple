import 'package:flutter/material.dart';

class BottomNavigationButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _title;

  BottomNavigationButton({Key key, VoidCallback onPressed, String title})
      : _onPressed = onPressed,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64.0,
      child: RaisedButton(
        color: Colors.blue[600],
        child: Text(
          _title??'다음',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
