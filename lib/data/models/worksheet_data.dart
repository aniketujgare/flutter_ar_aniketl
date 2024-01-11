// To parse this JSON data, do
//
//     final worksheetsData = worksheetsDataFromJson(jsonString);

import 'dart:convert';

List<List<WorksheetsData>> worksheetsDataFromJson(String str) =>
    List<List<WorksheetsData>>.from(json.decode(str).map((x) =>
        List<WorksheetsData>.from(x.map((x) => WorksheetsData.fromJson(x)))));

String worksheetsDataToJson(List<List<WorksheetsData>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class WorksheetsData {
  final Mcqimg? mcqtext;
  final Mcqimg? mcqimg;
  final Fillblank? fillblank;
  final Truefalse? truefalse;
  final Mtf? mtf;
  final Mcqimg? oneword;
  final Selectword? selectword;
  final Mcqimg? oddoneouttext;
  final Ascdesc? ascdesc;
  final Arithematic? arithematic;

  WorksheetsData({
    this.mcqtext,
    this.mcqimg,
    this.fillblank,
    this.truefalse,
    this.mtf,
    this.oneword,
    this.selectword,
    this.oddoneouttext,
    this.ascdesc,
    this.arithematic,
  });

  factory WorksheetsData.fromJson(Map<String, dynamic> json) => WorksheetsData(
        mcqtext:
            json["mcqtext"] == null ? null : Mcqimg.fromJson(json["mcqtext"]),
        mcqimg: json["mcqimg"] == null ? null : Mcqimg.fromJson(json["mcqimg"]),
        fillblank: json["fillblank"] == null
            ? null
            : Fillblank.fromJson(json["fillblank"]),
        truefalse: json["truefalse"] == null
            ? null
            : Truefalse.fromJson(json["truefalse"]),
        mtf: json["mtf"] == null ? null : Mtf.fromJson(json["mtf"]),
        oneword:
            json["oneword"] == null ? null : Mcqimg.fromJson(json["oneword"]),
        selectword: json["selectword"] == null
            ? null
            : Selectword.fromJson(json["selectword"]),
        oddoneouttext: json["oddoneouttext"] == null
            ? null
            : Mcqimg.fromJson(json["oddoneouttext"]),
        ascdesc:
            json["ascdesc"] == null ? null : Ascdesc.fromJson(json["ascdesc"]),
        arithematic: json["arithematic"] == null
            ? null
            : Arithematic.fromJson(json["arithematic"]),
      );

  Map<String, dynamic> toJson() => {
        "mcqtext": mcqtext?.toJson(),
        "mcqimg": mcqimg?.toJson(),
        "fillblank": fillblank?.toJson(),
        "truefalse": truefalse?.toJson(),
        "mtf": mtf?.toJson(),
        "oneword": oneword?.toJson(),
        "selectword": selectword?.toJson(),
        "oddoneouttext": oddoneouttext?.toJson(),
        "ascdesc": ascdesc?.toJson(),
        "arithematic": arithematic?.toJson(),
      };
}

class Arithematic {
  final String num1;
  final String question;
  final String answer;
  final String arithematicOperator;
  final String num2;

  Arithematic({
    required this.num1,
    required this.question,
    required this.answer,
    required this.arithematicOperator,
    required this.num2,
  });

  factory Arithematic.fromJson(Map<String, dynamic> json) => Arithematic(
        num1: json["num1"],
        question: json["question"],
        answer: json["answer"],
        arithematicOperator: json["operator"],
        num2: json["num2"],
      );

  Map<String, dynamic> toJson() => {
        "num1": num1,
        "question": question,
        "answer": answer,
        "operator": arithematicOperator,
        "num2": num2,
      };
}

class Ascdesc {
  final List<String> numbers;
  final String question;
  final List<String> answer;
  final String type;
  final String order;

  Ascdesc({
    required this.numbers,
    required this.question,
    required this.answer,
    required this.type,
    required this.order,
  });

  factory Ascdesc.fromJson(Map<String, dynamic> json) => Ascdesc(
        numbers: List<String>.from(json["numbers"].map((x) => x)),
        question: json["question"],
        answer: List<String>.from(json["answer"].map((x) => x)),
        type: json["type"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "numbers": List<dynamic>.from(numbers.map((x) => x)),
        "question": question,
        "answer": List<dynamic>.from(answer.map((x) => x)),
        "type": type,
        "order": order,
      };
}

class Fillblank {
  final String question;
  final List<String> answer;
  final List<String> index;

  Fillblank({
    required this.question,
    required this.answer,
    required this.index,
  });

  factory Fillblank.fromJson(Map<String, dynamic> json) => Fillblank(
        question: json["question"],
        answer: List<String>.from(json["answer"].map((x) => x)),
        index: List<String>.from(json["index"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": List<dynamic>.from(answer.map((x) => x)),
        "index": List<dynamic>.from(index.map((x) => x)),
      };
}

class Mcqimg {
  final List<String>? options;
  final String answer;
  final String question;
  final String? questionUrl;

  Mcqimg({
    this.options,
    required this.answer,
    required this.question,
    this.questionUrl,
  });

  factory Mcqimg.fromJson(Map<String, dynamic> json) => Mcqimg(
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        answer: json["answer"],
        question: json["question"],
        questionUrl: json["question_url"],
      );

  Map<String, dynamic> toJson() => {
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "answer": answer,
        "question": question,
        "question_url": questionUrl,
      };
}

class Mtf {
  final Options options;
  final String question;

  Mtf({
    required this.options,
    required this.question,
  });

  factory Mtf.fromJson(Map<String, dynamic> json) => Mtf(
        options: Options.fromJson(json["options"]),
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "options": options.toJson(),
        "question": question,
      };
}

class Options {
  final String?
      httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqVege954X43Png;
  final String?
      httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqOfhmwlj822Png;
  final String?
      httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqBui3Gal770Png;
  final String?
      httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqDd9Zm819R1Png;
  final String? shreyash;
  final String? lokesh;
  final String? anurag;
  final String? vedangSir;

  Options({
    this.httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqVege954X43Png,
    this.httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqOfhmwlj822Png,
    this.httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqBui3Gal770Png,
    this.httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqDd9Zm819R1Png,
    this.shreyash,
    this.lokesh,
    this.anurag,
    this.vedangSir,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqVege954X43Png:
            json[
                "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/vege954x4/3.png"],
        httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqOfhmwlj822Png:
            json[
                "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/ofhmwlj82/2.png"],
        httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqBui3Gal770Png:
            json[
                "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/bui3gal77/0.png"],
        httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqDd9Zm819R1Png:
            json[
                "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/dd9zm819r/1.png"],
        shreyash: json["shreyash"],
        lokesh: json["lokesh"],
        anurag: json["anurag"],
        vedangSir: json["vedang sir"],
      );

  Map<String, dynamic> toJson() => {
        "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/vege954x4/3.png":
            httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqVege954X43Png,
        "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/ofhmwlj82/2.png":
            httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqOfhmwlj822Png,
        "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/bui3gal77/0.png":
            httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqBui3Gal770Png,
        "https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/69/worksheet/844/maths_mcq/dd9zm819r/1.png":
            httpsSmartxruserfiles1S3ApSouth1AmazonawsComTeacher69Worksheet844MathsMcqDd9Zm819R1Png,
        "shreyash": shreyash,
        "lokesh": lokesh,
        "anurag": anurag,
        "vedang sir": vedangSir,
      };
}

class Selectword {
  final String question;
  final String answer;
  final String index;

  Selectword({
    required this.question,
    required this.answer,
    required this.index,
  });

  factory Selectword.fromJson(Map<String, dynamic> json) => Selectword(
        question: json["question"],
        answer: json["answer"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "index": index,
      };
}

class Truefalse {
  final String question;
  final String answer;

  Truefalse({
    required this.question,
    required this.answer,
  });

  factory Truefalse.fromJson(Map<String, dynamic> json) => Truefalse(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
