// To parse this JSON data, do
//
//     final publishedworksheets = publishedworksheetsFromJson(jsonString);

import 'dart:convert';

List<PublishedWorksheets> publishedworksheetsFromJson(String str) =>
    List<PublishedWorksheets>.from(
        json.decode(str).map((x) => PublishedWorksheets.fromJson(x)));

String publishedworksheetsToJson(List<PublishedWorksheets> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublishedWorksheets {
  final DateTime deadline;
  final int worksheetId;

  PublishedWorksheets({
    required this.deadline,
    required this.worksheetId,
  });

  factory PublishedWorksheets.fromJson(Map<String, dynamic> json) =>
      PublishedWorksheets(
        deadline: DateTime.parse(json["deadline"]),
        worksheetId: json["worksheet_id"],
      );

  Map<String, dynamic> toJson() => {
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "worksheet_id": worksheetId,
      };
}
