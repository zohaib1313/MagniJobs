import 'package:magnijobs_rnr/dio_network/decodable.dart';

class JobHistoryModel implements Decodable {
  List<Applications>? applications;

  JobHistoryModel({this.applications});

  JobHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['applications'] != null) {
      applications = <Applications>[];
      json['applications'].forEach((v) {
        applications!.add(new Applications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applications != null) {
      data['applications'] = this.applications!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['applications'] != null) {
      applications = <Applications>[];
      json['applications'].forEach((v) {
        applications!.add(new Applications.fromJson(v));
      });
    }
    return this;
  }
}

class Applications {
  int? id;
  String? jobId;
  String? userId;
  String? employerId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Applications(
      {this.id,
      this.jobId,
      this.userId,
      this.employerId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Applications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    userId = json['user_id'];
    employerId = json['employer_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['user_id'] = this.userId;
    data['employer_id'] = this.employerId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
