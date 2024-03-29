import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/presentation/lesson_mode/bloc/cubit/lesson_mode_cubit.dart';
import 'package:flutter_ar/presentation/lesson_mode/bloc/lesson_page_cubit/lesson_page_cubit.dart';
import 'package:flutter_ar/presentation/lesson_mode/data/model/lesson_model.dart';
import 'package:flutter_ar/presentation/lesson_mode/widgets/fill_in_blank_lesson.dart';
import 'package:flutter_ar/presentation/lesson_mode/widgets/gdrive_lesson.dart';
import 'package:flutter_ar/presentation/lesson_mode/widgets/mcq_q_lesson.dart';
import 'package:flutter_ar/presentation/lesson_mode/widgets/onewordQ_lesson.dart';
import 'package:flutter_ar/presentation/lesson_mode/widgets/truefalse_Q_lesson.dart';
import 'package:flutter_ar/presentation/lesson_mode/widgets/youtube_video_lesson.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:pod_player/pod_player.dart';
import 'package:size_config/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../../worksheet/models/questions.dart';
import '../../worksheet/widgets/questions/mcq_text_question.dart';
import '../widgets/image_lesson.dart';
import '../widgets/model_view_lesson.dart';

class LessonModePage extends StatefulWidget {
  const LessonModePage({super.key});

  @override
  State<LessonModePage> createState() => _LessonModePageState();
}

class _LessonModePageState extends State<LessonModePage> {
  @override
  void initState() {
    super.initState();
    context.read<LessonModeCubit>().loadLesson();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: DeviceType().isMobile ? 56 : 80,
        width: double.infinity,
        color: AppColors.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.wp),
              child: IconButton(
                onPressed: () {
                  context.read<LessonModeCubit>().loadPreviousQuestion();
                },
                icon: Image.asset(
                  'assets/ui/Group.png',
                  height: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.wp),
              child: IconButton(
                onPressed: () {
                  context.read<LessonModeCubit>().loadNextQuestion();
                  int currQuestionIdx =
                      context.read<LessonModeCubit>().state.currentQuestion;
                  bool isLastQuestion = currQuestionIdx ==
                      (context.read<LessonModeCubit>().state.lesson.length - 1);
                  debugPrint('is last index: $isLastQuestion');
                  // context.read<LessonModeCubit>().answerSubmit(false);
                },
                icon: RotatedBox(
                  quarterTurns: 2,
                  child: Image.asset(
                    'assets/ui/Group.png',
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0XFFD1CBF9),
      // appBar: appBarWorksheetSolver(context),
      body: BlocBuilder<LessonModeCubit, LessonModeState>(
        builder: (context, state) {
          if (state.status == LessonModeStatus.loaded) {
            if (state.lesson.isEmpty) {
              return Center(
                child: Text(
                  'No Lessons are available at the moment.',
                  style: AppTextStyles.nunito105w700Text,
                ),
              );
            }
            return getQuestion(state, state.currentQuestion);
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                strokeCap: StrokeCap.round,
              ),
            );
          }
        },
      ),
    );
  }
}

Widget getQuestion(LessonModeState state, int i) {
  debugPrint(jsonEncode(state.lesson[i]));
  if (state.lesson[i].youtubeVideo != null) {
    return YoutubeVideoLesson(ytUrl: state.lesson[i].youtubeVideo!.videoUrl);
  } else if (state.lesson[i].threed != null) {
    return ModelViewLesson(
        modelUrl: state.lesson[i].threed!.url,
        modelName: state.lesson[i].threed!.name);
  } else if (state.lesson[i].image != null) {
    return ImageLesson(
      imgUrl: state.lesson[i].image!.imageUrl,
    );
  } else if (state.lesson[i].gdrive != null) {
    return GdriveLesson(url: state.lesson[i].gdrive!.url);
  } else if (state.lesson[i].mcq != null) {
    var mcqQ = McqTextQuestion(
        answer: state.lesson[i].mcq!.answer,
        options: state.lesson[i].mcq!.options,
        question: state.lesson[i].mcq!.question,
        questionUrl: state.lesson[i].mcq!.questionUrl);
    return MCQLesson(
      question: mcqQ,
      markedAnswer: null,
    );
  } else if (state.lesson[i].fib != null) {
    var fibQ = FillBlankQuestion(
      index: 0,
      answer: state.lesson[i].fib!.answer,
      question: state.lesson[i].fib!.question,
    );
    return FillInTheBlankQLesson(
      question: fibQ,
      markedAnswer: '',
    );
  } else if (state.lesson[i].owa != null) {
    var owqQ = OneWordQuestionType(
      answer: state.lesson[i].owa!.answer,
      question: state.lesson[i].owa!.question,
      questionUrl: state.lesson[i].owa!.questionUrl,
    );
    return OneWordQuestionLesson(
      oneWordQuestion: owqQ,
      markedAnswer: '',
    );
  } else if (state.lesson[i].tf != null) {
    var tfQ = TrueFalseQuestion(
      answer: true,
      question: state.lesson[i].tf!.question,
    );
    return TrueOrFalseLesson(
      question: tfQ,
      markedAnswer: '',
    );
  }
  return Center(
      child: Text(
    'No lesson available at moment.',
    style: AppTextStyles.nunito105w700Text,
  ));
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch ${url}');
  }
}
// class YoutubeVideoViewer extends StatefulWidget {
//   const YoutubeVideoViewer({Key? key, required this.ytUrl}) : super(key: key);
//   final String ytUrl;

