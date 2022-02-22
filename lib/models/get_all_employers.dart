import 'package:magnijobs_rnr/dio_network/decodable.dart';

class GetAllEmployers implements Decodable {
  bool? status;
  String? message;
  Data? data;

  GetAllEmployers({this.status, this.message, this.data});

  GetAllEmployers.fromJson(Map<String, dynamic> json) {
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
  List<Employers>? employers;

  Data({this.employers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['employers'] != null) {
      employers = <Employers>[];
      json['employers'].forEach((v) {
        employers!.add(new Employers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employers != null) {
      data['employers'] = this.employers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employers {
  int? id;
  String? companyName;

  Employers({this.id, this.companyName});

  Employers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    return data;
  }
}
