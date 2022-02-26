import 'package:magnijobs_rnr/dio_network/decodable.dart';

class GetJobSeekerProfile implements Decodable {
  bool? status;
  String? message;
  Data? data;

  GetJobSeekerProfile({this.status, this.message, this.data});

  GetJobSeekerProfile.fromJson(Map<String, dynamic> json) {
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
  User? user;
  Candidate? candidate;

  Data({this.user, this.candidate});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    candidate = json['candidate'] != null
        ? new Candidate.fromJson(json['candidate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.candidate != null) {
      data['candidate'] = this.candidate!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? emailVerifiedAt;
  String? utype;
  String? otp;
  int? verified;
  String? phoneVerifiedAt;
  String? verification;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.emailVerifiedAt,
      this.utype,
      this.otp,
      this.verified,
      this.phoneVerifiedAt,
      this.verification,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    utype = json['utype'];
    otp = json['otp'];
    verified = json['verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    verification = json['verification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['utype'] = this.utype;
    data['otp'] = this.otp;
    data['verified'] = this.verified;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['verification'] = this.verification;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Candidate {
  int? id;
  String? userId;
  String? address;
  String? location;
  String? dob;
  String? nationality;
  String? gender;
  String? maritalStatus;
  String? school;
  String? workExperience;
  String? certifications;
  String? exams;
  String? license;
  String? preferredLocation;
  String? uploadedDocs;
  String? resume;
  String? nurseCertificate;
  String? nationalId;
  String? businessRegistration;
  String? covidCert;
  String? potentialEmployer;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Candidate(
      {this.id,
      this.userId,
      this.address,
      this.location,
      this.dob,
      this.nationality,
      this.gender,
      this.maritalStatus,
      this.school,
      this.workExperience,
      this.certifications,
      this.exams,
      this.license,
      this.preferredLocation,
      this.uploadedDocs,
      this.resume,
      this.nurseCertificate,
      this.nationalId,
      this.businessRegistration,
      this.covidCert,
      this.potentialEmployer,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    location = json['location'];
    dob = json['dob'];
    nationality = json['nationality'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    school = json['school'];
    workExperience = json['work_experience'];
    certifications = json['certifications'];
    exams = json['exams'];
    license = json['license'];
    preferredLocation = json['preferred_location'];
    uploadedDocs = json['uploaded_docs'];
    resume = json['resume'];
    nurseCertificate = json['nurse_certificate'];
    nationalId = json['national_id'];
    businessRegistration = json['business_registration'];
    covidCert = json['covid_cert'];
    potentialEmployer = json['potential_employer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['location'] = this.location;
    data['dob'] = this.dob;
    data['nationality'] = this.nationality;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['school'] = this.school;
    data['work_experience'] = this.workExperience;
    data['certifications'] = this.certifications;
    data['exams'] = this.exams;
    data['license'] = this.license;
    data['preferred_location'] = this.preferredLocation;
    data['uploaded_docs'] = this.uploadedDocs;
    data['resume'] = this.resume;
    data['nurse_certificate'] = this.nurseCertificate;
    data['national_id'] = this.nationalId;
    data['business_registration'] = this.businessRegistration;
    data['covid_cert'] = this.covidCert;
    data['potential_employer'] = this.potentialEmployer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
