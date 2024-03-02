import 'questions.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class Answer {
  dynamic answer;

  Answer({required this.answer});

  factory Answer.fromJson(dynamic json) {
    if (json['answer'] is List) {
      return Answer(answer: json['answer']);
    } else {
      return Answer(answer: json['answer']);
    }
  }

  Map<String, dynamic> toJson() {
    if (answer is List<String>) {
      if (answer.length == 1) {
        return {'answer': answer[0]};
      }
    }
    return {'answer': answer};
  }
}

class AnswerQuestion {
  final QuestionType questionType;
  final Answer answer;

  AnswerQuestion({
    required this.questionType,
    required this.answer,
  });

  AnswerQuestion copyWith({
    QuestionType? questionType,
    Answer? answer,
  }) {
    return AnswerQuestion(
      questionType: questionType ?? this.questionType,
      answer: answer ?? this.answer,
    );
  }

  factory AnswerQuestion.fromJson(Map<String, dynamic> json) {
    debugPrint('keys: ' +
        json.keys.first.toString() +
        'vale: ' +
        json.values.first.toString());
    final String key = json.keys.first;
    dynamic value = json[key];

    QuestionType questionType = _getQuestionType(key);
    Answer answer;

    if (questionType == QuestionType.ascDescOrder) {
      answer = Answer.fromJson({'answer': value});
    } else {
      answer = Answer.fromJson({'answer': value['answer']});
    }

    return AnswerQuestion(
      questionType: questionType,
      answer: answer,
    );
  }

  Map<String, dynamic> toJson() {
    String key = _getKeyFromQuestionType(questionType);
    Map<String, dynamic> answerJson = answer.toJson();

    if (questionType == QuestionType.ascDescOrder ||
        questionType == QuestionType.multiplefillblank) {
      return {key: answerJson['answer']};
    }

    return {key: answerJson};
  }

  static QuestionType _getQuestionType(String key) {
    switch (key) {
      case 'selectword':
        return QuestionType.selectWord;
      case 'oneword':
        return QuestionType.oneWord;
      case 'oddoneouttext':
        return QuestionType.oddOneOutText;
      case 'ascdesc':
        return QuestionType.ascDescOrder;
      case 'oddoneoutimg':
        return QuestionType.oddOneOutimage;
      case 'mtf':
        return QuestionType.matchTheFollowing;
      case 'longanswer':
        return QuestionType.longAnswer;
      case 'truefalse':
        return QuestionType.trueFalse;
      case 'fillblank':
        return QuestionType.fillBlank;
      case 'multiplefillblank':
        return QuestionType.multiplefillblank;
      case 'mcqtext':
        return QuestionType.mcqText;
      case 'mcqimg':
        return QuestionType.mcqImage;
      case 'mcqimg':
        return QuestionType.mcqImage;
      case 'arithematic':
        return QuestionType.arithmetic;
      case 'identifyimage':
        return QuestionType.identifyimage;
      case 'rearrange':
        return QuestionType.rearrange;
      case 'srotingquestion':
        return QuestionType.srotingquestion;
      default:
        throw Exception('Unsupported question type: $key');
    }
  }

  static String _getKeyFromQuestionType(QuestionType questionType) {
    switch (questionType) {
      case QuestionType.selectWord:
        return 'selectword';
      case QuestionType.oneWord:
        return 'oneword';
      case QuestionType.oddOneOutText:
        return 'oddoneouttext';
      case QuestionType.ascDescOrder:
        return 'ascdesc';
      case QuestionType.oddOneOutimage:
        return 'oddoneoutimg';
      case QuestionType.matchTheFollowing:
        return 'mtf';
      case QuestionType.longAnswer:
        return 'longanswer';
      case QuestionType.trueFalse:
        return 'truefalse';
      case QuestionType.fillBlank:
        return 'fillblank';
      case QuestionType.multiplefillblank:
        return 'multiplefillblank';
      case QuestionType.mcqText:
        return 'mcqtext';
      case QuestionType.mcqImage:
        return 'mcqimg';
      case QuestionType.rearrange:
        return 'rearrange';
      case QuestionType.identifyimage:
        return 'identifyimage';
      case QuestionType.srotingquestion:
        return 'srotingquestion';
      case QuestionType.arithmetic:
        return 'arithematic';
      default:
        throw Exception('Unsupported question type: $questionType');
    }
  }
}

class StudentAnswer {
  final int questionNo;
  final AnswerQuestion question;

  StudentAnswer({required this.questionNo, required this.question});

  factory StudentAnswer.fromJson(String questionNo, Map<String, dynamic> json) {
    debugPrint('answerJson' + json.toString());
    return StudentAnswer(
      questionNo: int.parse(questionNo),
      question: AnswerQuestion.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {questionNo.toString(): question.toJson()};
  }

  copyWith({required AnswerQuestion question}) {}
}
