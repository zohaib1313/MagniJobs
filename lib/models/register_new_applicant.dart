import 'package:magnijobs_rnr/dio_network/decodable.dart';

class RegisterNewApplicant implements Decodable {
  bool? status;
  String? message;
  Data? data;

  RegisterNewApplicant({this.status, this.message, this.data});

  RegisterNewApplicant.fromJson(Map<String, dynamic> json) {
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
    data = data['data'];
    return this;
  }
}

class Data {
  List<String>? email;
  List<String>? nationalId;

  Data({this.email, this.nationalId});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    nationalId = json['national_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['national_id'] = this.nationalId;
    return data;
  }
}
