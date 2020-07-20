import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/home_bloc/home.dart';
import 'package:nongple/utils/colors.dart';
import 'package:nongple/widgets/widgets.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        title: Text('앱 설정', style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: _homeBloc,
        child: SettingTiles(),
      ),
    );
  }
}
