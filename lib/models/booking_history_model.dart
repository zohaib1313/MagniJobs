import 'package:magnijobs_rnr/dio_network/decodable.dart';

class BookingHistoryModel implements Decodable {
  List<Bookings>? bookings;

  BookingHistoryModel({this.bookings});

  BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Bookings.fromJson(v));
      });
    }
    return this;
  }
}

class Bookings {
  int? id;
  String? user;
  String? date;
  String? examType;
  String? examSubType;
  String? time;
  String? createdAt;
  String? updatedAt;

  Bookings(
      {this.id,
      this.user,
      this.date,
      this.examType,
      this.examSubType,
      this.time,
      this.createdAt,
      this.updatedAt});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    date = json['date'];
    examType = json['exam_type'];
    examSubType = json['exam_sub_type'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['date'] = this.date;
    data['exam_type'] = this.examType;
    data['exam_sub_type'] = this.examSubType;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
