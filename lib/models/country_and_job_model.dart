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

  @override
  String toString() {
    return 'Candidates{id: $id, firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, address: $address, location: $location, dob: $dob, nationality: $nationality, gender: $gender, maritalStatus: $maritalStatus}';
  }
}
