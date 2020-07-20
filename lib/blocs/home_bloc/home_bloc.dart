import 'package:flutter/cupertino.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/testPage2.dart';

import 'home.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState>{

  @override
  HomeState get initialState=> Initial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event)async*{
    if (event is GetFacilityList) {
      yield* _mapGetFacilityListToState();
    }
//    if(event is SettingBtnPressed){
//      yield* _mapSettingBtnPressedToState();
//    }else if(event is BackgroundImgChanged){
//      yield* _mapBackgroundImgChangedToState(event.backgroundImg);
//    }
  }

  Stream<HomeState> _mapGetFacilityListToState() async* {
    List<Facility> facList = [];
    QuerySnapshot qs = await Firestore.instance.collection('Facility').getDocuments();
    qs.documents.forEach((ds) {
      facList.add(Facility.fromSnapshot(ds));
    });
    yield FacilityListSet(facList);
  }

//  Stream<HomeState> _mapSettingBtnPressedToState() async*{
//    yield state.update(
//      settingBtnPressed: true,
//    );
//  }
//
//  Stream<HomeState> _mapBackgroundImgChangedToState(String backgroundImg) async*{
//    String uid = (await FirebaseAuth.instance.currentUser()).uid;
//
//    await Firestore.instance
//        .collection("User")
//        .document(uid)
//        .updateData({'bgUrl': backgroundImg});
//
//    yield state.update(
//      backgroundImg: backgroundImg,
//    );
//  }
}