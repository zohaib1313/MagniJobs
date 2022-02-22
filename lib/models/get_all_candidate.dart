import 'package:magnijobs_rnr/dio_network/decodable.dart';

class GetAllCandidate implements Decodable {
  bool? status;
  String? message;
  Data? data;

  GetAllCandidate({this.status, this.message, this.data});

  GetAllCandidate.fromJson(Map<String, dynamic> json) {
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
  List<Candidates>? candidates;

  Data({this.candidates});

  Data.fromJson(Map<String, dynamic> json) {
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
}

class Candidates {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? location;
  String? dob;
  String? nationality;
  String? gender;
  String? maritalStatus;

  Candidates(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.address,
      this.location,
      this.dob,
      this.nationality,
      this.gender,
      this.maritalStatus});

  Candidates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    location = json['location'];
    dob = json['dob'];
    nationality = json['nationality'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['location'] = this.location;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    return data;
  }
}
