import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nongple/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nongple/data_repository/user_repository/user_repository.dart';
import 'package:nongple/screens/screens.dart';
import 'blocs/blocs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashScreen();
          }
          else if (state is AuthenticationFailure) {
            return LoginScreen(userRepository: _userRepository);
          }
          else if (state is AuthenticationSuccess) {
            return HomeScreen(name: state.displayName);
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
