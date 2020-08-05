

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

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

    var client = new http.Client();

    // RSS feed
    client.get("http://www.busan.go.kr/nbnews.rss").then((response) {
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
      print('item[0] link : ${channel.items[0].link}');
      print('finish');
      return channel;
    });

    // Atom feed
//    client.get("http://www.busan.go.kr/nbnews.rss/index.xml").then((response) {
//      return response.body;
//    }).then((bodyString) {
//      var feed = new AtomFeed.parse(bodyString);
//      print(feed);
//      return feed;
//    });
  }

}