//   @override
//   State<YoutubeVideoViewer> createState() => _YoutubeVideoViewerState();
// }

// class _YoutubeVideoViewerState extends State<YoutubeVideoViewer> {
//   late final PodPlayerController controller;
//   bool isLoading = true;
//   @override
//   void initState() {
//     loadVideo();
//     super.initState();
//   }

//   void loadVideo() async {
//     final urls = await PodPlayerController.getYoutubeUrls(
//       widget.ytUrl,
//     );
//     setState(() => isLoading = false);
//     controller = PodPlayerController(
//       playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls!),
//       podPlayerConfig: const PodPlayerConfig(
//         videoQualityPriority: [360],
//       ),
//     )..initialise();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : Center(child: PodVideoPlayer(controller: controller));
//   }
// }



// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ar/presentation/worksheet/widgets/questions/odd_one_out_img_question.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:size_config/size_config.dart';

// import '../../../../core/util/device_type.dart';
// import '../../../core/util/styles.dart';
// import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
// import '../models/questions.dart';
// import '../widgets/appbar_worksheet_solver.dart';
// import '../widgets/bottom_indicator_bar_questions.dart';
// import '../widgets/questions/arithmetic_question.dart';
// import '../widgets/questions/ascending_decending_question.dart';
// import '../widgets/questions/fill_in_blank_question.dart';
// import '../widgets/questions/identify_image_question.dart';
// import '../widgets/questions/long_answer_question.dart';
// import '../widgets/questions/match_the_following_question.dart';
// import '../widgets/questions/mcq_image_question.dart';
// import '../widgets/questions/mcq_text_question.dart';
// import '../widgets/questions/odd_one_out_question.dart';
// import '../widgets/questions/oneword_question.dart';
// import '../widgets/questions/rearrange_words_question.dart';
// import '../widgets/questions/select_correct_word_question.dart';
// import '../widgets/questions/sort_question.dart';
// import '../widgets/questions/true_or_false_question.dart';

// class LessonModePage extends StatefulWidget {
//   final int workSheetId;
//   const LessonModePage({super.key, required this.workSheetId});

//   @override
//   State<LessonModePage> createState() => _LessonModePageState();
// }

// class _LessonModePageState extends State<LessonModePage> {
//   @override
//   void initState() {
//     super.initState();

//     context.read<WorksheetSolverCubit>().setCurrentQuestionZero();
//     context.read<WorksheetSolverCubit>().init(widget.workSheetId);
//   }

//   List<Map<String, dynamic>> answers = [];

