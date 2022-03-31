import 'package:magnijobs_rnr/dio_network/decodable.dart';

class CountryAndJobModel implements Decodable {
  List<Candidates>? candidates;

  CountryAndJobModel({this.candidates});

  CountryAndJobModel.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) {
        candidates!.add(new Candidates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.candidates != null) {
      data['candidates'] = this.candidates!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) {
        candidates!.add(new Candidates.fromJson(v));
      });
    }
    return this;
  }

  @override
  String toString() {
    return 'CountryAndJobModel{candidates: $candidates}';
  }
}

class Candidates {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  int? verified;
  int? location;
  String? dob;
  String? nationality;
  String? gender;
  String? maritalStatus;
  String? certifications;
  String? exams;
  String? workExperience;
  String? license;

  Candidates(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.address,
      this.verified,
      this.location,
      this.dob,
      this.nationality,
      this.gender,
      this.maritalStatus,
      this.certifications,
      this.exams,
      this.workExperience,
      this.license});

  Candidates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    verified = json['verified'];
    location = json['location'];
    dob = json['dob'];
    nationality = json['nationality'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    certifications = json['certifications'];
    exams = json['exams'];
    workExperience = json['work_experience'];
    license = json['license'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['verified'] = this.verified;
    data['location'] = this.location;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['certifications'] = this.certifications;
    data['exams'] = this.exams;
    data['work_experience'] = this.workExperience;
    data['license'] = this.license;
    return data;
  }
}
