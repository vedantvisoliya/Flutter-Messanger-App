import 'package:flutter/material.dart';
import 'package:message_app/pages/auth%20pages/login_page.dart';
import 'package:message_app/pages/auth%20pages/signup_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool isLoginPage = true;

  void togglePages() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    if (isLoginPage) {
      return LoginPage(
        togglePages: togglePages,
      );
    }
    else {
      return SignupPage(
        togglePages: togglePages,
      );
    }
  }
}