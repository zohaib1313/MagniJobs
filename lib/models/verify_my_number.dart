import 'package:magnijobs_rnr/dio_network/decodable.dart';

import 'check_phone_no.dart';

class VerifyMyPhoneNumberModel implements Decodable {
  User? user;

  VerifyMyPhoneNumberModel({this.user});

  VerifyMyPhoneNumberModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    return this;
  }
}
