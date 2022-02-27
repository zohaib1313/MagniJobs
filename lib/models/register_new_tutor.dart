import 'package:magnijobs_rnr/dio_network/decodable.dart';

class RegisterNewTutor implements Decodable {
  String? token;
  User? user;
  Tutor? tutor;

  RegisterNewTutor({this.token, this.user, this.tutor});

  RegisterNewTutor.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tutor = json['tutor'] != null ? new Tutor.fromJson(json['tutor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tutor != null) {
      data['tutor'] = this.tutor!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tutor = json['tutor'] != null ? new Tutor.fromJson(json['tutor']) : null;
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

class Tutor {
  String? userId;
  String? company;
  String? address;
  String? idCard;
  String? updatedAt;
  String? createdAt;
  int? id;

  Tutor(
      {this.userId,
      this.company,
      this.address,
      this.idCard,
      this.updatedAt,
      this.createdAt,
      this.id});

  Tutor.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    company = json['company'];
    address = json['address'];
    idCard = json['id_card'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['company'] = this.company;
    data['address'] = this.address;
    data['id_card'] = this.idCard;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
