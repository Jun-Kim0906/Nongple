import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Rss extends Equatable {
  final String name;
  final List<String> option;
  final List<String> url;

  Rss({@required this.name, @required this.option, @required this.url});

  List<Object> get props => [name, option, url];

  factory Rss.fromDs(DocumentSnapshot ds) {
    return Rss(
      name: ds['name'],
      option: List.from(ds['option']),
      url: List.from(ds['url']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'option': option,
      'url': url,
    };
  }
}

class RssOption extends Equatable{
  final String name;
  final String option;
  final String url;
  final String rid;
  final String uid;

  RssOption({
    @required this.name,
    @required this.option,
    @required this.url,
    @required this.rid,
    @required this.uid,
  });

  List<Object> get props => [name, option, url, rid, uid];

  factory RssOption.fromDs(DocumentSnapshot ds) {
    return RssOption(
        name: ds['name'],
        option: ds['option'],
        url: ds['url'],
        rid: ds['rid'],
        uid: ds['uid']);
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'option': option,
      'url': url,
      'rid': rid,
      'uid': uid,
    };
  }
}

//class SearchRss extends Equatable {
//  final String name;
//  final String option;
//  final String url;
//
//  SearchRss({
//    @required this.name,
//    @required this.option,
//    @required this.url,
//  }) ;
//
//  List<Object> get props => [name, option, url];
//
//  factory SearchRss.fromDs(DocumentSnapshot ds) {
//    return SearchRss(name: ds['name'], option: ds['option'], url: ds['url']);
//  }
//
//  Map<String, String> toMap() {
//    return {
//      'name': name,
//      'option': option,
//      'url': url,
//    };
//  }
//}
