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

class DateSeleted extends JournalCreateEvent{
  final Timestamp selectedDate;
  const DateSeleted({@required this.selectedDate});

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

class UploadJournal extends JournalCreateEvent{
  final String fid;
  const UploadJournal({@required this.fid});

  @override
  String toString() =>'UploadJournal {fid: $fid}';
}

class UpdateJournal extends JournalCreateEvent {
  final String fid;
  final String jid;
  const UpdateJournal({@required this.fid, @required this.jid});

  @override
  String toString() => 'UpdateJournal { fid : $fid, jid : $jid }';
}

class SetCopyImageList extends JournalCreateEvent {
  final List<Picture> copyOfExistingImage;
  const SetCopyImageList({@required this.copyOfExistingImage});

  @override
  String toString() => 'SetCopyImageList { copyOfExistingImage : $copyOfExistingImage }';
}

class DeleteCopyOfExistingImage extends JournalCreateEvent {
  final int index;
  const DeleteCopyOfExistingImage({@required this.index});

  @override
  String toString() => 'DeleteCopyOfExistingImage { index : $index }';
}

class ModifyPressed extends JournalCreateEvent{}

class Test extends JournalCreateEvent{}