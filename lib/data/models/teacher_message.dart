// To parse this JSON data, do
//
//     final teacherMessageModel = teacherMessageModelFromJson(jsonString);

import 'dart:convert';

List<TeacherMessageModel> teacherMessageModelFromJson(String str) =>
    List<TeacherMessageModel>.from(
        json.decode(str).map((x) => TeacherMessageModel.fromJson(x)));

String teacherMessageModelToJson(List<TeacherMessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherMessageModel {
  final String content;
  final String date;
  final DivisionName divisionName;
  final String link;
  final String messageId;
  final Subject subject;
  final TeacherName teacherName;
  final String teacherUserId;
  final String time;
  final MessageType type;

  TeacherMessageModel({
    required this.content,
    required this.date,
    required this.divisionName,
    required this.link,
    required this.messageId,
    required this.subject,
    required this.teacherName,
    required this.teacherUserId,
    required this.time,
    required this.type,
  });

  factory TeacherMessageModel.fromJson(Map<String, dynamic> json) =>
      TeacherMessageModel(
        content: json["content"],
        date: json["date"],
        divisionName: divisionNameValues.map[json["division_name"]]!,
        link: json["link"],
        messageId: json["message_id"],
        subject: subjectValues.map[json["subject"]]!,
        teacherName: teacherNameValues.map[json["teacher_name"]]!,
        teacherUserId: json["teacher_user_id"],
        time: json["time"],
        type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "date": date,
        "division_name": divisionNameValues.reverse[divisionName],
        "link": link,
        "message_id": messageId,
        "subject": subjectValues.reverse[subject],
        "teacher_name": teacherNameValues.reverse[teacherName],
        "teacher_user_id": teacherUserId,
        "time": time,
        "type": typeValues.reverse[type],
      };
}

enum DivisionName { A }

final divisionNameValues = EnumValues({"'A'": DivisionName.A});

enum Subject { NEW_LESSON, TEACHER_MESSAGE }

final subjectValues = EnumValues({
  "New Lesson": Subject.NEW_LESSON,
  "Teacher Message": Subject.TEACHER_MESSAGE
});

enum TeacherName { VEDANG_TEMBE }

final teacherNameValues =
    EnumValues({"'Vedang Tembe'": TeacherName.VEDANG_TEMBE});

enum MessageType { LESSON, TEXT }

final typeValues =
    EnumValues({"lesson": MessageType.LESSON, "text": MessageType.TEXT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
