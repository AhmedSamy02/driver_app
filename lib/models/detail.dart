class Detail {
  String? status;
  String? estimatedD;
  String? estimatedA;
  String? actualD;
  String? actualA;
  String? duration;
  String? message;

  Detail({
    this.status,
    this.estimatedD,
    this.estimatedA,
    this.actualD,
    this.actualA,
    this.duration,
    this.message,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      status: json['status'],
      estimatedD: json['estimatedD'],
      estimatedA: json['estimatedA'],
      actualD: json['actualD'],
      actualA: json['actualA'],
      duration: json['duration'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
