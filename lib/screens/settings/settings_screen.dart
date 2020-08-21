import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/home_bloc/home.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/style.dart';
import 'package:nongple/widgets/widgets.dart';

class Settings extends StatelessWidget {
  double height;
  double width;
  bool isChanged=false;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.blue[600],
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context, isChanged);
          },
        ),
        title: SizedBox(
          height: height * 0.04,
          child: AutoSizeText(
            '앱 설정',
            style: settingAppBarStyle,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _homeBloc,
        child: SettingTile(context),
      ),
    );
  }
  Widget SettingTile(BuildContext context){
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
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
            onTap: () async{
              isChanged = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: _homeBloc,
                        child: SetBackgroundScreen(),
                      )
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
