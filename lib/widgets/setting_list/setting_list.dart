import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';

class SettingTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.collections
          ),
          title: Text('배경화면 관리'),
          trailing: Icon(
            Icons.arrow_forward_ios
          ),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(
              Icons.exit_to_app
          ),
          title: Text('로그아웃'),
          trailing: Icon(
              Icons.arrow_forward_ios
          ),
          onTap: (){
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLoggedOut(),
            );
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
              Icons.error_outline
          ),
          title: Text('버전 정보'),
          trailing: Icon(
              Icons.arrow_forward_ios
          ),
          onTap: (){},
        ),
      ],
    );
  }
}