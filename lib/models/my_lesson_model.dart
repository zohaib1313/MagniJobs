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
  String? userId;
  String? notes;
  String? category;
  String? description;
  String? lessonDate;
  String? lessonTime;
  String? meetingLink;

  Bookings(
      {this.id,
      this.userId,
      this.notes,
      this.category,
      this.description,
      this.lessonDate,
      this.lessonTime,
      this.meetingLink});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    notes = json['notes'];
    category = json['category'];
    description = json['description'];
    lessonDate = json['lesson_date'];
    lessonTime = json['lesson_time'];
    meetingLink = json['meeting_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['notes'] = this.notes;
    data['category'] = this.category;
    data['description'] = this.description;
    data['lesson_date'] = this.lessonDate;
    data['lesson_time'] = this.lessonTime;
    data['meeting_link'] = this.meetingLink;
    return data;
  }
}
