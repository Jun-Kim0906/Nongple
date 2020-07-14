import 'package:flutter/material.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/screens/screens.dart';
import 'package:nongple/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nongple/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
        child: Container(
          child: Column(
            children: [
              Text('$name 님'),
              Text('오늘도 풍성한 하루 되세요'),
              Text(DateTime.now().toString()),
              Container(
                child: Row(
                  children: [
                    RaisedButton(),
                    RaisedButton(),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Card(
                child: Center(
                  child: FlatButton(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FacilityCreateScreen()));
                          },
                        ),
                        Text('농사 프로젝트 추가하기')
                      ],
                    ),
                  ),
                ),
              ),
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
