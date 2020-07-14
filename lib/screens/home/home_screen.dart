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
    HomeBloc _homeBloc=BlocProvider.of<HomeBloc>(context);
    return BlocListener(
        bloc: BlocProvider.of<HomeBloc>(context),
        listener: (BuildContext context, HomeState state) {
          if (state.settingBtnPressed==true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<HomeBloc>.value(
                    value: _homeBloc,
                    child: SetBackgroundScreen(),
                  ),
                ));
          }
        },
        child: BlocBuilder<HomeBloc,HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationLoggedOut(),
                      );
                    },
                  )
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(child: Text('Welcome $name!')),
                  RaisedButton(
                    child: Text('Setting'),
                    onPressed: (){
                      BlocProvider.of<HomeBloc>(context).add(
                        SettingBtnPressed(),
                      );
                    },
                  )
                ],
              ),
              drawer: Drawer(),
            );
          }
        ));
  }
}
