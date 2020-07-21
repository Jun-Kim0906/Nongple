import 'package:flutter/material.dart';

class BottomNavigationButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _title;

  BottomNavigationButton({Key key, VoidCallback onPressed, @required String title})
      : _onPressed = onPressed,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64.0,
      child: RaisedButton(
        color: Color(0xFF2F80ED),
        child: Text(
          _title ?? '다음',
          style: TextStyle(color: Colors.white, fontSize: 21.6),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
