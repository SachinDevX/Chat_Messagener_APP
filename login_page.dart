import 'package:flutter/material.dart';
import 'package:messenger/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //logo
              Icon(Icons.message,
                size: 80,
                  color: Colors.grey[800],
              ),
              const SizedBox(height: 50),

              //welcome back message
              const Text("Welcome Back You Been Missed!",
                style: TextStyle(
                  fontSize: 16,
                ),//textStyle
                  ),//Text

              const SizedBox(height: 25),

              //email textfield

              MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
              ),
              const SizedBox(height: 10),

              //password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              //sign in button

              //not a member ? register now

            ],
          ),
        ),
      ),
    );
  }
}
