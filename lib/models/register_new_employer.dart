import 'package:magnijobs_rnr/dio_network/decodable.dart';

class RegisterNewEmployer implements Decodable {
  bool? status;
  String? message;
  Data? data;

  RegisterNewEmployer({this.status, this.message, this.data});

  RegisterNewEmployer.fromJson(Map<String, dynamic> json) {
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
  List<String>? contactNumber;
  List<String>? contactEmail;

  Data({this.contactNumber, this.contactEmail});

  Data.fromJson(Map<String, dynamic> json) {
    contactNumber = json['contact_number'].cast<String>();
    contactEmail = json['contact_email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_number'] = this.contactNumber;
    data['contact_email'] = this.contactEmail;
    return data;
  }
}
