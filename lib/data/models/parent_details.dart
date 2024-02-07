// To parse this JSON data, do
//
//     final parentDetails = parentDetailsFromJson(jsonString);

import 'dart:convert';

List<ParentDetails> parentDetailsFromJson(String str) =>
    List<ParentDetails>.from(
        json.decode(str).map((x) => ParentDetails.fromJson(x)));

String parentDetailsToJson(List<ParentDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentDetails {
  final int agreementAccepted;
  final String parentEmail;
  final int parentId;
  final double parentMobileNumber;
  final String parentName;
  final String parentRelation;
  final int schoolId;

  ParentDetails({
    required this.agreementAccepted,
    required this.parentEmail,
    required this.parentId,
    required this.parentMobileNumber,
    required this.parentName,
    required this.parentRelation,
    required this.schoolId,
  });

  ParentDetails copyWith({
    int? agreementAccepted,
    String? parentEmail,
    int? parentId,
    double? parentMobileNumber,
    String? parentName,
    String? parentRelation,
    int? schoolId,
  }) =>
      ParentDetails(
        agreementAccepted: agreementAccepted ?? this.agreementAccepted,
        parentEmail: parentEmail ?? this.parentEmail,
        parentId: parentId ?? this.parentId,
        parentMobileNumber: parentMobileNumber ?? this.parentMobileNumber,
        parentName: parentName ?? this.parentName,
        parentRelation: parentRelation ?? this.parentRelation,
        schoolId: schoolId ?? this.schoolId,
      );

  factory ParentDetails.fromJson(Map<String, dynamic> json) => ParentDetails(
        agreementAccepted: json["agreement_accepted"],
        parentEmail: json["parent_email"],
        parentId: json["parent_id"],
        parentMobileNumber: json["parent_mobile_number"],
        parentName: json["parent_name"],
        parentRelation: json["parent_relation"],
        schoolId: json["school_id"],
      );

  Map<String, dynamic> toJson() => {
        "agreement_accepted": agreementAccepted,
        "parent_email": parentEmail,
        "parent_id": parentId,
        "parent_mobile_number": parentMobileNumber,
        "parent_name": parentName,
        "parent_relation": parentRelation,
        "school_id": schoolId,
      };
}
