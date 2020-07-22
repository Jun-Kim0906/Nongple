import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
  String toString() =>'content: $content';
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
  String toString() =>'fid: $fid';
}