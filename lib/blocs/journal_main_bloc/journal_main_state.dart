import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

class JournalMainState {
  final List<Journal> journalList;
  final List<Picture> pictureList;
  final List<Journal> monthJournalList;
  final Timestamp selectedDate;
  final bool isSameDate;
  final bool isLoaded;
  final Facility facility;
  final String detailPageJid;
  final Timestamp detailPageDate;
  final String detailPageContent;
  final List<Picture> detailPageImage;
  final Timestamp pickedDate;
  final bool dialogState;
  final bool mainDialog;
  final bool modifyState;

  JournalMainState({
    @required this.journalList,
    @required this.pictureList,
    @required this.selectedDate,
    @required this.monthJournalList,
    @required this.isSameDate,
    @required this.isLoaded,
    @required this.facility,
    @required this.detailPageJid,
    @required this.detailPageDate,
    @required this.detailPageContent,
    @required this.detailPageImage,
    @required this.pickedDate,
    @required this.dialogState,
    @required this.mainDialog,
    @required this.modifyState,
  });

  factory JournalMainState.empty() {
    return JournalMainState(
      journalList: [],
      pictureList: [],
      selectedDate: Timestamp.now(),
      monthJournalList: [],
      isSameDate: false,
      isLoaded: false,
      facility: Facility(addr: "", category: 0, name: ""),
      detailPageJid: '',
      detailPageDate: Timestamp.now(),
      detailPageContent: '',
      detailPageImage: [],
      pickedDate: Timestamp.now(),
      dialogState: false,
      mainDialog: true,
      modifyState: false,
    );
  }

  JournalMainState copyWith({
    List<Journal> journalList,
    List<Picture> pictureList,
    Timestamp selectedDate,
    List<Journal> monthJournalList,
    bool isSameDate,
    bool isLoaded,
    Facility facility,
    String detailPageJid,
    Timestamp detailPageDate,
    String detailPageContent,
    List<Picture> detailPageImage,
    Timestamp pickedDate,
    bool dialogState,
    bool mainDialog,
    bool modifyState,
  }) {
    return JournalMainState(
      journalList: journalList ?? this.journalList,
      pictureList: pictureList ?? this.pictureList,
      selectedDate: selectedDate ?? this.selectedDate,
      monthJournalList: monthJournalList ?? this.monthJournalList,
      isSameDate: isSameDate ?? this.isSameDate,
      isLoaded: isLoaded ?? this.isLoaded,
      facility: facility ?? this.facility,
      detailPageJid: detailPageJid ?? this.detailPageJid,
      detailPageDate: detailPageDate ?? this.detailPageDate,
      detailPageContent: detailPageContent ?? this.detailPageContent,
      detailPageImage: detailPageImage ?? this.detailPageImage,
      pickedDate: pickedDate ?? this.pickedDate,
      dialogState: dialogState ?? this.dialogState,
      mainDialog: mainDialog ?? this.mainDialog,
      modifyState: modifyState ?? this.modifyState,
    );
  }

  JournalMainState update({
    List<Journal> journalList,
    List<Picture> pictureList,
    Timestamp selectedDate,
    List<Journal> monthJournalList,
    bool isSameDate,
    bool isLoaded,
    Facility facility,
    String detailPageJid,
    Timestamp detailPageDate,
    String detailPageContent,
    List<Picture> detailPageImage,
    Timestamp pickedDate,
    bool dialogState,
    bool mainDialog,
    bool modifyState,
  }) {
    return copyWith(
      journalList: journalList,
      pictureList: pictureList,
      selectedDate: selectedDate,
      monthJournalList: monthJournalList,
      isSameDate: isSameDate,
      isLoaded: isLoaded,
      facility: facility,
      detailPageJid: detailPageJid,
      detailPageDate: detailPageDate,
      detailPageContent: detailPageContent,
      detailPageImage: detailPageImage,
      pickedDate: pickedDate,
      dialogState: dialogState,
      mainDialog: mainDialog,
      modifyState: modifyState,
    );
  }

  @override
  String toString() {
    return '''JournalMainState{
    journalList: ${journalList.length},
    pictureList: ${pictureList.length},
    selectedDate: ${selectedDate.toDate()},
    monthJournalList: $monthJournalList,
    isSameDate: $isSameDate,
    isLoaded: $isLoaded,
    facility: ${facility.fid},
    detailPageJid: $detailPageJid,
    detailPageDate: ${detailPageDate.toDate()},
    detailPageContent: $detailPageContent,
    detailPageImage: ${detailPageImage.length},
    pickedDate: ${pickedDate.toDate()},
    dialogState: $dialogState,
    mainDialog: $mainDialog,
    modifyState: $modifyState,
    }''';
  }
}

class JournalMainStateLoading extends JournalMainState {}
