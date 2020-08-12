import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RssMainEvent extends Equatable {
  const RssMainEvent();

  @override
  List<Object> get props => [];
}

class GetFeed extends RssMainEvent {}

class SelectedRssChanged extends RssMainEvent {
  final String name;
  final String option;
  final String url;
  final bool isChecked;

  SelectedRssChanged(
      {@required this.name, @required this.option, @required this.url, @required this.isChecked});

  @override
  String toString() {
    return '''SelectedRssChanged {
    name : $name, 
    option : $option, 
    url : $url
    }''';
  }
}
