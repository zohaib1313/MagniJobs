import 'package:magnijobs_rnr/dio_network/decodable.dart';

class AllJobsModel implements Decodable {
  JobsA? jobs;

  AllJobsModel({this.jobs});

  AllJobsModel.fromJson(Map<String, dynamic> json) {
    jobs = json['jobs'] != null ? new JobsA.fromJson(json['jobs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    jobs = json['jobs'] != null ? new JobsA.fromJson(json['jobs']) : null;
    return this;
  }
}

class JobsA implements Decodable {
  List<Jobs>? jobs;

  JobsA({this.jobs});

  JobsA.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
    return this;
  }
}

class Jobs {
  int? id;
  String? poster;
  dynamic employer;
  String? job;
  String? location;
  String? salary;
  String? qualification;
  String? jobDescription;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Jobs(
      {this.id,
      this.poster,
      this.employer,
      this.job,
      this.location,
      this.salary,
      this.qualification,
      this.jobDescription,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poster = json['poster'];
    employer = json['employer'];
    job = json['job'];
    location = json['location'];
    salary = json['salary'];
    qualification = json['qualification'];
    jobDescription = json['job_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['poster'] = this.poster;
    data['employer'] = this.employer;
    data['job'] = this.job;
    data['location'] = this.location;
    data['salary'] = this.salary;
    data['qualification'] = this.qualification;
    data['job_description'] = this.jobDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
