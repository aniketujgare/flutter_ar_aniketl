// To parse this JSON data, do
//
//     final arModel = arModelFromJson(jsonString);

import 'dart:convert';

List<ArModel> arModelFromJson(String str) =>
    List<ArModel>.from(json.decode(str).map((x) => ArModel.fromJson(x)));

String arModelToJson(List<ArModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArModel {
  final String animated;
  final String categoryId;
  final int modelId;
  final String modelName;
  final String topicId;

  ArModel({
    required this.animated,
    required this.categoryId,
    required this.modelId,
    required this.modelName,
    required this.topicId,
  });

  factory ArModel.fromJson(Map<String, dynamic> json) => ArModel(
        animated: json["animated"],
        categoryId: json["category_id"],
        modelId: json["model_id"],
        modelName: json["model_name"],
        topicId: json["topic_id"],
      );

  Map<String, dynamic> toJson() => {
        "animated": animated,
        "category_id": categoryId,
        "model_id": modelId,
        "model_name": modelName,
        "topic_id": topicId,
      };
}
