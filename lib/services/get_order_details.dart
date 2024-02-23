import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';
import 'package:driver_app/models/detail.dart';

class GetOrderDetails {
  GetOrderDetails._();
  static final Dio _dio = Dio();
  static final _endpoint = '/order';
  static Future<List<Detail>> getOrderDetails(
    String orderId,
    String vehicleId,
  ) async {
    try {
      final response = await _dio
          .get('$baseURL$_endpoint',
              data: {
                'orderId': orderId,
                'vehicleId': vehicleId,
              },
              options: Options(
                  headers: {'Authorization': 'Bearer ${CurrentUser().token}'}))
          .timeout(const Duration(seconds: 10));
      final List<Detail> data = [];
      response.data['details'].forEach((item) => {data.add(Detail.fromJson(item,mainStatus: response.data['mainStatus']))});
      return data;
    } on DioException catch (error) {
      logger.e('message: ${error.toString()}');
      throw error;
    } on TimeoutException catch (error) {
      throw error;
    } catch (error) {
      logger.e('message: ${error.toString()}');
      throw error;
    }
  }
}
