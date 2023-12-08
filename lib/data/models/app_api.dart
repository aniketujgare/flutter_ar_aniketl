// To parse this JSON data, do
//
//     final apiEndpointModel = apiEndpointModelFromJson(jsonString);

import 'dart:convert';

Map<String, ApiEndpointModel> apiEndpointModelFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, ApiEndpointModel>(k, ApiEndpointModel.fromJson(v)));

String apiEndpointModelToJson(Map<String, ApiEndpointModel> data) =>
    json.encode(
        Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ApiEndpointModel {
  final String key;
  final String value;

  ApiEndpointModel({
    required this.key,
    required this.value,
  });

  factory ApiEndpointModel.fromJson(Map<String, dynamic> json) =>
      ApiEndpointModel(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
