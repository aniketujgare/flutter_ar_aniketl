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
  final Map<String, Datum>? pollOptions;

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
    this.pollOptions,
  });

  TeacherMessageModel copyWith({
    String? content,
    String? date,
    String? divisionName,
    String? link,
    String? messageId,
    String? subject,
    String? teacherName,
    String? teacherUserId,
    String? time,
    String? type,
    Map<String, Datum>? pollOptions,
  }) =>
      TeacherMessageModel(
        content: content ?? this.content,
        date: date ?? this.date,
        divisionName: divisionName ?? this.divisionName,
        link: link ?? this.link,
        messageId: messageId ?? this.messageId,
        subject: subject ?? this.subject,
        teacherName: teacherName ?? this.teacherName,
        teacherUserId: teacherUserId ?? this.teacherUserId,
        time: time ?? this.time,
        type: type ?? this.type,
        pollOptions: pollOptions ?? this.pollOptions,
      );

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
        pollOptions:
            json["data"] != null && json["data"] is Map<String, dynamic>
                ? (json["data"] as Map<String, dynamic>).map(
                    (k, v) => MapEntry<String, Datum>(
                      k,
                      Datum.fromJson(v as Map<String, dynamic>),
                    ),
                  )
                : null,
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
        "data": Map.from(pollOptions!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Datum {
  final String count;
  final String option;

  Datum({
    required this.count,
    required this.option,
  });

  Datum copyWith({
    String? count,
    String? option,
  }) =>
      Datum(
        count: count ?? this.count,
        option: option ?? this.option,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        count: json["count"],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "option": option,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
