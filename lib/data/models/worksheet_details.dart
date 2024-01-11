// To parse this JSON data, do
//
//     final worksheetDetails = worksheetDetailsFromJson(jsonString);

import 'dart:convert';

List<WorksheetDetails> worksheetDetailsFromJson(String str) =>
    List<WorksheetDetails>.from(
        json.decode(str).map((x) => WorksheetDetails.fromJson(x)));

String worksheetDetailsToJson(List<WorksheetDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorksheetDetails {
  int id;
  String status;
  int subjectId;
  int teacherId;
  int topicId;
  String worksheetName;

  WorksheetDetails({
    required this.id,
    required this.status,
    required this.subjectId,
    required this.teacherId,
    required this.topicId,
    required this.worksheetName,
  });

  factory WorksheetDetails.fromJson(Map<String, dynamic> json) =>
      WorksheetDetails(
        id: json["id"],
        status: json["status"],
        subjectId: json["subject_id"],
        teacherId: json["teacher_id"],
        topicId: json["topic_id"],
        worksheetName: json["worksheet_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "subject_id": subjectId,
        "teacher_id": teacherId,
        "topic_id": topicId,
        "worksheet_name": worksheetName,
      };
}
