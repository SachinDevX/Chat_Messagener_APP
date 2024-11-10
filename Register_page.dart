import 'package:flutter/material.dart';
import 'package:messenger/components/my_button.dart';
import 'package:messenger/components/my_text_field.dart';
import 'package:messenger/services_or_auth/authService.dart';
import 'package:provider/provider.dart';
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  //sign up user
  void signUp() async {
    if (passwordController.text != ConfirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      print('Attempting to sign up with email: ${emailController.text}');
      await authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      print('Sign up successful');
    } catch (e) {
      print('Error during sign up: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                //logo
                Icon(Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 50),

                //create account message
                const Text(
                  "Lets create an account for you!",
                  style: TextStyle(
                    fontSize: 16,
                  ),//textStyle
                ),//Text

                const SizedBox(height: 25),

                //email text field

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                //password text field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                //confirm password
                MyTextField(
                  controller: ConfirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),


                //sign in button
                MyButton(onTap: signUp,
                    text: "Sign Up"),
                const SizedBox(height: 50),

                //not a member ? register now
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a Member ?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Login now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    )

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
