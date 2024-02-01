// To parse this JSON data, do
//
//     final studentProfileModel = studentProfileModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'student_profile_model.g.dart';

List<List<StudentProfileModel>> studentProfileModelFromJson(String str) =>
    List<List<StudentProfileModel>>.from(json.decode(str).map((x) =>
        List<StudentProfileModel>.from(
            x.map((x) => StudentProfileModel.fromJson(x)))));

String studentProfileModelToJson(List<List<StudentProfileModel>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

@HiveType(typeId: 1)
class StudentProfileModel {
  @HiveField(1)
  final int? coins;
  @HiveField(2)
  final int? divisionId;
  @HiveField(3)
  final int? gems;
  @HiveField(4)
  final int? parentId;
  @HiveField(5)
  final int? profilePicId;
  @HiveField(6)
  final int? schoolId;
  @HiveField(7)
  final String? secreteCode;
  @HiveField(8)
  final int? standardId;
  @HiveField(9)
  final int? studentActiveStatus;
  @HiveField(10)
  final DateTime? studentCreatedDate;
  @HiveField(11)
  final DateTime? studentExpiryDate;
  @HiveField(12)
  final int? studentId;
  @HiveField(13)
  final String? studentName;
  @HiveField(14)
  final int? studentSubscriptionStatus;
  @HiveField(15)
  final int? adminStandard;

  StudentProfileModel({
    this.coins,
    this.divisionId,
    this.gems,
    this.parentId,
    this.profilePicId,
    this.schoolId,
    this.secreteCode,
    this.standardId,
    this.studentActiveStatus,
    this.studentCreatedDate,
    this.studentExpiryDate,
    this.studentId,
    this.studentName,
    this.studentSubscriptionStatus,
    this.adminStandard,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) =>
      StudentProfileModel(
        coins: json["coins"],
        divisionId: json["division_id"],
        gems: json["gems"],
        parentId: json["parent_id"],
        profilePicId: json["profile_pic_id"],
        schoolId: json["school_id"],
        secreteCode: json["secrete_code"],
        standardId: json["standard_id"],
        studentActiveStatus: json["student_active_status"],
        studentCreatedDate: json["student_created_date"] == null
            ? null
            : DateTime.parse(json["student_created_date"]),
        studentExpiryDate: json["student_expiry_date"] == null
            ? null
            : DateTime.parse(json["student_expiry_date"]),
        studentId: json["student_id"],
        studentName: json["student_name"],
        studentSubscriptionStatus: json["student_subscription_status"],
        adminStandard: json["admin_standard"],
      );

  Map<String, dynamic> toJson() => {
        "coins": coins,
        "division_id": divisionId,
        "gems": gems,
        "parent_id": parentId,
        "profile_pic_id": profilePicId,
        "school_id": schoolId,
        "secrete_code": secreteCode,
        "standard_id": standardId,
        "student_active_status": studentActiveStatus,
        "student_created_date":
            "${studentCreatedDate!.year.toString().padLeft(4, '0')}-${studentCreatedDate!.month.toString().padLeft(2, '0')}-${studentCreatedDate!.day.toString().padLeft(2, '0')}",
        "student_expiry_date":
            "${studentExpiryDate!.year.toString().padLeft(4, '0')}-${studentExpiryDate!.month.toString().padLeft(2, '0')}-${studentExpiryDate!.day.toString().padLeft(2, '0')}",
        "student_id": studentId,
        "student_name": studentName,
        "student_subscription_status": studentSubscriptionStatus,
        "admin_standard": adminStandard,
      };
}
