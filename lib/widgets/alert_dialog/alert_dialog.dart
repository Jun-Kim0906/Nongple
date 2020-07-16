import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = GestureDetector(
    child: Text("아니요"),
    onTap: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = GestureDetector(
    child: Text("네", style: TextStyle(color: Colors.blue),),
    onTap: () {
      BlocProvider.of<AuthenticationBloc>(context).add(
        AuthenticationLoggedOut(),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    content: Container(
      height: MediaQuery.of(context).size.height - 550,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('로그아웃', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('정말로 로그아웃 하시겠습니까?'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 1,
                child: continueButton,
              ),
              SizedBox(width: 15.0,),
              Flexible(
                flex: 1,
                child: cancelButton,
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
