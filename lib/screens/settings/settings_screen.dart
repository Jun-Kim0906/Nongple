import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/home_bloc/home.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/utils/style.dart';
import 'package:nongple/widgets/widgets.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
            Navigator.pop(context);
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
        child: SettingTiles(),
      ),
    );
  }
}
