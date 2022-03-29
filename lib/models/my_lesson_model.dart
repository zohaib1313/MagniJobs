import 'package:magnijobs_rnr/dio_network/decodable.dart';

class MyLessonModel implements Decodable {
  List<Bookings>? bookings;

  MyLessonModel({this.bookings});

  MyLessonModel.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Bookings.fromJson(v));
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
  String? lessonId;
  String? userId;
  String? notes;
  String? createdAt;
  String? updatedAt;

  Bookings(
      {this.id,
      this.lessonId,
      this.userId,
      this.notes,
      this.createdAt,
      this.updatedAt});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['lesson_id'];
    userId = json['user_id'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lesson_id'] = this.lessonId;
    data['user_id'] = this.userId;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
