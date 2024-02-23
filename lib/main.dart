import 'package:driver_app/constants.dart';
import 'package:driver_app/views/home_screen.dart';
import 'package:driver_app/views/login_screen.dart';
import 'package:driver_app/views/order_list_screen.dart';
import 'package:driver_app/views/order_screen.dart';
import 'package:driver_app/views/qr_scan_screen.dart';
import 'package:driver_app/views/splash_screen.dart';
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
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      initialRoute: kSplashScreen,
      routes: {
        kSplashScreen: (context) => const SplashScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case kHomeScreen:
            return PageTransition(
                duration: const Duration(milliseconds: 600),
                child: const HomeScreen(),
                type: PageTransitionType.fade);
          case kLoginScreen:
            return PageTransition(
                duration: const Duration(milliseconds: 1000),
                child: const LoginScreen(),
                type: PageTransitionType.fade);
          case kOrderListScreen:
            return PageTransition(
                duration: const Duration(milliseconds: 600),
                child: const OrderListScreen(),
                settings: settings,
                type: PageTransitionType.rightToLeftWithFade);
          case kOrderScreen:
            return PageTransition(
                duration: const Duration(milliseconds: 600),
                child: const OrderScreen(),
                settings: settings,
                type: PageTransitionType.fade);
          
          case kQrScreen:
            return PageTransition(
                duration: const Duration(milliseconds: 600),
                child: const QrScanScreen(),
                settings: settings,
                type: PageTransitionType.fade);
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
