import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/firebase_options.dart';
import 'package:messenger/services_or_auth/authService.dart';
import 'package:messenger/services_or_auth/auth_gate.dart';
import 'package:messenger/services_or_auth/login_or_Register.dart';
import 'package:provider/provider.dart';


void main() async{
  runApp(
      ChangeNotifierProvider(
          create:(context) => AuthService(),
        child: const MyApp(),
      )
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
