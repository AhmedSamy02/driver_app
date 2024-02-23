import 'package:flutter/material.dart';

const kLoginScreen = 'login_screen';
const kHomeScreen = 'home_screen';
const kSplashScreen = 'splash_screen';
const kOrderListScreen = 'order_list_screen';
const kOrderScreen = 'order_screen';
const kWorkingColor = Color(0xFFD6C423);
const kCompletedColor = Color(0xFF12CE3B);
const kFailedColor = Color(0xFFF00D0D);
const baseURL = 'http://10.0.2.2:3001/';
bool validateEmail(String text) {
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text)) {
    return true;
  } else {
    return false;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
