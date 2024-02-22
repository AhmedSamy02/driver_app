import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/order.dart';

class GetOrdersByVehicleId {
  GetOrdersByVehicleId._();
  static const _endpoint = 'orders';
  static final Dio _dio = Dio();
  static Future<List<Order>> getOrders(
      int limit, int offset, String vehicleId) async {
    try {
      final response = await _dio
          .get('$baseURL$_endpoint/$vehicleId?limit=$limit&offset=$offset',
              options: Options(
                  headers: {'Authorization': 'Bearer ${CurrentUser().token}'}))
          .timeout(const Duration(seconds: 10));
      final List<Order> orders = [];
      for (var order in response.data['orders']) {
        orders.add(Order.fromJson(order));
      }
      return orders;
    } on DioException catch (error) {
      throw error;
    } on TimeoutException catch (error) {
      throw error;
    }
  }
}
