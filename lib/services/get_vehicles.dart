import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/vehicle.dart';

class GetVehicles {
  GetVehicles._();
  static const _endpoint = 'vehicle/';
  static final _dio = Dio();
  static Future<List<Vehicle>> getVehicles(int limit, int offset) async {
    try {
      var response =
          await _dio.get('$baseURL$_endpoint?limit=$limit&offset=$offset',
              options: Options(
                headers: {'Authorization': 'Bearer ${CurrentUser().token}'},
              ));
      List<Vehicle> list = [];
      response.data['vehicles'].forEach((e) {
        list.add(Vehicle.fromJson(e));
      });
      return list;
    } on DioException catch (e) {
      throw e.response!.data['message'];
    } on TimeoutException {
      throw 'Connection timeout Please check your internet connection';
    }
  }
}
