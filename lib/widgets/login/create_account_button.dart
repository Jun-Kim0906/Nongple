import 'package:flutter/material.dart';
import 'package:nongple/data_repository/user_repository/user_repository.dart';
import 'package:nongple/screens/register/register_screen.dart';
import 'package:nongple/widgets/register/register.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        '아직 회원이 아니신가요?',
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[700]),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
