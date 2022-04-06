import 'package:magnijobs_rnr/dio_network/decodable.dart';

class CountJobModel implements Decodable {
  int? jobs;
  dynamic? elegibility;

  CountJobModel({this.jobs, this.elegibility});

  CountJobModel.fromJson(Map<String, dynamic> json) {
    jobs = json['jobs'];
    elegibility = json['elegibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobs'] = this.jobs;
    data['elegibility'] = this.elegibility;
    return data;
  }

  @override
  decode(json) {
    jobs = json['jobs'];
    elegibility = json['elegibility'];
    return this;
  }
}
