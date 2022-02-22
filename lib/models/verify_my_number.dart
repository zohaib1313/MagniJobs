import 'package:magnijobs_rnr/dio_network/decodable.dart';

class VerifyMyPhoneNumber extends Decodable {
  bool? status;
  String? message;
  Data? data;

  VerifyMyPhoneNumber({this.status, this.message, this.data});

  VerifyMyPhoneNumber.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  decode(data) {
    status = data['status'];
    message = data['message'];
    data = data['data'] != null ? new Data.fromJson(data['data']) : null;
    return this;
  }
}

class Data {
  List<String>? otp;

  Data({this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    return data;
  }
}
