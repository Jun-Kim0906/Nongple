import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/screens/set_background/facility_list_for_bg.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/utils/utils.dart';

class SetBackgroundScreen extends StatefulWidget {

  @override
  _SetBackgroundScreenState createState() => _SetBackgroundScreenState();
}

class _SetBackgroundScreenState extends State<SetBackgroundScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          '배경화면 관리',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state){
          if (state is FacilityListSet) {
            return ListView.separated(
                itemCount: state.facList.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return FacilityListForBackground(facList: state.facList[index]);
                });
          } else {
            return SplashScreen();
          }
        },
      )
    );
  }
}
