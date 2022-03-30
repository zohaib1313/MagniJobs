import 'package:magnijobs_rnr/dio_network/decodable.dart';

class CountriesModel implements Decodable {
  List<Countries>? countries = [];

  CountriesModel({this.countries});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountriesModel &&
          runtimeType == other.runtimeType &&
          countries == other.countries;

  @override
  int get hashCode => countries.hashCode;
}

class Countries {
  int? id;
  String? code;
  String? name;

  // Null? createdAt;
  // Null? updatedAt;

  Countries({this.id, this.code, this.name /*, this.createdAt, this.updatedAt*/
      });

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    // createdAt = json['created_at'];
    //updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    //  data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Countries &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ code.hashCode ^ name.hashCode;
}
