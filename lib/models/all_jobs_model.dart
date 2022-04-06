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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllJobsModel &&
          runtimeType == other.runtimeType &&
          jobs == other.jobs;

  @override
  int get hashCode => jobs.hashCode;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobsA && runtimeType == other.runtimeType && jobs == other.jobs;

  @override
  int get hashCode => jobs.hashCode;
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
  String? due_date;
  int? verified;
  dynamic country;

  Jobs(
      {this.id,
      this.poster,
      this.employer,
      this.verified,
      this.job,
      this.location,
      this.salary,
      this.due_date,
      this.qualification,
      this.jobDescription,
      this.createdAt,
      this.updatedAt,
      this.country,
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
    country = json['country'];
    due_date = json['due_date'];
    verified = json['verified'];
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
    data['country'] = this.country;
    data['due_date'] = this.due_date;
    data['verified'] = this.verified;

    return data;
  }

  @override
  String toString() {
    return 'Jobs{id: $id, poster: $poster, employer: $employer, job: $job, location: $location, salary: $salary, qualification: $qualification, jobDescription: $jobDescription, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, due_date: $due_date, country: $country}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Jobs &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          poster == other.poster &&
          employer == other.employer &&
          job == other.job &&
          location == other.location &&
          salary == other.salary &&
          qualification == other.qualification &&
          jobDescription == other.jobDescription &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          deletedAt == other.deletedAt &&
          due_date == other.due_date &&
          country == other.country;

  @override
  int get hashCode =>
      id.hashCode ^
      poster.hashCode ^
      employer.hashCode ^
      job.hashCode ^
      location.hashCode ^
      salary.hashCode ^
      qualification.hashCode ^
      jobDescription.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode ^
      due_date.hashCode ^
      country.hashCode;
}
