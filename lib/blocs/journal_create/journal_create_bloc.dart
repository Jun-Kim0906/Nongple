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
    if (event is DateSelected) {
      yield* _mapDateSelectedToState(event.selectedDate);
    } else if (event is ContentChanged) {
      yield* _mapContentChangedToState(event.content);
    } else if (event is ImageSelected) {
      yield* _mapImageSelectedToState(event.assetList);
    } else if (event is AddImageFile) {
      yield* _mapAddImageFileToState(event.imageFile, event.index);
    } else if (event is DeleteImageFile) {
      yield* _mapDeleteImageFileToState(event.removedFile);
    } else if (event is CheckSameDate) {
      yield* _mapCheckSameDateToState(event.date);
    } else if (event is CompletePressed) {
      yield* _mapCompletePressedToState();
    } else if (event is PopCheckSameDateDialog) {
      yield* _mapPopCheckSameDateDialogToState();
    } else if (event is MoveToEdit) {
      yield* _mapMoveToEditToState();
    } else if (event is PassFid) {
      yield* _mapPassFidToState(event.fid);
    } else if (event is UploadJournal) {
      yield* _mapUploadJournalToState(event.fid);
    } else if (event is LoadExistJournal) {
      yield* _mapLoadExistJournalToState();
    } else if (event is EditPageLoad) {
      yield* _mapEditPageLoadToState();
    } else if (event is EditPageLoaded) {
      yield* _mapEditPageLoadedToState();
    } else if (event is PassExistJournalPictures){
      yield* _mapPassExistJournalPicturesToState(event.journal, event.pictureList);
    } else if (event is DeleteExistPicture){
      yield* _mapDeleteExistPictureToState(event.index);
    } else if( event is UpdateJournal){
      yield* _mapUpdateJournalToState();
    }
  }

  Stream<JournalCreateState> _mapDateSelectedToState(
      Timestamp selectedDate) async* {
    yield state.update(selectedDate: selectedDate, dateConfirmed: true);
  }

  Stream<JournalCreateState> _mapContentChangedToState(String content) async* {
    yield state.update(content: content);
  }

  Stream<JournalCreateState> _mapImageSelectedToState(
      List<Asset> assetList) async* {
    List<File> bufferList = state.imageList;
    for(int i =0; i<assetList.length; i++){
      bufferList.insert(0, null);
    }
    yield state.update(assetList: assetList, imageList: bufferList);
  }

  Stream<JournalCreateState> _mapAddImageFileToState(File imageFile, int index) async* {
    List<File> _img = state.imageList;

    if (!_img.contains(imageFile)) {
      _img.removeAt(index);
      _img.insert(index, await resizePicture(imageFile));
    }

    yield state.update(
      imageList: _img,
    );
  }

  Stream<JournalCreateState> _mapDeleteImageFileToState(
      File removedFile) async* {
    List<File> _img = state.imageList;
    _img.remove(removedFile);

    yield state.update(
      imageList: _img,
    );
  }

  Stream<JournalCreateState> _mapCheckSameDateToState(Timestamp date) async* {
    bool isSameDateExist;

    QuerySnapshot qs = await Firestore.instance
        .collection('Journal')
        .where('fid', isEqualTo: state.fid)
        .where('date', isEqualTo: date ?? state.selectedDate)
        .getDocuments();
    (qs.documents.length > 0)
        ? isSameDateExist = true
        : isSameDateExist = false;
    yield state.update(
        selectedDate: date ?? state.selectedDate,
        checkSameDateDialog: isSameDateExist,
        dateConfirmed: !isSameDateExist,
        datePickerState: false);
  }

  Stream<JournalCreateState> _mapCompletePressedToState() async* {
    yield state.update(createCompletePressed: true);
  }

  Stream<JournalCreateState> _mapPopCheckSameDateDialogToState() async* {
    yield state.update(
        checkSameDateDialog: false,
        datePickerState: true,
        dateConfirmed: false);
  }

  Stream<JournalCreateState> _mapMoveToEditToState() async* {
    yield state.update(
        checkSameDateDialog: false,
        datePickerState: false,
        dateConfirmed: false);
  }

  Stream<JournalCreateState> _mapPassFidToState(String fid) async* {
    yield state.update(fid: fid);
  }

  Stream<JournalCreateState> _mapUploadJournalToState(String fid) async* {
    Journal _journal = Journal(
      content: state.content,
      date: state.selectedDate,
      moddttm: state.selectedDate,
      fid: fid,
      jid: Firestore.instance.collection('Journal').document().documentID,
    );

    await JournalRepository().uploadJournal(journal: _journal);

    List<File> imageList = state.imageList;
    String pid = '';

    if (imageList.isNotEmpty) {
      await Future.forEach(imageList, (File file) async {
        pid = Firestore.instance.collection('Picture').document().documentID;
        Picture _picture = Picture(
          fid: fid,
          jid: _journal.jid,
          pid: pid,
          url: (await uploadImageFile(file, pid)),
          dttm: Timestamp.now(),
        );

        await PictureRepository().uploadPicture(
          picture: _picture,
        );
      });
    }

    yield state.update(
      fid: fid,
      uploadComplete: true,
    );
  }

  Future<String> uploadImageFile(File file, String pid) async {
    FirebaseStorage storage = FirebaseStorage();
    String url = '';

    final StorageReference ref = storage
        .ref()
        .child('journal_pictures')
        .child(UserUtil.getUser().uid)
        .child('$pid.jpg');
    final StorageUploadTask uploadTask = ref.putFile(file);

    await (await uploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((value) => url = value);

    return url;
  }

  Stream<JournalCreateState> _mapLoadExistJournalToState() async* {
    Journal existJournal;
    List<Picture> existPictureList = [];

    QuerySnapshot jquerySnapshot = await Firestore.instance
        .collection('Journal')
        .where('fid', isEqualTo: state.fid)
        .where('date', isEqualTo: state.selectedDate)
        .getDocuments();

    existJournal = Journal.fromSnapshot(jquerySnapshot.documents[0]);


    QuerySnapshot pquerySnapshot = await Firestore.instance
        .collection('Picture')
        .where('jid', isEqualTo: existJournal.jid)
        .getDocuments();


    pquerySnapshot.documents.forEach((element) {
      existPictureList.add(Picture.fromSnapshot(element));
    });



    yield state.update(
        existJournal: existJournal,
        existPictureList: existPictureList,
        isLoading: false,
        content: existJournal.content);
  }

  Stream<JournalCreateState> _mapEditPageLoadToState() async* {
    yield state.update(editPageLoading: true, isLoading: true);
  }

  Stream<JournalCreateState> _mapEditPageLoadedToState() async* {
    yield state.update(editPageLoading: false);
  }

  Stream<JournalCreateState> _mapPassExistJournalPicturesToState(Journal journal, List<Picture> pictures) async* {
    yield state.update(existJournal: journal, existPictureList: pictures, content: journal.content);
  }

  Stream<JournalCreateState> _mapDeleteExistPictureToState(int index) async* {
    List<Picture> bufferPictureList = state.existPictureList;
    List<Picture> removedPictureList = state.removedPictureList;

    removedPictureList.add(bufferPictureList[index]);
    bufferPictureList.removeAt(index);
    yield state.update(existPictureList: bufferPictureList, removedPictureList: removedPictureList);
  }

  Stream<JournalCreateState> _mapUpdateJournalToState() async* {
    Journal _journal = Journal(content: state.content,
        date: state.existJournal.date,
        moddttm: state.existJournal.date,
        fid: state.fid,
        jid: state.existJournal.jid);

    await JournalRepository().updateJournal(
        journal: _journal
    );

    List<File> imageList=state.imageList;
    String pid = '';

    if(imageList.isNotEmpty) {
      await Future.forEach(imageList, (File file)async{
        pid = Firestore.instance
            .collection('Picture')
            .document()
            .documentID;
        Picture _picture = Picture(
          fid: state.fid,
          jid: _journal.jid,
          pid: pid,
          url: (await uploadImageFile(file, pid)),
          dttm: Timestamp.now(),
        );

        await PictureRepository().uploadPicture(
          picture: _picture,
        );
      });
    }

    state.removedPictureList.forEach((element) async {
      StorageReference photoRef =
      await FirebaseStorage.instance.getReferenceFromUrl(element.url);
      await photoRef.delete();
      await await Firestore.instance
          .collection('Picture')
          .document(element.pid)
          .delete();
    });

    yield state.update(uploadComplete: true);
  }
}
