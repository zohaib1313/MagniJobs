import 'package:magnijobs_rnr/dio_network/decodable.dart';

class AllEmployersModel implements Decodable {
  List<Employers>? employers;

  AllEmployersModel({this.employers});

  AllEmployersModel.fromJson(Map<String, dynamic> json) {
    if (json['employers'] != null) {
      employers = <Employers>[];
      json['employers'].forEach((v) {
        employers!.add(new Employers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employers != null) {
      data['employers'] = this.employers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['employers'] != null) {
      employers = <Employers>[];
      json['employers'].forEach((v) {
        employers!.add(new Employers.fromJson(v));
      });
    }
    return this;
  }

  @override
  String toString() {
    return 'AllEmployersModel{employers: $employers}';
  }
}

class Employers {
  int? id;
  String? companyName;

  Employers({this.id, this.companyName});

  Employers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    return data;
  }

  @override
  String toString() {
    return 'Employers{id: $id, companyName: $companyName}';
  }
}
