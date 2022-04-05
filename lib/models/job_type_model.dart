import 'package:magnijobs_rnr/dio_network/decodable.dart';

class JobTypeModel implements Decodable {
  List<Jobtypes>? jobtypes;

  JobTypeModel({this.jobtypes});

  JobTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['jobtypes'] != null) {
      jobtypes = <Jobtypes>[];
      json['jobtypes'].forEach((v) {
        jobtypes!.add(new Jobtypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobtypes != null) {
      data['jobtypes'] = this.jobtypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['jobtypes'] != null) {
      jobtypes = <Jobtypes>[];
      json['jobtypes'].forEach((v) {
        jobtypes!.add(new Jobtypes.fromJson(v));
      });
    }
    return this;
  }
}

class Jobtypes {
  int? id;
  String? jobType;
  String? createdAt;
  String? updatedAt;

  Jobtypes({this.id, this.jobType, this.createdAt, this.updatedAt});

  Jobtypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobType = json['job_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_type'] = this.jobType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
