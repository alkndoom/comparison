import 'package:comparison/app2/screens/auth_screen/sign_in_screen.dart';
import 'package:comparison/app2/screens/auth_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? SignInScreen(onClickedSignUp: toggle)
        : SignUpScreen(onClickedSignIn: toggle);
  }
}
