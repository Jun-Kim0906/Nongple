import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';

abstract class RssMainEvent extends Equatable {
  const RssMainEvent();

  @override
  List<Object> get props => [];
}

class GetRss extends RssMainEvent {}

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

class CompleteButtonPressed extends RssMainEvent{}

class EditButtonPressed extends RssMainEvent{}

class DeleteRss extends RssMainEvent{
  final RssOption deleteRss;
  const DeleteRss({@required this.deleteRss});

  @override
  String toString() {
    return 'DeleteRss{deleteRss: ${deleteRss.name} ${deleteRss.option}';
  }
}

class MoveToAddPage extends RssMainEvent{
  @override
  String toString() {
    return 'MoveToAddPage';
  }
}

class SearchOnChanged extends RssMainEvent{
  final String search;
  const SearchOnChanged({@required this.search});

  @override
  String toString() {
    return 'SearchOnChanged{search: $search}';
  }
}

class LoadRssPage extends RssMainEvent{}

class RssPageLoaded extends RssMainEvent{}