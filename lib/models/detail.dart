import 'package:driver_app/constants.dart';
import 'package:intl/intl.dart';

class Detail {
  String? mainStatus;
  String? status;
  String? estimatedD;
  String? estimatedA;
  String? actualD;
  String? actualA;
  String? duration;
  String? message;

  Detail({
    this.mainStatus,
    this.status,
    this.estimatedD,
    this.estimatedA,
    this.actualD,
    this.actualA,
    this.duration,
    this.message,
  });

  factory Detail.fromJson(Map<String, dynamic> json, {String? mainStatus}) {
    return Detail(
      mainStatus: mainStatus,
      status: json['status'],
      estimatedD: json['estimatedD'] == null
          ? null
          : DateFormat('E,d MMM yyyy HH:mm a')
              .format(DateTime.parse(json['estimatedD'])),
      estimatedA: json['estimatedA'] == null
          ? null
          : DateFormat('E,d MMM yyyy HH:mm a')
              .format(DateTime.parse(json['estimatedA'])),
      actualD: json['actualD'] == null
          ? null
          : DateFormat('E,d MMM yyyy HH:mm a')
              .format(DateTime.parse(json['actualD'])),
      actualA: json['actualA'] == null
          ? null
          : DateFormat('E,d MMM yyyy HH:mm a')
              .format(DateTime.parse(json['actualA'])),
      duration: json['duration'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mainStatus': mainStatus,
      'status': status,
      'estimatedD': estimatedD,
      'estimatedA': estimatedA,
      'actualD': actualD,
      'actualA': actualA,
      'duration': duration,
      'message': message,
    };
  }
}
