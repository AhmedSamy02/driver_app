import 'dart:async';

import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? nextScreen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('token')) {
        nextScreen = kHomeScreen;
        CurrentUser().id=prefs.getString('id');
        CurrentUser().name=prefs.getString('name');
        CurrentUser().email=prefs.getString('email');
        CurrentUser().username=prefs.getString('username');
        CurrentUser().token=prefs.getString('token');
      } else {
        nextScreen = kLoginScreen;
      }
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, nextScreen!),
      );
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFF0047FF), Color(0xFF00B3EC)],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: SvgPicture.asset('assets/images/login.svg'),
          ),
        ),
      ),
    );
  }
}
