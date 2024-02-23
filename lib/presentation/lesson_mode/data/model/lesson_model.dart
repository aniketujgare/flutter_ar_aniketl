// To parse this JSON data, do
//
//     final lessonModeModel = lessonModeModelFromJson(jsonString);

import 'dart:convert';

List<LessonModeModel> lessonModeModelFromJson(String str) =>
    List<LessonModeModel>.from(
        json.decode(str).map((x) => LessonModeModel.fromJson(x)));

String lessonModeModelToJson(List<LessonModeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LessonModeModel {
  final YoutubeVideo? youtubeVideo;
  final Threed? threed;
  final Image? image;
  final Gdrive? gdrive;
  final Mcq? mcq;
  final Fib? fib;
  final Owa? owa;
  final Owa? tf;

  LessonModeModel({
    this.youtubeVideo,
    this.threed,
    this.image,
    this.gdrive,
    this.mcq,
    this.fib,
    this.owa,
    this.tf,
  });

  LessonModeModel copyWith({
    YoutubeVideo? youtubeVideo,
    Threed? threed,
    Image? image,
    Gdrive? gdrive,
    Mcq? mcq,
    Fib? fib,
    Owa? owa,
    Owa? tf,
  }) =>
      LessonModeModel(
        youtubeVideo: youtubeVideo ?? this.youtubeVideo,
        threed: threed ?? this.threed,
        image: image ?? this.image,
        gdrive: gdrive ?? this.gdrive,
        mcq: mcq ?? this.mcq,
        fib: fib ?? this.fib,
        owa: owa ?? this.owa,
        tf: tf ?? this.tf,
      );

  factory LessonModeModel.fromJson(Map<String, dynamic> json) =>
      LessonModeModel(
        youtubeVideo: json["YoutubeVideo"] == null
            ? null
            : YoutubeVideo.fromJson(json["YoutubeVideo"]),
        threed: json["threed"] == null ? null : Threed.fromJson(json["threed"]),
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        gdrive: json["gdrive"] == null ? null : Gdrive.fromJson(json["gdrive"]),
        mcq: json["mcq"] == null ? null : Mcq.fromJson(json["mcq"]),
        fib: json["fib"] == null ? null : Fib.fromJson(json["fib"]),
        owa: json["owa"] == null ? null : Owa.fromJson(json["owa"]),
        tf: json["tf"] == null ? null : Owa.fromJson(json["tf"]),
      );

  Map<String, dynamic> toJson() => {
        "YoutubeVideo": youtubeVideo?.toJson(),
        "threed": threed?.toJson(),
        "image": image?.toJson(),
        "gdrive": gdrive?.toJson(),
        "mcq": mcq?.toJson(),
        "fib": fib?.toJson(),
        "owa": owa?.toJson(),
        "tf": tf?.toJson(),
      };
}

class Fib {
  final String answer;
  final String question;
  final String questionForm;
  final String answerIndex;

  Fib({
    required this.answer,
    required this.question,
    required this.questionForm,
    required this.answerIndex,
  });

  Fib copyWith({
    String? answer,
    String? question,
    String? questionForm,
    String? answerIndex,
  }) =>
      Fib(
        answer: answer ?? this.answer,
        question: question ?? this.question,
        questionForm: questionForm ?? this.questionForm,
        answerIndex: answerIndex ?? this.answerIndex,
      );

  factory Fib.fromJson(Map<String, dynamic> json) => Fib(
        answer: json["answer"],
        question: json["question"],
        questionForm: json["question_form"],
        answerIndex: json["answer_index"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "question": question,
        "question_form": questionForm,
        "answer_index": answerIndex,
      };
}

class Gdrive {
  final String embedUrl;
  final String name;
  final String type;
  final String url;

  Gdrive({
    required this.embedUrl,
    required this.name,
    required this.type,
    required this.url,
  });

  Gdrive copyWith({
    String? embedUrl,
    String? name,
    String? type,
    String? url,
  }) =>
      Gdrive(
        embedUrl: embedUrl ?? this.embedUrl,
        name: name ?? this.name,
        type: type ?? this.type,
        url: url ?? this.url,
      );

  factory Gdrive.fromJson(Map<String, dynamic> json) => Gdrive(
        embedUrl: json["embedUrl"],
        name: json["name"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "embedUrl": embedUrl,
        "name": name,
        "type": type,
        "url": url,
      };
}

class Image {
  final String imageUrl;

  Image({
    required this.imageUrl,
  });

  Image copyWith({
    String? imageUrl,
  }) =>
      Image(
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

class Mcq {
  final List<String> options;
  final String mcqType;
  final String answer;
  final String question;
  final String questionUrl;

  Mcq({
    required this.options,
    required this.mcqType,
    required this.answer,
    required this.question,
    required this.questionUrl,
  });

  Mcq copyWith({
    List<String>? options,
    String? mcqType,
    String? answer,
    String? question,
    String? questionUrl,
  }) =>
      Mcq(
        options: options ?? this.options,
        mcqType: mcqType ?? this.mcqType,
        answer: answer ?? this.answer,
        question: question ?? this.question,
        questionUrl: questionUrl ?? this.questionUrl,
      );

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
        options: List<String>.from(json["options"].map((x) => x)),
        mcqType: json["mcq_type"],
        answer: json["answer"],
        question: json["question"],
        questionUrl: json["question_url"],
      );

  Map<String, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x)),
        "mcq_type": mcqType,
        "answer": answer,
        "question": question,
        "question_url": questionUrl,
      };
}

class Owa {
  final String answer;
  final String question;
  final String questionUrl;
  final List<String>? options;

  Owa({
    required this.answer,
    required this.question,
    required this.questionUrl,
    this.options,
  });

  Owa copyWith({
    String? answer,
    String? question,
    String? questionUrl,
    List<String>? options,
  }) =>
      Owa(
        answer: answer ?? this.answer,
        question: question ?? this.question,
        questionUrl: questionUrl ?? this.questionUrl,
        options: options ?? this.options,
      );

  factory Owa.fromJson(Map<String, dynamic> json) => Owa(
        answer: json["answer"],
        question: json["question"],
        questionUrl: json["question_url"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "question": question,
        "question_url": questionUrl,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
      };
}

class Threed {
  final String name;
  final String id;
  final String category;
  final int modelid;
  final String url;
  final List<String> labels;

  Threed({
    required this.name,
    required this.id,
    required this.category,
    required this.modelid,
    required this.url,
    required this.labels,
  });

  Threed copyWith({
    String? name,
    String? id,
    String? category,
    int? modelid,
    String? url,
    List<String>? labels,
  }) =>
      Threed(
        name: name ?? this.name,
        id: id ?? this.id,
        category: category ?? this.category,
        modelid: modelid ?? this.modelid,
        url: url ?? this.url,
        labels: labels ?? this.labels,
      );

  factory Threed.fromJson(Map<String, dynamic> json) => Threed(
        name: json["name"],
        id: json["id"],
        category: json["category"],
        modelid: json["modelid"],
        url: json["url"],
        labels: List<String>.from(json["labels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "category": category,
        "modelid": modelid,
        "url": url,
        "labels": List<dynamic>.from(labels.map((x) => x)),
      };
}

class YoutubeVideo {
  final String name;
  final String thumbnail;
  final String embedUrl;
  final String videoUrl;

  YoutubeVideo({
    required this.name,
    required this.thumbnail,
    required this.embedUrl,
    required this.videoUrl,
  });

  YoutubeVideo copyWith({
    String? name,
    String? thumbnail,
    String? embedUrl,
    String? videoUrl,
  }) =>
      YoutubeVideo(
        name: name ?? this.name,
        thumbnail: thumbnail ?? this.thumbnail,
        embedUrl: embedUrl ?? this.embedUrl,
        videoUrl: videoUrl ?? this.videoUrl,
      );

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) => YoutubeVideo(
        name: json["name"],
        thumbnail: json["thumbnail"],
        embedUrl: json["embed_url"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "thumbnail": thumbnail,
        "embed_url": embedUrl,
        "video_url": videoUrl,
      };
}
