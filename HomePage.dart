import 'package:flutter/material.dart';
import 'package:messenger/services_or_auth/authService.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //sign user out
  void signOut(){
    //get auth Service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home'),
        backgroundColor: Colors.black12,
        actions: [
          //sign out button
          IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
