import 'package:magnijobs_rnr/dio_network/decodable.dart';

class UploadMyBusinessRegistrationDocument implements Decodable {
  bool? status;
  String? message;
  Data? data;

  UploadMyBusinessRegistrationDocument({this.status, this.message, this.data});

  UploadMyBusinessRegistrationDocument.fromJson(Map<String, dynamic> json) {
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
  decode(json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    return this;
  }
}

class Data {
  List<String>? businessRegistration;

  Data({this.businessRegistration});

  Data.fromJson(Map<String, dynamic> json) {
    businessRegistration = json['business_registration'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_registration'] = this.businessRegistration;
    return data;
  }
}
