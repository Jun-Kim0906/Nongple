import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/data_repository/journal_repository/journal_repository.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nongple/models/models.dart';

class JournalCreateBloc extends Bloc<JournalCreateEvent, JournalCreateState> {
  @override
  JournalCreateState get initialState => JournalCreateState.empty();

  @override
  Stream<JournalCreateState> mapEventToState(JournalCreateEvent event) async* {
    if (event is DateSeleted) {
      yield* _mapDateSeletedToState(event.selectedDate);
    } else if (event is ContentChanged) {
      yield* _mapContentChangedToState(event.content);
    } else if (event is ImageSeleted) {
      yield* _mapImageSeletedToState(event.assetList);
    } else if (event is AddImageFile) {
      yield* _mapAddImageFileToState(event.imageFile);
    } else if (event is DeleteImageFile) {
      yield* _mapDeleteImageFileToState(event.removedFile);
    } else if(event is UploadJournal){
      yield* _mapUploadJournalToState(event.fid);
    }
  }

  Stream<JournalCreateState> _mapDateSeletedToState(
      Timestamp selectedDate) async* {
    yield state.update(isDateSeleted: true, selectedDate: selectedDate);
  }

  Stream<JournalCreateState> _mapContentChangedToState(String content) async* {
    yield state.update(content: content);
  }

  Stream<JournalCreateState> _mapImageSeletedToState(
      List<Asset> assetList) async* {
    yield state.update(assetList: assetList);
  }

  Stream<JournalCreateState> _mapAddImageFileToState(File imageFile) async* {
    List<File> _img = state.imageList;
    if (!_img.contains(imageFile)) {
      _img.insert(0, imageFile);
    }

    yield state.update(
      imageList: _img,
    );
  }

  Stream<JournalCreateState> _mapDeleteImageFileToState(File removedFile) async* {
    List<File> _img = state.imageList;
    _img.remove(removedFile);

    yield state.update(
      imageList: _img,
    );
  }
  Stream<JournalCreateState> _mapUploadJournalToState(String fid) async* {
    JournalRepository().uploadJournal(
        journal: Journal(
          content: state.content,
          date: state.selectedDate,
          moddttm: state.selectedDate,
          fid: fid,
          jid: Firestore.instance.collection('Journal').document().documentID,
        ));
    yield state.update(
        jid: Firestore.instance.collection('Journal').document().documentID,
        fid: fid,
    );
  }
}
