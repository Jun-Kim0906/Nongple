import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:nongple/widgets/widgets.dart';

class SetBackgroundScreen extends StatefulWidget {

  @override
  _SetBackgroundScreenState createState() => _SetBackgroundScreenState();
}

class _SetBackgroundScreenState extends State<SetBackgroundScreen> {
  HomeBloc _homeBloc;
  double height;
  double width;
  bool isChanged=false;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
            '배경화면 관리',
            style: settingAppBarStyle,
          ),
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
                  return BlocProvider.value(
                    value: _homeBloc,
                    child: FacilityListForBackground(facility: state.facList[index]),
                  );
                });
          } else {
            return SplashScreen(
              duration: 1,
            );
          }
        },
      )
    );
  }
  Widget FacilityListForBackground({Facility facility}){
    return ListTile(
      leading: SizedBox(
        height: height * 0.06,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Card(
            shape: CircleBorder(side: BorderSide(color: Colors.grey[200])),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: (facility.category == 1 || facility.category == 2)
                  ? Icon(CustomIcons.tractor, color: Color(0xFF2F80ED), size: 30,)
                  : (facility.category == 3)
                  ? Icon(CustomIcons.cow, color: Color(0xFF2F80ED), size: 30,)
                  : Icon(CustomIcons.plant, color: Color(0xFF2F80ED), size: 30,),
            ),
          ),
        ),
      ),
      title: SizedBox(
        height: height * 0.04,
        width: width * 0.644,
        child: AutoSizeText(
          facility.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          maxLines: 1,
        ),
      ),
//      trailing: Icon(CustomIcons.cow),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () async{
        isChanged = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _homeBloc,
                    ),
                    BlocProvider<BgBloc>(
                      create: (BuildContext context) => BgBloc(),
                    )
                  ],
                  child: PickBackground(facility: facility),
                )));
      },
    );
  }
}
