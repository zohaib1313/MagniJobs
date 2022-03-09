import 'package:magnijobs_rnr/dio_network/decodable.dart';

class CandidateSignInModel implements Decodable {
  String? token;
  User? user;
  CandidateModel? candidateModel;

  CandidateSignInModel({this.token, this.user, this.candidateModel});

  CandidateSignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    candidateModel = json['candidate'] != null
        ? CandidateModel.fromJson(json['candidate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.candidateModel != null) {
      data['candidate'] = this.candidateModel!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    candidateModel = json['candidate'] != null
        ? CandidateModel.fromJson(json['candidate'])
        : null;
    return this;
  }

  @override
  String toString() {
    return 'CandidateSignInModel{token: $token, user: $user, candidateModel: $candidateModel}';
  }
}

class EmployerSignInModel implements Decodable {
  String? token;
  User? user;
  EmployerModel? employerModel;

  EmployerSignInModel({this.token, this.user, this.employerModel});

  EmployerSignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    employerModel = json['employer'] != null
        ? EmployerModel.fromJson(json['employer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.employerModel != null) {
      data['employer'] = this.employerModel!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    employerModel = json['employer'] != null
        ? EmployerModel.fromJson(json['employer'])
        : null;
    return this;
  }

  @override
  String toString() {
    return 'EmployerSignInModel{token: $token, user: $user, employerModel: $employerModel}';
  }
}

class TutorSignInModel implements Decodable {
  String? token;
  User? user;
  TutorModel? tutorModel;

  TutorSignInModel({this.token, this.user, this.tutorModel});

  TutorSignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tutorModel =
        json['tutor'] != null ? TutorModel.fromJson(json['tutor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tutorModel != null) {
      data['tutor'] = this.tutorModel!.toJson();
    }
    return data;
  }

  @override
  decode(json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tutorModel =
        json['tutor'] != null ? TutorModel.fromJson(json['tutor']) : null;
    return this;
  }

  @override
  String toString() {
    return 'TutorSignInModel{token: $token, user: $user, tutorModel: $tutorModel}';
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
  String? profile;

  User(
      {this.id,
      this.name,
      this.firstName,
      this.profile,
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
    profile = json['profile'];
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
    data['profile'] = this.profile;
    data['verified'] = this.verified;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['verification'] = this.verification;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, firstName: $firstName, lastName: $lastName, email: $email, mobile: $mobile, emailVerifiedAt: $emailVerifiedAt, utype: $utype, otp: $otp, verified: $verified, phoneVerifiedAt: $phoneVerifiedAt, verification: $verification, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt}';
  }
}

class CandidateModel {
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

  CandidateModel(
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

  CandidateModel.fromJson(Map<String, dynamic> json) {
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

class EmployerModel {
  int? id;
  String? userId;
  String? fullName;
  String? companyName;
  String? address;
  String? contactNumber;
  String? email;
  String? contactEmail;
  bool? status;
  String? website;
  String? location;
  String? logo;
  String? createdAt;
  String? updatedAt;

  EmployerModel(
      {this.id,
      this.userId,
      this.fullName,
      this.companyName,
      this.address,
      this.contactNumber,
      this.email,
      this.contactEmail,
      this.status,
      this.website,
      this.location,
      this.logo,
      this.createdAt,
      this.updatedAt});

  EmployerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    companyName = json['company_name'];
    address = json['address'];
    contactNumber = json['contact_number'];
    email = json['email'];
    contactEmail = json['contact_email'];
    status = json['status'];
    website = json['website'];
    location = json['location'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['contact_email'] = this.contactEmail;
    data['status'] = this.status;
    data['website'] = this.website;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TutorModel {
  String? userId;
  String? company;
  String? address;
  String? idCard;
  String? updatedAt;
  String? createdAt;
  int? id;

  TutorModel(
      {this.userId,
      this.company,
      this.address,
      this.idCard,
      this.updatedAt,
      this.createdAt,
      this.id});

  TutorModel.fromJson(Map<String, dynamic> json) {
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
