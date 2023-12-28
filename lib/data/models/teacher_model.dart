// To parse this JSON data, do
//
//     final teacherModel = teacherModelFromJson(jsonString);

import 'dart:convert';

List<TeacherModel> teacherModelFromJson(String str) => List<TeacherModel>.from(
    json.decode(str).map((x) => TeacherModel.fromJson(x)));

String teacherModelToJson(List<TeacherModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherModel {
  final int agreementAccepted;
  final String profilePicUrl;
  final int schoolId;
  final int standardId;
  final int teacherActiveStatus;
  final DateTime teacherCreatedDate;
  final String teacherEmailId;
  final DateTime teacherExpiryDate;
  final String teacherName;
  final String teacherPassword;
  final double teacherPhoneNumber;
  final int teacherSubscriptionStatus;
  final int teacherUserId;
  final int verified;

  TeacherModel({
    required this.agreementAccepted,
    required this.profilePicUrl,
    required this.schoolId,
    required this.standardId,
    required this.teacherActiveStatus,
    required this.teacherCreatedDate,
    required this.teacherEmailId,
    required this.teacherExpiryDate,
    required this.teacherName,
    required this.teacherPassword,
    required this.teacherPhoneNumber,
    required this.teacherSubscriptionStatus,
    required this.teacherUserId,
    required this.verified,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        agreementAccepted: json["agreement_accepted"],
        profilePicUrl: json["profile_pic_url"],
        schoolId: json["school_id"],
        standardId: json["standard_id"],
        teacherActiveStatus: json["teacher_active_status"],
        teacherCreatedDate: DateTime.parse(json["teacher_created_date"]),
        teacherEmailId: json["teacher_email_id"],
        teacherExpiryDate: DateTime.parse(json["teacher_expiry_date"]),
        teacherName: json["teacher_name"],
        teacherPassword: json["teacher_password"],
        teacherPhoneNumber: json["teacher_phone_number"].toDouble(),
        teacherSubscriptionStatus: json["teacher_subscription_status"],
        teacherUserId: json["teacher_user_id"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "agreement_accepted": agreementAccepted,
        "profile_pic_url": profilePicUrl,
        "school_id": schoolId,
        "standard_id": standardId,
        "teacher_active_status": teacherActiveStatus,
        "teacher_created_date":
            "${teacherCreatedDate.year.toString().padLeft(4, '0')}-${teacherCreatedDate.month.toString().padLeft(2, '0')}-${teacherCreatedDate.day.toString().padLeft(2, '0')}",
        "teacher_email_id": teacherEmailId,
        "teacher_expiry_date":
            "${teacherExpiryDate.year.toString().padLeft(4, '0')}-${teacherExpiryDate.month.toString().padLeft(2, '0')}-${teacherExpiryDate.day.toString().padLeft(2, '0')}",
        "teacher_name": teacherName,
        "teacher_password": teacherPassword,
        "teacher_phone_number": teacherPhoneNumber,
        "teacher_subscription_status": teacherSubscriptionStatus,
        "teacher_user_id": teacherUserId,
        "verified": verified,
      };
}
