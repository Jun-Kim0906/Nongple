import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nongple/blocs/blocs.dart';
import 'package:nongple/data_repository/user_repository/user_repository.dart';
import 'package:nongple/screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
//  final UserRepository userRepository = UserRepository();
  runApp(
    App(),
//    BlocProvider(
//      create: (context) => AuthenticationBloc(userRepository: userRepository)
//        ..add(AuthenticationStarted()),
//      child: App(userRepository: userRepository),
//    ),
  );
}

class App extends StatefulWidget {
//  final UserRepository _userRepository;
//
//  App({Key key, @required UserRepository userRepository})
//      : assert(userRepository != null),
//        _userRepository = userRepository,
//        super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), () {
      _authenticationBloc = AuthenticationBloc(userRepository: userRepository);
      _authenticationBloc.add(AuthenticationStarted());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _authenticationBloc == null
        ? MaterialApp(
            home: SplashScreen(),
          )
        : BlocProvider.value(
            value: _authenticationBloc,
            child: MaterialApp(
              theme: ThemeData(
                backgroundColor: Colors.white,
                primaryColor: Colors.black,
                primaryColorLight: Colors.white,
                accentColor: Colors.blue[600],
              ),
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is AuthenticationInitial) {
                    return SplashScreen();
                  } else if (state is AuthenticationFailure) {
                    return LoginScreen(userRepository: userRepository);
//              SplashToLogin(userRepository: _userRepository);
                  } else if (state is AuthenticationSuccess) {
                    return BlocProvider<HomeBloc>(
                      create: (BuildContext context) => HomeBloc(),
                      child: HomeScreen(name: state.displayName),
                    );
//              HomeScreen(name: state.displayName);
                  }
                  return SplashScreen();
                },
              ),
            ),
          );
  }

  @override
  void dispose() {
    _authenticationBloc.distinct();
    super.dispose();
  }
}
