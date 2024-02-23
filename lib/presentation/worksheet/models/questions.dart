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
  rearrange,
  identifyimage,
  srotingquestion
}

abstract class Question {
  late String question;
  late QuestionType questionType;

  Question();

  Question.withType(this.question, this.questionType);

  String getQuestionTypeString() {
    switch (questionType) {
      case QuestionType.mcqText:
        return "Multiple Choice Questions";
      case QuestionType.mcqImage:
        return "Multiple Choice Questions";
      case QuestionType.fillBlank:
        return "Fill in the Blanks";
      case QuestionType.multiplefillblank:
        return "Multiple Fill in the Blanks";
      case QuestionType.trueFalse:
        return "True or False";
      case QuestionType.matchTheFollowing:
        return "Match the Following";
      case QuestionType.oneWord:
        return "One Word Answer";
      case QuestionType.matchTheFollowingWithOptions:
        return "Match the Following with Options";
      case QuestionType.selectWord:
        return "Select the Correct Word";
      case QuestionType.oddOneOutText:
        return "Pick the Odd One Out";
      case QuestionType.oddOneOutimage:
        return "Odd One Out (Image)";
      case QuestionType.ascDescOrder:
        return "Ascending and Descending Order";
      case QuestionType.arithmetic:
        return "Arithmetic";
      case QuestionType.longAnswer:
        return "Long Answer";
      case QuestionType.rearrange:
        return "Re-Arrange";
      case QuestionType.identifyimage:
        return "Identify Image";
      case QuestionType.srotingquestion:
        return "Sort the Following";
    }
  }
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
  final dynamic answer; // Updated the type to dynamic
  // final String index;

  FillBlankQuestion({required this.answer, required String question})
      : super.withType(question, QuestionType.fillBlank);

  factory FillBlankQuestion.fromJson(Map<String, dynamic> json) {
    var answer = json['fillblank']['answer'];
    if (answer is List) {
      // If answer is a List, keep it as is
    } else if (answer is String) {
      // If answer is a String, convert it to a List with a single element
      answer = [answer];
    }

    return FillBlankQuestion(
      answer: answer,
      // index: json['fillblank']['index'],
      question: json['fillblank']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fillblank': {
          'answer': answer,
          // 'index': index,
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
class OneWordQuestionType extends Question {
  final String answer;
  final String questionUrl;
  OneWordQuestionType(
      {required this.answer,
      required this.questionUrl,
      required String question})
      : super.withType(question, QuestionType.oneWord);

  factory OneWordQuestionType.fromJson(Map<String, dynamic> json) {
    return OneWordQuestionType(
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

// LongAnswer Question
class LongAnswerQuestionType extends Question {
  // final String questionUrl;
  // final String questionRows;
  // final String questionAnswer;
  final List<String> questionKeywords;

  LongAnswerQuestionType(
      {required this.questionKeywords,
      // required this.questionUrl,
      // required this.questionRows,
      // required this.questionAnswer,
      required String question})
      : super.withType(question, QuestionType.longAnswer);

  factory LongAnswerQuestionType.fromJson(Map<String, dynamic> json) {
    return LongAnswerQuestionType(
      // questionUrl: json['longanswer']['question_url'],
      // questionRows: json['longanswer']['question_rows'],
      // questionAnswer: json['longanswer']['question_answer'],
      questionKeywords:
          List<String>.from(json['longanswer']['question_keywords']),
      question: json['longanswer']['question'],
    );
  }

  Map<String, dynamic> toJson() => {
        'longanswer': {
          // 'question_url': questionUrl,
          // 'question_answer': questionAnswer,
          // 'question_rows': questionRows,
          'question_keywords': questionKeywords,
          'question': question,
        },
      };
}

// Rearrange Question
class RearrangeQuestionType extends Question {
  final String answer;

  RearrangeQuestionType({required this.answer, required String question})
      : super.withType(question, QuestionType.rearrange);

  factory RearrangeQuestionType.fromJson(Map<String, dynamic> json) {
    return RearrangeQuestionType(
      question: json['rearrange']['question'],
      answer: json['rearrange']['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'rearrange': {
          'answer': answer,
          'question': question,
        },
      };
}

// Identify Image Question
class IdentifyImageQuestionType extends Question {
  final String answer;

  IdentifyImageQuestionType({required this.answer, required String question})
      : super.withType(question, QuestionType.identifyimage);

  factory IdentifyImageQuestionType.fromJson(Map<String, dynamic> json) {
    return IdentifyImageQuestionType(
      question: json['identifyimage']['question'],
      answer: json['identifyimage']['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'identifyimage': {
          'answer': answer,
          'question': question,
        },
      };
}

// Sorting Question
class SortingQuestionType extends Question {
  final String category1;
  final String category2;
  final List<String> category1Data;
  final List<String> category2Data;

  SortingQuestionType(
      {required this.category1Data,
      required this.category2Data,
      required this.category1,
      required this.category2,
      required String question})
      : super.withType(question, QuestionType.srotingquestion);

  factory SortingQuestionType.fromJson(Map<String, dynamic> json) {
    return SortingQuestionType(
      question: json['srotingquestion']['question'],
      category1: json['srotingquestion']['category1'],
      category2: json['srotingquestion']['category2'],
      category1Data:
          List<String>.from(json['srotingquestion']['category1_data']),
      category2Data:
          List<String>.from(json['srotingquestion']['category2_data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'srotingquestion': {
          'question': question,
          'category1': category1,
          'category2': category2,
          'category1_data': category1Data,
          'category2_data': category2Data,
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
          allQuestions.add(OneWordQuestionType.fromJson(questionData));
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
        case 'longanswer':
          allQuestions.add(LongAnswerQuestionType.fromJson(questionData));
          break;
        case 'identifyimage':
          allQuestions.add(IdentifyImageQuestionType.fromJson(questionData));
          break;
        case 'rearrange':
          allQuestions.add(RearrangeQuestionType.fromJson(questionData));
          break;
        case 'srotingquestion':
          allQuestions.add(SortingQuestionType.fromJson(questionData));
          break;
        // Add cases for other question types here
      }
    }
  }

  // Now, allQuestions list contains instances of different question types
  return allQuestions;
}
