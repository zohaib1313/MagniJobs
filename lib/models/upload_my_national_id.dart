import 'package:magnijobs_rnr/dio_network/decodable.dart';

class UploadMyNatioanlId implements Decodable {
  bool? status;
  String? message;
  Data? data;

  UploadMyNatioanlId({this.status, this.message, this.data});

  UploadMyNatioanlId.fromJson(Map<String, dynamic> json) {
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
  List<String>? nationalId;

  Data({this.nationalId});

  Data.fromJson(Map<String, dynamic> json) {
    nationalId = json['national_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['national_id'] = this.nationalId;
    return data;
  }
}
