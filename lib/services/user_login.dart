import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver_app/helpers/current_user.dart';

import '../constants.dart';

class UserLogin {
  UserLogin._();
  static final instance = UserLogin._();
  static const _endpoint = 'login';
  static final _dio = Dio();
  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio.post(baseURL + _endpoint, data: {
        'email': email,
        'password': password,
      }).timeout(const Duration(seconds: 10));

      CurrentUser().setUser(
        id: response.data['id'],
        name: response.data['name'],
        email: response.data['email'],
        username: response.data['username'],
        token: response.data['token'],
      );
      return response.data['status'];
    } on DioException catch (e) {
      return e.response!.data['message'];
    } on TimeoutException {
      return 'Connection timeout Please check your internet connection';
    }
  }
}
