import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';


class JournalMainState {
  List<Journal> mainThreeJournalList;
  List<Picture> mainThreePictureList;
  List<Journal> monthlyJournalList;
  List<Picture> detailPictureList;
  List<Picture> allPictureList;
  Facility facility;
  Journal journal;
  Timestamp selectMonth;
  bool loadJournal;
  bool isLoading;
  bool isMainPageLoading;
  bool isAllPageLoading;
  bool isPicturePageLoading;
  bool isDetailPageLoading;

  JournalMainState({
    @required this.mainThreeJournalList,
    @required this.mainThreePictureList,
    @required this.monthlyJournalList,
    @required this.detailPictureList,
    @required this.allPictureList,
    @required this.facility,
    @required this.journal,
    @required this.selectMonth,
    @required this.loadJournal,
    @required this.isLoading,
    @required this.isMainPageLoading,
    @required this.isAllPageLoading,
    @required this.isPicturePageLoading,
    @required this.isDetailPageLoading,
  });



  factory JournalMainState.empty() {
    String month;
    if(DateTime.now().month<10){
      month='0${DateTime.now().month}';
    }else{
      month='${DateTime.now().month}';
    }
    return JournalMainState(
      mainThreeJournalList: [],
      mainThreePictureList: [],
      monthlyJournalList: [],
      detailPictureList: [],
      allPictureList: [],
      facility: Facility(addr: "", category: 0, name: ""),
      journal: Journal(),
      selectMonth: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.parse('${DateTime.now().year}${month}01')
              .millisecondsSinceEpoch),
      loadJournal: false,
      isLoading: false,
      isMainPageLoading: false,
      isAllPageLoading: false,
      isPicturePageLoading: false,
      isDetailPageLoading: false,
    );
  }

  JournalMainState copyWith({
    List<Journal> mainThreeJournalList,
    List<Picture> mainThreePictureList,
    List<Picture> detailPictureList,
    List<Picture> allPictureList,
    List<Journal> monthlyJournalList,
    Facility facility,
    Journal journal,
    Timestamp selectMonth,
    bool loadJournal,
    bool isLoading,
    bool isMainPageLoading,
    bool isAllPageLoading,
    bool isPicturePageLoading,
    bool isDetailPageLoading,
  }) {
    return JournalMainState(
      mainThreeJournalList: mainThreeJournalList ?? this.mainThreeJournalList,
      mainThreePictureList: mainThreePictureList ?? this.mainThreePictureList,
      monthlyJournalList: monthlyJournalList ?? this.monthlyJournalList,
      detailPictureList: detailPictureList ?? this.detailPictureList,
      allPictureList: allPictureList ?? this.allPictureList,
      facility: facility ?? this.facility,
      journal: journal ?? this.journal,
      selectMonth: selectMonth?? this.selectMonth,
      loadJournal: loadJournal ?? this.loadJournal,
      isLoading: isLoading ?? this.isLoading,
      isMainPageLoading: isMainPageLoading ?? this.isMainPageLoading,
      isAllPageLoading: isAllPageLoading ?? this.isAllPageLoading,
      isPicturePageLoading: isPicturePageLoading ?? this.isPicturePageLoading,
      isDetailPageLoading: isDetailPageLoading ?? this.isDetailPageLoading,
    );
  }

  JournalMainState update({
    List<Journal> mainThreeJournalList,
    List<Picture> mainThreePictureList,
    List<Picture> detailPictureList,
    List<Picture> allPictureList,
    List<Journal> monthlyJournalList,
    Facility facility,
    Journal journal,
    Timestamp selectMonth,
    bool loadJournal,
    bool isLoading,
    bool isMainPageLoading,
    bool isAllPageLoading,
    bool isPicturePageLoading,
    bool isDetailPageLoading,
  }) {
    return copyWith(
      mainThreeJournalList: mainThreeJournalList,
      mainThreePictureList: mainThreePictureList,
      monthlyJournalList: monthlyJournalList,
      detailPictureList: detailPictureList,
      allPictureList: allPictureList,
      facility: facility,
      journal: journal,
      selectMonth: selectMonth,
      loadJournal: loadJournal,
      isLoading: isLoading,
      isMainPageLoading: isMainPageLoading,
      isAllPageLoading: isAllPageLoading,
      isPicturePageLoading: isPicturePageLoading,
      isDetailPageLoading: isDetailPageLoading,
    );
  }

  @override
  String toString() {
    return '''JournalMainState{
    mainThreeJournalList: $mainThreeJournalList,
    mainThreePictureList: $mainThreePictureList,
    monthlyJournalList: $monthlyJournalList,
    detailPictureList: $detailPictureList,
    allPictureList: $allPictureList,
    facility: $facility,
    journal: $journal,
    selectMonth: ${selectMonth.toDate()},
    loadJournal: $loadJournal,
    isLoading: $isLoading,
    isMainPageLoading: $isMainPageLoading,
    isAllPageLoading: $isAllPageLoading,
    isPicturePageLoading: $isPicturePageLoading,
    isDetailPageLoading: $isDetailPageLoading,
    }''';
  }
}
