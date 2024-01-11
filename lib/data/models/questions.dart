import 'dart:convert';

enum QuestionType {
  mcqText,
  mcqImage,
  fillBlank,
  multiplefillblank,
  trueFalse,
  matchTheFollowing,
  oneWord,
  matchTheFollowingWithOptions,
  selectWord,
  oddOneOutText,
  oddOneOutimage,
  ascDescOrder,
  arithmetic,
  longAnswer,
}

abstract class Question {
  late String question;
  late QuestionType questionType;

  Question();

  Question.withType(this.question, this.questionType);
}

class McqTextQuestion extends Question {
  final List<String> options;
  final String answer;
  final String questionUrl;

  McqTextQuestion({
    required this.options,
    required this.answer,
    required String question,
    required this.questionUrl,
  }) : super.withType(question, QuestionType.mcqText);

  factory McqTextQuestion.fromJson(Map<String, dynamic> json) {
    return McqTextQuestion(
      options: List<String>.from(json['mcqtext']['options']),
      answer: json['mcqtext']['answer'],
      question: json['mcqtext']['question'],
      questionUrl: json['mcqtext']['question_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mcqtext': {
          'options': options,
          'answer': answer,
          'question': question,
          'question_url': questionUrl,
        },
      };
}

// MCQ Image Question
class McqImageQuestion extends Question {
  final List<String> options;
  final String answer;
  final String questionUrl;

  McqImageQuestion(
      {required this.options,
      required this.answer,
      required String question,
      required this.questionUrl})
      : super.withType(question, QuestionType.mcqImage);

  factory McqImageQuestion.fromJson(Map<String, dynamic> json) {
    return McqImageQuestion(
      options: List<String>.from(json['mcqimg']['options']),
      answer: json['mcqimg']['answer'],
      question: json['mcqimg']['question'],
      questionUrl: json['mcqimg']['question_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mcqimg': {
          'options': options,
          'answer': answer,
          'question': question,
          'question_url': questionUrl,
        },
      };
}

// Fill in the Blank Question
class FillBlankQuestion extends Question {
  final String answer;
  final String index;

  FillBlankQuestion(
      {required this.answer, required this.index, required String question})
      : super.withType(question, QuestionType.fillBlank);

  factory FillBlankQuestion.fromJson(Map<String, dynamic> json) {
    return FillBlankQuestion(
      answer: json['fillblank']['answer'],
      index: json['fillblank']['index'],
      question: json['fillblank']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fillblank': {
          'answer': answer,
          'index': index,
          'question': question,
        },
      };
}

// Multiple Fill in the Blank Question
class MultipleFillBlankQuestion extends Question {
  final List<String> answer;
  final List<String> index;

  MultipleFillBlankQuestion(
      {required this.answer, required this.index, required String question})
      : super.withType(question, QuestionType.multiplefillblank);

  factory MultipleFillBlankQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleFillBlankQuestion(
      answer: List<String>.from(json['multiplefillblank']['answer']),
      index: List<String>.from(json['multiplefillblank']['index']),
      question: json['multiplefillblank']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'multiplefillblank': {
          'answer': answer,
          'index': index,
          'question': question,
        },
      };
}

// True/False Question
class TrueFalseQuestion extends Question {
  final bool answer;

  TrueFalseQuestion({required this.answer, required String question})
      : super.withType(question, QuestionType.trueFalse);

  factory TrueFalseQuestion.fromJson(Map<String, dynamic> json) {
    return TrueFalseQuestion(
      answer: json['truefalse']['answer'] == "True",
      question: json['truefalse']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'truefalse': {
          'answer': answer ? "True" : "False",
          'question': question,
        },
      };
}

// Match the Following Question
class MatchTheFollowingQuestion extends Question {
  final Map<String, String> options;

  MatchTheFollowingQuestion({required this.options, required String question})
      : super.withType(question, QuestionType.matchTheFollowing);

  factory MatchTheFollowingQuestion.fromJson(Map<String, dynamic> json) {
    return MatchTheFollowingQuestion(
      options: Map<String, String>.from(json['mtf']['options']),
      question: json['mtf']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mtf': {
          'options': options,
          'question': question,
        },
      };
}

// One Word Question
class OneWordQuestion extends Question {
  final String answer;
  final String questionUrl;
  OneWordQuestion(
      {required this.answer,
      required this.questionUrl,
      required String question})
      : super.withType(question, QuestionType.oneWord);

  factory OneWordQuestion.fromJson(Map<String, dynamic> json) {
    return OneWordQuestion(
      answer: json['oneword']['answer'],
      question: json['oneword']['question'],
      questionUrl: json['oneword']['question_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'oneword': {
          'answer': answer,
          'question': question,
          'question_url': questionUrl,
        },
      };
}

// Match the Following Question
class MatchTheFollowingWithOptionsQuestion extends Question {
  final Map<String, String> options;

  MatchTheFollowingWithOptionsQuestion(
      {required this.options, required String question})
      : super.withType(question, QuestionType.matchTheFollowingWithOptions);

  factory MatchTheFollowingWithOptionsQuestion.fromJson(
      Map<String, dynamic> json) {
    return MatchTheFollowingWithOptionsQuestion(
      options: Map<String, String>.from(json['mtf']['options']),
      question: json['mtf']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mtf': {
          'options': options,
          'question': question,
        },
      };
}

// Select Word Question
class SelectWordQuestion extends Question {
  final String answer;
  final String index;

  SelectWordQuestion(
      {required this.answer, required this.index, required String question})
      : super.withType(question, QuestionType.selectWord);

  factory SelectWordQuestion.fromJson(Map<String, dynamic> json) {
    return SelectWordQuestion(
      answer: json['selectword']['answer'],
      index: json['selectword']['index'],
      question: json['selectword']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'selectword': {
          'answer': answer,
          'index': index,
          'question': question,
        },
      };
}

// Odd One Out Text Question
class OddOneOutTextQuestion extends Question {
  final List<String> options;
  final String answer;

  OddOneOutTextQuestion(
      {required this.options, required this.answer, required String question})
      : super.withType(question, QuestionType.oddOneOutText);

  factory OddOneOutTextQuestion.fromJson(Map<String, dynamic> json) {
    return OddOneOutTextQuestion(
      options: List<String>.from(json['oddoneouttext']['options']),
      answer: json['oddoneouttext']['answer'],
      question: json['oddoneouttext']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'oddoneouttext': {
          'options': options,
          'answer': answer,
          'question': question,
        },
      };
}

// Odd One Out Text Question
class OddOneOutImageQuestion extends Question {
  final List<String> options;
  final String answer;

  OddOneOutImageQuestion(
      {required this.options, required this.answer, required String question})
      : super.withType(question, QuestionType.oddOneOutimage);

  factory OddOneOutImageQuestion.fromJson(Map<String, dynamic> json) {
    return OddOneOutImageQuestion(
      options: List<String>.from(json['oddoneoutimg']['options']),
      answer: json['oddoneoutimg']['answer'],
      question: json['oddoneoutimg']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'oddoneoutimg': {
          'options': options,
          'answer': answer,
          'question': question,
        },
      };
}

// Ascending/Descending Order Question
class AscDescOrderQuestion extends Question {
  final List<String> numbers;
  final String order;
  final String type;

  AscDescOrderQuestion(
      {required this.numbers,
      required this.order,
      required this.type,
      required String question})
      : super.withType(question, QuestionType.ascDescOrder);

  factory AscDescOrderQuestion.fromJson(Map<String, dynamic> json) {
    return AscDescOrderQuestion(
      numbers: List<String>.from(json['ascdesc']['numbers']),
      order: json['ascdesc']['order'],
      type: json['ascdesc']['type'],
      question: json['ascdesc']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ascdesc': {
          'numbers': numbers,
          'order': order,
          'type': type,
          'question': question,
        },
      };
}

// Arithmetic Question
class ArithmeticQuestion extends Question {
  final String num1;
  final String num2;
  final String operator;
  final String answer;

  ArithmeticQuestion(
      {required this.num1,
      required this.num2,
      required this.operator,
      required this.answer,
      required String question})
      : super.withType(question, QuestionType.arithmetic);

  factory ArithmeticQuestion.fromJson(Map<String, dynamic> json) {
    return ArithmeticQuestion(
      num1: json['arithematic']['num1'],
      num2: json['arithematic']['num2'],
      operator: json['arithematic']['operator'],
      answer: json['arithematic']['answer'],
      question: json['arithematic']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'arithematic': {
          'num1': num1,
          'num2': num2,
          'operator': operator,
          'answer': answer,
          'question': question,
        },
      };
}

List<Question> allWorsheetQuestins(String yourApiResponse) {
  // Example of parsing the provided JSON response
  final List<List<Map<String, dynamic>>> questionsList =
      (jsonDecode(yourApiResponse) as List<dynamic>)
              .map<List<Map<String, dynamic>>>((item) =>
                  (item as List<dynamic>).cast<Map<String, dynamic>>())
              .toList() ??
          [];
  List<Question> allQuestions = [];

  for (List<Map<String, dynamic>> categoryQuestions in questionsList) {
    for (Map<String, dynamic> questionData in categoryQuestions) {
      String questionType =
          questionData.keys.first; // Assuming there's only one key in each map

      switch (questionType) {
        case 'mcqtext':
          allQuestions.add(McqTextQuestion.fromJson(questionData));
          break;
        case 'mcqimg':
          allQuestions.add(McqImageQuestion.fromJson(questionData));
          break;
        case 'fillblank':
          allQuestions.add(FillBlankQuestion.fromJson(questionData));
          break;
        case 'multiplefillblank':
          allQuestions.add(MultipleFillBlankQuestion.fromJson(questionData));
          break;
        case 'truefalse':
          allQuestions.add(TrueFalseQuestion.fromJson(questionData));
          break;
        case 'mtf':
          allQuestions.add(MatchTheFollowingQuestion.fromJson(questionData));
          break;
        case 'oneword':
          allQuestions.add(OneWordQuestion.fromJson(questionData));
          break;
        case 'selectword':
          allQuestions.add(SelectWordQuestion.fromJson(questionData));
          break;
        case 'oddoneouttext':
          allQuestions.add(OddOneOutTextQuestion.fromJson(questionData));
          break;
        case 'oddoneoutimg':
          allQuestions.add(OddOneOutImageQuestion.fromJson(questionData));
          break;
        case 'ascdesc':
          allQuestions.add(AscDescOrderQuestion.fromJson(questionData));
          break;
        case 'arithematic':
          allQuestions.add(ArithmeticQuestion.fromJson(questionData));
          break;

        // Add cases for other question types here
      }
    }
  }

  // Now, allQuestions list contains instances of different question types
  print(allQuestions);
  return allQuestions;
}