//   // Widget getQuestion(WorksheetSolverState state, int i) {
//   //   dynamic markedAnswer = state.answerSheet
//   //       .firstWhereOrNull(
//   //         (element) => element.questionNo == i,
//   //       )
//   //       ?.question
//   //       .answer
//   //       .answer;
//   //   if (markedAnswer != null) {
//   //     debugPrint('markedAnswer: $i$markedAnswer');
//   //   }
//   //   switch (state.questions[i].questionType) {
//   //     case QuestionType.mcqText:
//   //       return MCQTextQuestion(
//   //         questionIndex: i,
//   //         question: state.questions[i] as McqTextQuestion,
//   //         markedAnswer: markedAnswer,
//   //       );
//   //     case QuestionType.mcqImage:
//   //       Size screenSize = MediaQuery.of(context).size;
//   //       return MCQImageQuestion(
//   //           questionIndex: i,
//   //           question: state.questions[i] as McqImageQuestion,
//   //           markedAnswer: markedAnswer,
//   //           screenSize: screenSize);
//   //     case QuestionType.fillBlank:
//   //       Size screenSize = MediaQuery.of(context).size;
//   //       // var oddouQ = OddOneOutImageQuestion(
//   //       //     options: [
//   //       //       'https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/1/worksheet/null/maths_mcq/d6666v8rb/0.png',
//   //       //       'https://d3ag5oij4wsyi3.cloudfront.net/mcq_images/mysurroundings/Sun+in+sky.png',
//   //       //       'https://d3ag5oij4wsyi3.cloudfront.net/mcq_images/mysurroundings/Sun+in+sky.png',
//   //       //       'https://d3ag5oij4wsyi3.cloudfront.net/mcq_images/mysurroundings/Sun+in+sky.png'
//   //       //     ],
//   //       //     answer:
//   //       //         'https://d3ag5oij4wsyi3.cloudfront.net/mcq_images/mysurroundings/Sun+in+sky.png',
//   //       //     question: 'Odd One out image');
//   //       // return OddOneOutImgQuestion(
//   //       //     question: oddouQ,
//   //       //     markedAnswer: markedAnswer,
//   //       //     questionIndex: i,
//   //       //     screenSize: screenSize);

//   //       return FillInTheBlankQuestion(
//   //           question: state.questions[i] as FillBlankQuestion,
//   //           markedAnswer: markedAnswer,
//   //           questionIndex: i,
//   //           screenSize: screenSize);

//   //     case QuestionType.multiplefillblank:
//   //       return const Text('Multiple FillBlank not available');
//   //     case QuestionType.trueFalse:
//   //       return TrueOrFalseQuestion(
//   //         questionIndex: i,
//   //         question: state.questions[i] as TrueFalseQuestion,
//   //         markedAnswer: markedAnswer,
//   //       );

//   //     case QuestionType.matchTheFollowing:
//   //       Size screenSize = MediaQuery.of(context).size;
//   //       return MatchFollowingQuestion(
//   //         question: state.questions[i] as MatchTheFollowingQuestion,
//   //         markedAnswer: markedAnswer,
//   //         screenSize: screenSize,
//   //       );
//   //     case QuestionType.oneWord:
//   //       Size screenSize = MediaQuery.of(context).size;
//   //       // String? ans = markedAnswer;

//   //       return OneWordQuestion(
//   //           questionIndex: i,
//   //           context: context,
//   //           oneWordQuestion: state.questions[i] as OneWordQuestionType,
//   //           markedAnswer: markedAnswer,
//   //           screenSize: screenSize);
//   //     case QuestionType.selectWord:
//   //       return SelectCorrectWordQuestion(
//   //         questionIndex: i,
//   //         question: state.questions[i] as SelectWordQuestion,
//   //         markedAnswer: markedAnswer,
//   //       );
//   //     case QuestionType.oddOneOutText:
//   //       return OddOneOutQuestion(
//   //         questionIndex: i,
//   //         question: state.questions[i] as OddOneOutTextQuestion,
//   //         markedAnswer: markedAnswer,
//   //       );

//   //     case QuestionType.oddOneOutimage:
//   //       OddOneOutImageQuestion oddOneOutImageQuestion =
//   //           state.questions[i] as OddOneOutImageQuestion;
//   //       return _buildOddOneOutImageQuestion(
//   //           i, oddOneOutImageQuestion, markedAnswer);
//   //     case QuestionType.ascDescOrder:
//   //       Size screenSize = MediaQuery.of(context).size;

//   //       return AscendingDecendingQuestion(
//   //           questionIndex: i,
//   //           question: state.questions[i] as AscDescOrderQuestion,
//   //           markedAnswer: markedAnswer,
//   //           screenSize: screenSize);
//   //     case QuestionType.arithmetic:
//   //       return Text(state.questions[i].questionType.toString());
//   //     case QuestionType.longAnswer:
//   //       Size screenSize = MediaQuery.of(context).size;
//   //       return LongAnswerQuestion(
//   //           questionIndex: i,
//   //           question: state.questions[i] as LongAnswerQuestionType,
//   //           markedAnswer: markedAnswer,
//   //           screenSize: screenSize);
//   //     case QuestionType.srotingquestion:
//   //       Size screenSize = MediaQuery.of(context).size;

