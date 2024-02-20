import 'dart:async';

import 'package:dio/dio.dart';

import '../constants.dart';

class UserLogin {
  UserLogin._();
  static final instance = UserLogin._();
  static const String _endpoint = 'login';
  static final Dio _dio = Dio();
  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio.post(baseURL + _endpoint, data: {
        'email': email,
        'password': password,
      }).timeout(const Duration(seconds: 10));
      return response.data['status'];
    } on DioException catch (e) {
      return e.response!.data['message'];
    } on TimeoutException {
      return 'Connection timeout Please check your internet connection';
    }
  }
}
