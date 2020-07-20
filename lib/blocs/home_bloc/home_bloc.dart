import 'package:flutter/cupertino.dart';
import 'package:nongple/models/facility/facility.dart';
import 'package:nongple/testPage2.dart';
import 'package:nongple/data_repository/data_repository.dart';
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
  }

  Stream<HomeState> _mapGetFacilityListToState() async* {
    List<Facility> facList = [];
    QuerySnapshot qs = await Firestore.instance.collection('Facility').where('uid', isEqualTo: (await UserRepository().getUser()).uid).getDocuments();
    qs.documents.forEach((ds) {
      facList.add(Facility.fromSnapshot(ds));
    });
    yield FacilityListSet(facList);
  }
}