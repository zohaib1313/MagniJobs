import 'package:magnijobs_rnr/dio_network/decodable.dart';

class UpdateJobPost implements Decodable {
  bool? status;
  String? message;
  String? data;

  UpdateJobPost({this.status, this.message, this.data});

  UpdateJobPost.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
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
