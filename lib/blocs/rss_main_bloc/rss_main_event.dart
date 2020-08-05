
import 'package:equatable/equatable.dart';

abstract class RssMainEvent extends Equatable {
  const RssMainEvent();

  @override
  List<Object> get props => [];
}

class GetFeed extends RssMainEvent {}