//   //       // var qty = SortingQuestionType(
//   //       //   category1Data: ["ant", "cat", "dog"],
//   //       //   category2Data: ["bat", "ball", "mat"],
//   //       //   category1: "living",
//   //       //   category2: "non-living",
//   //       //   question: "sort foolowing",
//   //       // );
//   //       return SortQuestion(
//   //           question: state.questions[i] as SortingQuestionType,
//   //           markedAnswer: null,
//   //           questionIndex: i,
//   //           screenSize: screenSize);
//   //     case QuestionType.rearrange:
//   //       Size screenSize = MediaQuery.of(context).size;
//   //       // String questionn =
//   //       //     "This method also of type allows for easier not any shuffling of just array,";
//   //       // String answerr =
//   //       //     "This method also allows for easier shuffling of any type of array, not just";
//   //       // var newQ = RearrangeQuestionType(answer: answerr, question: questionn);
//   //       return ArithmeticQuestionUI(screenSize: screenSize);
//   //       return ReArrangeWordsQuestion(
//   //         screenSize: screenSize,
//   //         question: state.questions[i] as RearrangeQuestionType,
//   //         markedAnswer: ["markedAnswer"],
//   //         questionIndex: i,
//   //       );
//   //     case QuestionType.identifyimage:
//   //       // var newQII = IdentifyImageQuestionType(
//   //       //     answer: 'zoro',
//   //       //     question:
//   //       //         'https://smartxruserfiles1.s3.ap-south-1.amazonaws.com/teacher/1/worksheet/850/ii_mcq/4wfdhskzr/0.png');
//   //       return IdentifyImageQuestion(
//   //         questionIndex: i,
//   //         question: state.questions[i] as IdentifyImageQuestionType,
//   //         markedAnswer: markedAnswer,
//   //       );

