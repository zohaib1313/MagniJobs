import 'package:magnijobs_rnr/dio_network/decodable.dart';

class AllLessonsModel implements Decodable {
  List<Lessons>? lessons;

  AllLessonsModel({this.lessons});

  AllLessonsModel.fromJson(Map<String, dynamic> json) {
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  decode(json) {
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
    return this;
  }
}

class Lessons {
  int? id;
  String? category;
  String? lesson;
  String? description;
  String? lessonDate;
  String? lessonTime;
  String? createdAt;
  String? updatedAt;
  String? meeting_link;

  Lessons(
      {this.id,
      this.category,
      this.lesson,
      this.description,
      this.lessonDate,
      this.lessonTime,
      this.createdAt,
      this.meeting_link,
      this.updatedAt});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    lesson = json['lesson'];
    description = json['description'];
    lessonDate = json['lesson_date'];
    lessonTime = json['lesson_time'];
    meeting_link = json['meeting_link'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['lesson'] = this.lesson;
    data['description'] = this.description;
    data['lesson_date'] = this.lessonDate;
    data['lesson_time'] = this.lessonTime;
    data['created_at'] = this.createdAt;
    data['meeting_link'] = this.meeting_link;

    data['updated_at'] = this.updatedAt;
    return data;
  }
}
