import 'package:driver_app/constants.dart';
import 'package:driver_app/views/home_screen.dart';
import 'package:driver_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      initialRoute: kLoginScreen,
      routes: {
        kLoginScreen: (context) => const LoginScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case kHomeScreen:
            return PageTransition(
                duration: const Duration(milliseconds: 600),
                child: const HomeScreen(),
                type: PageTransitionType.fade);
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
