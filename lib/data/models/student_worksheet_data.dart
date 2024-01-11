// To parse this JSON data, do
//
//     final studentWorksheetData = studentWorksheetDataFromJson(jsonString);

import 'dart:convert';

Map<String, StudentWorksheetData> studentWorksheetDataFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, StudentWorksheetData>(
            k, StudentWorksheetData.fromJson(v)));

String studentWorksheetDataToJson(Map<String, StudentWorksheetData> data) =>
    json.encode(
        Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class StudentWorksheetData {
  final Fillblank? truefalse;
  final Fillblank? fillblank;
  final Fillblank? mcqtext;
  final Fillblank? mcqimg;
  final Fillblank? selectword;
  final Ascdesc? ascdesc;
  final Mtf? mtf;
  final Fillblank? longanswer;
  final Fillblank? oneword;
  final Fillblank? oddoneouttext;
  final Fillblank? oddoneoutimg;

  StudentWorksheetData({
    this.truefalse,
    this.fillblank,
    this.mcqtext,
    this.mcqimg,
    this.selectword,
    this.ascdesc,
    this.mtf,
    this.longanswer,
    this.oneword,
    this.oddoneouttext,
    this.oddoneoutimg,
  });

  factory StudentWorksheetData.fromJson(Map<String, dynamic> json) =>
      StudentWorksheetData(
        truefalse: json["truefalse"] == null
            ? null
            : Fillblank.fromJson(json["truefalse"]),
        fillblank: json["fillblank"] == null
            ? null
            : Fillblank.fromJson(json["fillblank"]),
        mcqtext: json["mcqtext"] == null
            ? null
            : Fillblank.fromJson(json["mcqtext"]),
        mcqimg:
            json["mcqimg"] == null ? null : Fillblank.fromJson(json["mcqimg"]),
        selectword: json["selectword"] == null
            ? null
            : Fillblank.fromJson(json["selectword"]),
        ascdesc:
            json["ascdesc"] == null ? null : Ascdesc.fromJson(json["ascdesc"]),
        mtf: json["mtf"] == null ? null : Mtf.fromJson(json["mtf"]),
        longanswer: json["longanswer"] == null
            ? null
            : Fillblank.fromJson(json["longanswer"]),
        oneword: json["oneword"] == null
            ? null
            : Fillblank.fromJson(json["oneword"]),
        oddoneouttext: json["oddoneouttext"] == null
            ? null
            : Fillblank.fromJson(json["oddoneouttext"]),
        oddoneoutimg: json["oddoneoutimg"] == null
            ? null
            : Fillblank.fromJson(json["oddoneoutimg"]),
      );

  Map<String, dynamic> toJson() => {
        "truefalse": truefalse?.toJson(),
        "fillblank": fillblank?.toJson(),
        "mcqtext": mcqtext?.toJson(),
        "mcqimg": mcqimg?.toJson(),
        "selectword": selectword?.toJson(),
        "ascdesc": ascdesc?.toJson(),
        "mtf": mtf?.toJson(),
        "longanswer": longanswer?.toJson(),
        "oneword": oneword?.toJson(),
        "oddoneouttext": oddoneouttext?.toJson(),
        "oddoneoutimg": oddoneoutimg?.toJson(),
      };
}

class Ascdesc {
  final List<String> answer;

  Ascdesc({
    required this.answer,
  });

  factory Ascdesc.fromJson(Map<String, dynamic> json) => Ascdesc(
        answer: List<String>.from(json["answer"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "answer": List<dynamic>.from(answer.map((x) => x)),
      };
}

class Fillblank {
  final String answer;

  Fillblank({
    required this.answer,
  });

  factory Fillblank.fromJson(Map<String, dynamic> json) => Fillblank(
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
      };
}

class Mtf {
  final Map<String, String> answer;

  Mtf({
    required this.answer,
  });

  factory Mtf.fromJson(Map<String, dynamic> json) => Mtf(
        answer: Map.from(json["answer"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "answer":
            Map.from(answer).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
