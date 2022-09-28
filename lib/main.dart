import 'package:flutter/material.dart';
import 'package:immence_app/screens/login_screen.dart';
import 'package:immence_app/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Immence',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
