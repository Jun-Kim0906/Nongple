import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nongple/models/journal/journal.dart';
import 'package:nongple/models/picture/picture.dart';

class JournalCreateEvent extends Equatable{
  const JournalCreateEvent();

  @override
  List<Object> get props => [];
}

class DateSelected extends JournalCreateEvent{
  final Timestamp selectedDate;
  const DateSelected({@required this.selectedDate});

  @override
  String toString()=>'SelectedDate: $selectedDate';
}

class ContentChanged extends JournalCreateEvent{
  final String content;
  const ContentChanged({@required this.content});

  @override
  String toString() =>'ContentChanged {content: $content}';
}


class ImageSeleted extends JournalCreateEvent{
  final List<Asset> assetList;
  const ImageSeleted({@required this.assetList});

  @override
  String toString() => 'assetList: $assetList';
}

class AddImageFile extends JournalCreateEvent{
  final File imageFile;
  const AddImageFile({@required this.imageFile});

  @override
  String toString() => 'imageFile: ${imageFile.path}';
}

class DeleteImageFile extends JournalCreateEvent{
  final File removedFile;

  const DeleteImageFile({@required this.removedFile});

  @override
  String toString() => 'DeleteImageFile: $removedFile';
}

class CheckSameDate extends JournalCreateEvent {
  final Timestamp date;

  const CheckSameDate({this.date});

  @override
  String toString() => 'CheckSameDate { date : $date }';
}

class CompletePressed extends JournalCreateEvent{}

class PopCheckSameDateDialog extends JournalCreateEvent{}

class MoveToEdit extends JournalCreateEvent{}

class PassFid extends JournalCreateEvent{
  final String fid;
  const PassFid({@required this.fid});

  @override
  String toString() {
    return 'PassFid{fid: $fid}';
  }
}

class UploadJournal extends JournalCreateEvent{
  final String fid;
  const UploadJournal({@required this.fid});

  @override
  String toString() {
    return 'UploadJournal{fid: $fid}';
  }
}

///Edit Screen
class EditPageLoad extends JournalCreateEvent{}

class EditPageLoaded extends JournalCreateEvent{}

class LoadExistJournal extends JournalCreateEvent{}

class PassExistJournalPictures extends JournalCreateEvent{
  final Journal journal;
  final List<Picture> pictureList;
  const PassExistJournalPictures({@required this.journal,@required this.pictureList});
}

class DeleteExistPicture extends JournalCreateEvent{
  final int index;
  const DeleteExistPicture({@required this.index});
}

class UpdateJournal extends JournalCreateEvent{}