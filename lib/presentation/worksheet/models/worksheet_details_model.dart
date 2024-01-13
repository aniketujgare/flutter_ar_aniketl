// To parse this JSON data, do
//
//     final worksheetDetailsModel = worksheetDetailsModelFromJson(jsonString);

import 'dart:convert';

WorksheetDetailsModel worksheetDetailsModelFromJson(String str) =>
    WorksheetDetailsModel.fromJson(json.decode(str));

String worksheetDetailsModelToJson(WorksheetDetailsModel data) =>
    json.encode(data.toJson());

class WorksheetDetailsModel {
  int id;
  String status;
  String subject;
  String teacher;
  String topic;
  String worksheetName;

  WorksheetDetailsModel({
    required this.id,
    required this.status,
    required this.subject,
    required this.teacher,
    required this.topic,
    required this.worksheetName,
  });

  factory WorksheetDetailsModel.fromJson(Map<String, dynamic> json) =>
      WorksheetDetailsModel(
        id: json["id"],
        status: json["status"],
        subject: json["subject"],
        teacher: json["teacher"],
        topic: json["topic"],
        worksheetName: json["worksheet_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "subject": subject,
        "teacher": teacher,
        "topic": topic,
        "worksheet_name": worksheetName,
      };
}
