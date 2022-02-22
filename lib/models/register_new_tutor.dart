import 'dart:convert';

import 'package:magnijobs_rnr/dio_network/decodable.dart';

class RegisterNewTutor implements Decodable {
  bool? status;
  String? message;
  Data? data;

  RegisterNewTutor({this.status, this.message, this.data});

  RegisterNewTutor.fromJson(Map<String, dynamic> json) {
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
  List<String>? email;
  List<String>? mobile;
  List<String>? idCard;

  Data({this.email, this.mobile, this.idCard});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    mobile = json['mobile'].cast<String>();
    idCard = json['id_card'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['id_card'] = this.idCard;
    return data;
  }
}
