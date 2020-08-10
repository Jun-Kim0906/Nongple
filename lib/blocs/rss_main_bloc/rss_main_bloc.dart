import 'dart:convert';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class RssMainBloc extends Bloc<RssMainEvent, RssMainState> {
  @override
  RssMainState get initialState => RssMainState.empty();

  @override
  Stream<RssMainState> mapEventToState(event) async* {
    if (event is GetFeed) {
      yield* _mapGetFeedToState();
    }
  }

  Stream<RssMainState> _mapGetFeedToState() async* {
    /// items to look for RSS
    /// final String title;
    /// final String author;
    /// final String description;
    /// final String link;
    /// final List<RssItem> items;


    Xml2Json xml2json = Xml2Json();

    final String FEED_URL = 'http://www.busan.go.kr/nbnews.rss';
    var client = new http.Client();

    /// RSS feed
    await client.get("http://www.busan.go.kr/nbnews.rss").then((response) {
//      var _decoded = RssFeed.parse(response.body);
//      return _decoded.items.map((item) => RssModel(
//        title: item.title,
//        description: item.content.value,
//        link: item.link,
//        pubDate: item.pubDate,
//      ));
      return response.body;
    }).then((bodyString) {
      var channel = new RssFeed.parse(bodyString);
      print(channel);
      print('title : ${channel.title}');
      print('author : ${channel.author}');
      print('description : ${channel.description}');
      print('link : ${channel.link}');
      print('items length : ${channel.items.length}');
      print('item[0] title : ${channel.items[0].title}');
      print('item[0] description : ${channel.items[0].description}');
      print('item[0] content : ${channel.items[0].content.value}');
      print('item[0] content : ${channel.items[0].content.images}');
      print('item[0] link : ${channel.items[0].link}');
      print('item[0] pubDate : ${channel.items[0].pubDate}');
      print('finish');

      channel.items.forEach((element) => print(element.content));

      return channel;
    });
  }
}

class RssModel {
  final String title;
  final String description;
  final String link;
  final String pubDate;

  RssModel({this.title, this.description, this.link, this.pubDate});
}