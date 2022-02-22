import 'package:magnijobs_rnr/dio_network/decodable.dart';

class GetMyProfile implements Decodable {
  bool? status;
  String? message;
  Data? data;

  GetMyProfile({this.status, this.message, this.data});

  GetMyProfile.fromJson(Map<String, dynamic> json) {
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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return this;
  }
}

class Data {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  Null? emailVerifiedAt;
  String? utype;
  Null? otp;
  int? verified;
  Null? phoneVerifiedAt;
  Null? verification;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Data(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.emailVerifiedAt,
      this.utype,
      this.otp,
      this.verified,
      this.phoneVerifiedAt,
      this.verification,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    utype = json['utype'];
    otp = json['otp'];
    verified = json['verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    verification = json['verification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['utype'] = this.utype;
    data['otp'] = this.otp;
    data['verified'] = this.verified;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['verification'] = this.verification;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
