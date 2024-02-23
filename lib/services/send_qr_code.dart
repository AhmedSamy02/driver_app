import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver_app/constants.dart';
import 'package:driver_app/helpers/current_user.dart';

class SendQrCode {
  SendQrCode._();
  static const _endpoint = 'order/qr';
  static final _dio = Dio();
  static Future<String> sendQrCode({
    required String qrCode,
    required String vehicleId,
    required String orderId,
  }) async {
    try {
      await _dio.post(baseURL + _endpoint,
          data: {
            'value': qrCode,
            'vehicleId': vehicleId,
            'orderId': orderId,
          },
          options: Options(
              headers: {'Authorization': 'Bearer ${CurrentUser().token}'}));
              return 'Success';
    } on DioException catch (e) {
      logger.e(e.error);
      return e.response!.data['message'];
    } on TimeoutException {
      return 'Connection timeout Please check your internet connection';
    }
  }
}
