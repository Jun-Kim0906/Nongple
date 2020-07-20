import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/widgets/widgets.dart';

class SettingTiles extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    return ListView(
      children: [
        ListTile(
            leading: Icon(Icons.collections),
            title: Text(
                '배경화면 관리', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)
              =>
                  BlocProvider.value(
                    value: _homeBloc,
                    child: SetBackgroundScreen(),
                  )
//                  SetBackgroundScreen(facList: state.facList)),
              ));
            }
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text(
            '로그아웃',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            showAlertDialog(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.error_outline),
          title: Text(
              '버전 정보', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }
}