//   //     default:
//   //       return Text(
//   //           'UI for ${state.questions[i].questionType.toString()} doesn\'t exists');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         bottomNavigationBar: Container(
//           height: DeviceType().isMobile ? 56 : 80,
//           width: double.infinity,
//           color: AppColors.primaryColor,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 8.wp),
//                 child: IconButton(
//                   onPressed: () {
//                     context.read<WorksheetSolverCubit>().loadPreviousQuestion();
//                   },
//                   icon: Image.asset(
//                     'assets/ui/Group.png',
//                     height: 40,
//                   ),
//                 ),
//               ),
//               const BottomIndicatorQuestions(),
//               Padding(
//                 padding: EdgeInsets.only(right: 8.wp),
//                 child: IconButton(
//                   onPressed: () {
//                     context.read<WorksheetSolverCubit>().loadNextQuestion();
//                     int currQuestionIdx = context
//                         .read<WorksheetSolverCubit>()
//                         .state
//                         .currentQuestion;
//                     bool isLastQuestion = currQuestionIdx ==
//                         (context
//                                 .read<WorksheetSolverCubit>()
//                                 .state
//                                 .questions
//                                 .length -
//                             1);
//                     debugPrint('is last index: $isLastQuestion');
//                     context.read<WorksheetSolverCubit>().answerSubmit(false);
//                   },
//                   icon: RotatedBox(
//                     quarterTurns: 2,
//                     child: Image.asset(
//                       'assets/ui/Group.png',
//                       height: 40,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: const Color(0XFFD1CBF9),
//         appBar: appBarWorksheetSolver(context),
//         body: BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
//           builder: (context, state) {
//             if (state.status == WorkSheetSolverStatus.loaded) {
//               if (state.questions.isEmpty) {
//                 return Center(
//                   child: Text(
//                     'No questions are available in the worksheet at the moment.',
//                     style: AppTextStyles.nunito105w700Text,
//                   ),
//                 );
//               }
//               return getQuestion(state, state.currentQuestion);
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator.adaptive(
//                   strokeCap: StrokeCap.round,
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Column _buildOddOneOutImageQuestion(int i,
//       OddOneOutImageQuestion oddOneOutImageQuestion, dynamic markedAnswer) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//             '${i + 1}) ${oddOneOutImageQuestion.question}'), // Display the question
//         Column(
//           children: List.generate(
//             (oddOneOutImageQuestion.options.length / 2).ceil(),
//             (rowIndex) {
//               int startIndex = rowIndex * 2;
//               int endIndex = startIndex + 2;
//               endIndex = endIndex > oddOneOutImageQuestion.options.length
//                   ? oddOneOutImageQuestion.options.length
//                   : endIndex;

//               return Row(
//                 children: List.generate(
//                   endIndex - startIndex,
//                   (j) {
//                     int optionIndex = startIndex + j;
//                     return Expanded(
//                       child: ListTile(
//                         title: Image.network(
//                           oddOneOutImageQuestion.options[optionIndex],
//                           width: 50, // Adjust the width as needed
//                           height: 50, // Adjust the height as needed
//                         ),
//                         leading: Radio<bool>(
//                           value: markedAnswer ==
//                               oddOneOutImageQuestion.options[optionIndex],
//                           groupValue:
//                               true, // You need to set the group value accordingly
//                           onChanged: (bool? value) {
//                             // Handle radio button selection
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// var worksheet = [
//   ['Living and non-living things', 'EVS', 'Overdue', 'Teacher\'s Name'],
//   ['Vowels and Noun', 'English', '3rd January', 'D. C. Pandey'],
//   ['Fraction and Division', 'Maths', '19th January', 'H. C. Verma'],
//   ['Name of worksheet', 'EVS', '22nd January', 'H. K. Das'],
// ];

// class Lesson extends StatelessWidget {
//   final String title;
//   final String greenTxt;
//   final String redTxt;
//   final String blueTxt;

//   const Lesson({
//     super.key,
//     required this.title,
//     required this.greenTxt,
//     required this.redTxt,
//     required this.blueTxt,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(right: 10, left: 10),
//       width: DeviceType().isMobile ? 45.wp : 35.wp,
//       height: DeviceType().isMobile ? 2.wp : 10.wp,
//       decoration: ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           (DeviceType().isMobile ? 20 : 35).verticalSpacer,
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             height: 70,
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: const Color(0xFF4F3A9C),
//                 fontSize: DeviceType().isMobile ? 18 : 25,
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//             ),
//           ),
//           (DeviceType().isMobile ? 0 : 15).verticalSpacer,
//           //!EVS
//           Container(
//             width: double.maxFinite,
//             // height: 70,
//             margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
//             padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 1.wp),
//             decoration: ShapeDecoration(
//               color: const Color(0xFF9CDDB6),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//             ),
//             child: Text(
//               greenTxt,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: const Color(0xFF074C2B),
//                 fontSize: DeviceType().isMobile ? 16 : 20,
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w400,
//                 height: 0,
//               ),
//             ),
//           ),
//           //!Overdue
//           Container(
//             width: double.maxFinite,
//             // height: 70,
//             margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
//             padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 2.wp),
//             decoration: ShapeDecoration(
//               color: const Color(0xFFFFC1B8),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//             ),
//             child: Text(
//               redTxt,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: const Color(0xFFA94234),
//                 fontSize: DeviceType().isMobile ? 16 : 20,
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w400,
//                 height: 0,
//               ),
//             ),
//           ),
//           //!Teachers name
//           Container(
//             width: double.maxFinite,
//             // height: 70,
//             margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
//             padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 2.wp),
//             decoration: ShapeDecoration(
//               color: const Color(0xFFB3EAFC),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//             ),
//             child: Text(
//               blueTxt,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: const Color(0xFF003A54),
//                 fontSize: DeviceType().isMobile ? 16 : 20,
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w400,
//                 height: 0,
//               ),
//             ),
//           ),
//           10.verticalSpacer,
//           //!Solve
//           Container(
//             width: double.maxFinite,
//             // height: 70,
//             margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
//             padding: EdgeInsets.symmetric(vertical: 3.wp, horizontal: 2.wp),
//             decoration: ShapeDecoration(
//               color: const Color(0xFF8C7DF0),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25)),
//             ),
//             child: Text(
//               'Solve',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: DeviceType().isMobile ? 18 : 24,
//                 fontFamily: 'Nunito',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//             ),
//           ),
//           // 15.verticalSpacer,
//         ],
//       ),
//     );
//   }
// }

// DateTime createDateTime(String dateStr, String timeStr) {
//   List<int> dateParts =
//       dateStr.split('-').map((part) => int.parse(part)).toList();

//   List<String> timeParts = timeStr.split(' ');
//   List<int> timeHourMinute =
//       timeParts[0].split(':').map((part) => int.parse(part)).toList();

//   int hour = timeHourMinute[0];
//   int minute = timeHourMinute[1];

//   if (timeParts[1] == 'pm' && hour != 12) {
//     hour += 12;
//   }

//   return DateTime(dateParts[0], dateParts[1], dateParts[2], hour, minute);
// }

// DateTime convertToDate(String dateString) {
//   List<int> dateParts =
//       dateString.split('-').map((part) => int.parse(part)).toList();
//   return DateTime(dateParts[0], dateParts[1], dateParts[2]);
// }
