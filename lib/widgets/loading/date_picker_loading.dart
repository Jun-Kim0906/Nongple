//import 'package:flutter/material.dart';
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
//import 'package:nongple/blocs/journal_main_bloc/bloc.dart';
//
//class LoadingDialog {
//  JournalMainBloc _journalMainBloc = JournalMainBloc();
//  JournalCreateBloc _journalCreateBloc = JournalCreateBloc();
//
//  static void onShow(BuildContext context) {
//    DatePicker.showDatePicker(
//      context,
//      onConfirm: (date, i) {
//        print('confirm $date');
//        _journalMainBloc.add(CheckSameDate(
//            date: Timestamp.fromDate(date)));
//        if(mState.isSameDate == true) {
//          Navigator.pop(context);
//          showAlertDialog(context, state.selectedDate, state.content,
//              state.jid, widget.facility);
//        }
//        _journalCreateBloc.add(DateSeleted(
//            selectedDate: Timestamp.fromDate(date)));
//
//      },
//      initialDateTime: state.selectedDate.toDate(),
//      locale: DateTimePickerLocale.ko,
//      onClose: () => print('onClose'),
//      onCancel: () => print('onCancel'),
//    );
//  }
//
//  static void dismiss(BuildContext context, Function next) {
//    Navigator.pop(context); //pop dialog
//    next();
//  }
//}
