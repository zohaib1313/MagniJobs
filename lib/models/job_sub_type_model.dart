import 'package:magnijobs_rnr/dio_network/decodable.dart';

class JobSubTypeModel implements Decodable {
  List<Jobsubtypes>? jobsubtypes;

  JobSubTypeModel({this.jobsubtypes});

  JobSubTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['jobsubtypes'] != null) {
      jobsubtypes = <Jobsubtypes>[];
      json['jobsubtypes'].forEach((v) {
        jobsubtypes!.add(new Jobsubtypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobsubtypes != null) {
      data['jobsubtypes'] = this.jobsubtypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['jobsubtypes'] != null) {
      jobsubtypes = <Jobsubtypes>[];
      json['jobsubtypes'].forEach((v) {
        jobsubtypes!.add(new Jobsubtypes.fromJson(v));
      });
    }
    return this;
  }
}

class Jobsubtypes {
  int? id;
  String? jobType;
  int? typeId;
  String? subtype;

  Jobsubtypes({this.id, this.jobType, this.typeId, this.subtype});

  Jobsubtypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobType = json['job_type'];
    typeId = json['type_id'];
    subtype = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_type'] = this.jobType;
    data['type_id'] = this.typeId;
    data['subtype'] = this.subtype;
    return data;
  }
}
