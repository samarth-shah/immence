import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:immence_app/component/utils.dart';
import 'package:immence_app/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Immence',
      scaffoldMessengerKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
