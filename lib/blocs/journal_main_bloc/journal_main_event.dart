import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class JournalMainEvent extends Equatable{
  const JournalMainEvent();

  @override
  List<Object> get props => [];
}

class GetJournalList extends JournalMainEvent{
  final String fid;
  const GetJournalList({@required this.fid});

  @override
  String toString() =>'Journal fid : $fid';
}