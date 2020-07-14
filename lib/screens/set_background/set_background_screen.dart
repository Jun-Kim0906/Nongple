import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongple/blocs/blocs.dart';

class SetBackgroundScreen extends StatefulWidget {
  @override
  _SetBackgroundScreenState createState() => _SetBackgroundScreenState();
}

class _SetBackgroundScreenState extends State<SetBackgroundScreen> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc _homeBloc=BlocProvider.of<HomeBloc>(context);
    return BlocListener(
      bloc: _homeBloc,
      listener: (BuildContext context, HomeState state){
        if(state.backgroundImg!=''){
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: BlocBuilder(
        bloc: _homeBloc,
        builder: (BuildContext context, HomeState state){

        },
      ),
    );
  }
}
