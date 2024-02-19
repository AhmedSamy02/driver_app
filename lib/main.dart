import 'package:driver_app/constants.dart';
import 'package:driver_app/views/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: kLoginScreen,
      routes: {
        kLoginScreen: (context) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
