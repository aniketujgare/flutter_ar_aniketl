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
  final String divisionName;
  final String link;
  final String messageId;
  final String subject;
  final String teacherName;
  final String teacherUserId;
  final String time;
  final String type;

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
        divisionName: json["division_name"],
        link: json["link"],
        messageId: json["message_id"],
        subject: json["subject"],
        teacherName: json["teacher_name"],
        teacherUserId: json["teacher_user_id"],
        time: json["time"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "date": date,
        "division_name": divisionName,
        "link": link,
        "message_id": messageId,
        "subject": subject,
        "teacher_name": teacherName,
        "teacher_user_id": teacherUserId,
        "time": time,
        "type": type,
      };
}
