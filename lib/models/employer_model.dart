import 'package:magnijobs_rnr/dio_network/decodable.dart';

class EmployerSignUpModel implements Decodable {
  String? token;
  User? user;
  Employer? employer;

  EmployerSignUpModel({this.token, this.user, this.employer});

  EmployerSignUpModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    employer = json['employer'] != null
        ? new Employer.fromJson(json['employer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.employer != null) {
      data['employer'] = this.employer!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    employer = json['employer'] != null
        ? new Employer.fromJson(json['employer'])
        : null;
    return this;
  }
}

class User {
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? utype;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.utype,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    utype = json['utype'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['utype'] = this.utype;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Employer {
  String? userId;
  String? address;
  String? location;
  String? fullName;
  String? companyName;
  String? contactNumber;
  String? email;
  String? contactEmail;
  bool? status;
  String? website;
  Null? logo;
  String? updatedAt;
  String? createdAt;
  int? id;

  Employer(
      {this.userId,
      this.address,
      this.location,
      this.fullName,
      this.companyName,
      this.contactNumber,
      this.email,
      this.contactEmail,
      this.status,
      this.website,
      this.logo,
      this.updatedAt,
      this.createdAt,
      this.id});

  Employer.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    address = json['address'];
    location = json['location'];
    fullName = json['full_name'];
    companyName = json['company_name'];
    contactNumber = json['contact_number'];
    email = json['email'];
    contactEmail = json['contact_email'];
    status = json['status'];
    website = json['website'];
    logo = json['logo'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['location'] = this.location;
    data['full_name'] = this.fullName;
    data['company_name'] = this.companyName;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['contact_email'] = this.contactEmail;
    data['status'] = this.status;
    data['website'] = this.website;
    data['logo'] = this.logo;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
