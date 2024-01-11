// enum QuestionType {
//   selectWord,
//   oneWord,
//   oddOneOutText,
//   ascDescOrder,
//   oddOneOutImg,
//   matchTheFollowing,
//   longAnswer,
//   trueFalse,
//   fillBlank,
//   mcqText,
//   mcqImage,
// }

import 'package:flutter_ar/data/models/questions.dart';

class Answer {
  final dynamic answer;

  Answer({required this.answer});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(answer: json['answer']);
  }

  Map<String, dynamic> toJson() {
    return {'answer': answer};
  }
}

class AnswerQuestion {
  final QuestionType questionType;
  final Answer answer;

  AnswerQuestion({required this.questionType, required this.answer});

  factory AnswerQuestion.fromJson(Map<String, dynamic> json) {
    final String key = json.keys.first;
    final dynamic value = json[key];

    QuestionType questionType = _getQuestionType(key);
    Answer answer;

    if (questionType == QuestionType.ascDescOrder) {
      // For 'ascdec' order question type, the answer is a list
      answer = Answer.fromJson({'answer': List<String>.from(value['answer'])});
    } else {
      answer = Answer.fromJson(value);
    }

    return AnswerQuestion(questionType: questionType, answer: answer);
  }

  Map<String, dynamic> toJson() {
    String key = _getKeyFromQuestionType(questionType);
    Map<String, dynamic> answerJson = answer.toJson();

    // Adjust the 'ascdec' order question type in the JSON output
    if (questionType == QuestionType.ascDescOrder) {
      return {
        key: {'answer': answerJson['answer']}
      };
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
      case 'mcqtext':
        return QuestionType.mcqText;
      case 'mcqimg':
        return QuestionType.mcqImage;
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
      case QuestionType.mcqText:
        return 'mcqtext';
      case QuestionType.mcqImage:
        return 'mcqimg';
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
    return StudentAnswer(
      questionNo: int.parse(questionNo),
      question: AnswerQuestion.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {questionNo.toString(): question.toJson()};
  }
}
