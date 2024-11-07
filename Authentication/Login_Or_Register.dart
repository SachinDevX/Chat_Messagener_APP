import 'package:flutter/material.dart';
import 'package:messenger/main.dart';
import 'package:messenger/pages/Register_page.dart';
import 'package:messenger/pages/login_page.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  @override
  //initially show the login screen
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages);
    }else{
      return RegisterPage(onTap: togglePages);
    }
  }
}
