import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/style.dart';
import 'package:nongple/widgets/widgets.dart';

class SettingTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        ListTile(
            leading: Icon(Icons.collections, color: Color(0xFF757575)),
            title: SizedBox(
              height: height * 0.04,
              width: width * 0.644,
              child: AutoSizeText(
                '배경화면 관리',
                style: settingListStyle,
                maxLines: 1,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                            value: _homeBloc,
                            child: SetBackgroundScreen(),
                          )
//                  SetBackgroundScreen(facList: state.facList)),
                      ));
            }),
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Color(0xFF757575),
          ),
          title: SizedBox(
              height: height * 0.04,
              width: width * 0.644,
              child: AutoSizeText(
                  '로그아웃',
                  style: settingListStyle,
                maxLines: 1,
              )
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF757575),
          ),
          onTap: () {
            showAlertDialog(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.error_outline,
            color: Color(0xFF757575),
          ),
          title: SizedBox(
              height: height * 0.04,
              width: width * 0.644,
              child: AutoSizeText(
                  '버전 정보',
                  style: settingListStyle,
                maxLines: 1,
              )
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF757575),
          ),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Nongple',
              applicationVersion: '1.0.0',
              applicationLegalese: '개발자 : \nOat Kim / Grain Park\n(Prod. may2nd)',
              applicationIcon: SizedBox(
                height: height * 0.05,
                width: width * 0.1,
                child: FittedBox(
                  child: Image.asset('assets/launcher_icon.png'),
                ),
              ),
              children: [],
            );
          },
        ),
      ],
    );
  }
}
