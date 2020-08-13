import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/home_bloc/home.dart';
import 'package:nongple/blocs/rss_main_bloc/rss_main.dart';
import 'package:nongple/screens/rss_screen/rss_add.dart';
import 'package:nongple/screens/rss_screen/rss_main_screen.dart';
import 'package:nongple/screens/screens.dart';
import 'package:webfeed/domain/media/media.dart';

class ChipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc _homeBloc = BlocProvider.of<HomeBloc>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionChip(
            backgroundColor: Colors.white,
            elevation: 3.0,
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.rss_feed,
                size: 20.0,
              ),
            ),
            label: Text(
              'RSS',
              style: TextStyle(
                  fontSize: 14.4,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F80ED),
              ),
            ),
            onPressed: () {
              print("RSS");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    BlocProvider<RssMainBloc>(
                      create: (context) => RssMainBloc(),
                      child: RssMainScreen(),
                    )
                ),
              );
            }),
        SizedBox(
          width: 20.0,
        ),
        ActionChip(
            backgroundColor: Colors.white,
            elevation: 3.0,
            avatar: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.settings,
                size: 20.0,
              ),
            ),
            label: Text(
              '설정',
              style: TextStyle(
                  fontSize: 14.4,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F80ED),
              ),
            ),
            onPressed: () {
              print("설정");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
                  BlocProvider.value(
                    value: _homeBloc,
                    child: Settings(),
                  )
              ));
            }),
      ],
    );
  }
}
