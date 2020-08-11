import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:nongple/models/models.dart';
import 'package:nongple/utils/rss_list/rss_list.dart';

class RssMainState {
  final List<Rss> suggestion;

  RssMainState({
    @required this.suggestion,
  });

  factory RssMainState.empty() {
    return RssMainState(
      suggestion: rssHardCoding,
    );
  }

  RssMainState copyWith({
    List<Rss> suggestion,
  }) {
    return RssMainState(
      suggestion: suggestion ?? this.suggestion,
    );
  }

  RssMainState update({
    List<Rss> suggestion,
  }) {
    return copyWith(
      suggestion: suggestion,
    );
  }

  @override
  String toString() {
    return '''RssMainState{
    suggestion: ${suggestion.length},
    }''';
  }
}