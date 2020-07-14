import 'package:flutter/material.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nongple/widgets/widgets.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String year = DateFormat('yyyy').format(now);
    String month = DateFormat('MM').format(now);
    String day = DateFormat('dd').format(now);
    String weekday = DateFormat('EEEE').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name 님',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '오늘도 풍성한 하루 되세요',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '$year 년 $month 월 $day 일 $weekday',
                style: TextStyle(fontSize: 20.0),
              ),
              Container(
                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionChip(
                        avatar: CircleAvatar(
//                          backgroundColor: Colors.grey.shade800,
                          child: Icon(Icons.wifi),
                        ),
                        label: Text('RSS'),
                        onPressed: () {
                          print(
                              "RSS");
                        }),
                    SizedBox(
                      width: 20.0,
                    ),
                    ActionChip(
                        avatar: CircleAvatar(
//                          backgroundColor: Colors.grey.shade800,
                          child: Icon(Icons.settings),
                        ),
                        label: Text('설정'),
                        onPressed: () {
                          print(
                              "설정");
                        }),
                  ],
                ),
              ),
              Expanded(
                child: ListViewBuilder(),
              ),
//              Expanded(
//                child: ListView.builder(
//                  itemCount: 3,
//                  itemBuilder: (BuildContext context, int index) {
//                    if (index == 2) {
//                      return ButtonCard();
//                    }
//                    else {
//                      return HomePageCard();
//                    }
////                    return HomePageCard();
//                  },
//                ),
//              ),
//              ButtonCard(),
            ],
          ),
        ),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    HomeBloc _homeBloc=BlocProvider.of<HomeBloc>(context);
//    return BlocListener(
//        bloc: BlocProvider.of<HomeBloc>(context),
//        listener: (BuildContext context, HomeState state) {
//          if (state.settingBtnPressed==true) {
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => BlocProvider<HomeBloc>.value(
//                    value: _homeBloc,
//                    child: SetBackgroundScreen(),
//                  ),
//                ));
//          }
//        },
//        child: BlocBuilder<HomeBloc,HomeState>(
//          builder: (context, state) {
//            return Scaffold(
//              appBar: AppBar(
//                title: Text('Home'),
//                actions: <Widget>[
//                  IconButton(
//                    icon: Icon(Icons.exit_to_app),
//                    onPressed: () {
//                      BlocProvider.of<AuthenticationBloc>(context).add(
//                        AuthenticationLoggedOut(),
//                      );
//                    },
//                  )
//                ],
//              ),
//              body: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Center(child: Text('Welcome $name!')),
//                  RaisedButton(
//                    child: Text('Setting'),
//                    onPressed: (){
//                      BlocProvider.of<HomeBloc>(context).add(
//                        SettingBtnPressed(),
//                      );
//                    },
//                  )
//                ],
//              ),
//              drawer: Drawer(),
//            );
//          }
//        ));
//  }
}
