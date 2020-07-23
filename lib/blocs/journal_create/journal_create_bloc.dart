import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nongple/data_repository/data_repository.dart';
import 'package:nongple/data_repository/journal_repository/journal_repository.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nongple/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nongple/utils/utils.dart';

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
    Journal _journal = Journal(content: state.content,
      date: state.selectedDate,
      moddttm: state.selectedDate,
      fid: fid,
      jid: Firestore.instance.collection('Journal').document().documentID,);

    JournalRepository().uploadJournal(
        journal: _journal
    );

    List<File> imageList=state.imageList;
    String pid = '';

    if(imageList.isNotEmpty) {
      imageList.forEach((File file) async {
        pid = Firestore.instance
            .collection('Picture')
            .document()
            .documentID;
        Picture _picture = Picture(
          fid: fid,
          jid: _journal.jid,
          pid: pid,
          url: (await uploadImageFile(file, pid)),
          dttm: Timestamp.now(),
        );

        PictureRepository().uploadPicture(
          picture: _picture,
        );
      });
    }

    yield state.update(
        jid: _journal.jid,
        fid: fid,
    );
  }

  Future<String> uploadImageFile(File file, String pid) async{
    FirebaseStorage storage = FirebaseStorage();
    String url='';

    final StorageReference ref = storage.ref().child('journal_pictures').child(UserUtil.getUser().uid).child('$pid.jpg');
    final StorageUploadTask uploadTask = ref.putFile(file);

    await (await uploadTask.onComplete).ref.getDownloadURL().then((value) => url = value);

    return url;
  }
}
