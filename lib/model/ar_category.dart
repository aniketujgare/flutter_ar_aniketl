// To parse this JSON data, do
//
//     final arCategory = arCategoryFromJson(jsonString);

import 'dart:convert';

List<ArCategory> arCategoryFromJson(String str) =>
    List<ArCategory>.from(json.decode(str).map((x) => ArCategory.fromJson(x)));

String arCategoryToJson(List<ArCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArCategory {
  final int categoryId;
  final String categoryName;

  ArCategory({
    required this.categoryId,
    required this.categoryName,
  });

  factory ArCategory.fromJson(Map<String, dynamic> json) => ArCategory(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
