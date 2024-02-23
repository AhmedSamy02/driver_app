import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

const kLoginScreen = 'login_screen';
const kHomeScreen = 'home_screen';
const kSplashScreen = 'splash_screen';
const kOrderListScreen = 'order_list_screen';
const kOrderScreen = 'order_screen';
const kQrScreen = 'qr_screen';
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

Map<String, Color> orderStatus(String status) {
  //? Charachter and its color - String and button color
  switch (status) {
    case 'Pending':
      return {'P': Colors.grey, 'Start': Colors.blueAccent[700]!};
    case 'Completed':
      return {'C': kCompletedColor, 'Review': kCompletedColor};
    case 'Failed':
      return {'F': kFailedColor, 'Review': kFailedColor};
    default:
      return {'W': kWorkingColor, 'Details': Colors.yellow[800]!};
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, 
      ),
);
