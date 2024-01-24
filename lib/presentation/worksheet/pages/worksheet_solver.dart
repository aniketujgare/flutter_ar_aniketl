import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/temp_testing/draw_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../../../core/util/styles.dart';
import '../models/questions.dart';
import '../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../models/worksheet_ans_of_student.dart';

class WorksheetSolverView extends StatefulWidget {
  final int workSheetId;
  final int studentId;
  const WorksheetSolverView(
      {super.key, required this.workSheetId, required this.studentId});

  @override
  State<WorksheetSolverView> createState() => _WorksheetSolverViewState();
}

class _WorksheetSolverViewState extends State<WorksheetSolverView> {
  @override
  void initState() {
    super.initState();
    context.read<WorksheetSolverCubit>().setCurrentQuestionZero();
    context
        .read<WorksheetSolverCubit>()
        .init(widget.workSheetId, widget.studentId);
    print('workshetid: ${widget.workSheetId}, studentid: ${widget.studentId}');
    // context.read<WorksheetAnsOfStudentCubit>().getStudentWorksheetData();
    // super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(systemNavigationBarColor: AppColors.parentZoneScaffoldColor));
  }

  // @override
  // void dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);
  //   super.dispose();
  // }

  List<Map<String, dynamic>> answers = [];

  Widget getQuestion(WorksheetSolverState state, int i) {
    dynamic markedAnswer = state.answerSheet
        .firstWhereOrNull(
          (element) => element.questionNo == i,
        )
        ?.question
        .answer
        .answer;
    if (markedAnswer != null) {
      print('markedAnswer: $i$markedAnswer');
    }
    switch (state.questions[i].questionType) {
      case QuestionType.mcqText:
        McqTextQuestion mcqTextQuestion = state.questions[i] as McqTextQuestion;
        return _buildMcqTextQuestion(i, mcqTextQuestion, markedAnswer);
      case QuestionType.mcqImage:
        McqImageQuestion mcqImageQuestion =
            state.questions[i] as McqImageQuestion;
        return _buildMcqImageQuestion(i, mcqImageQuestion, markedAnswer);
      case QuestionType.fillBlank:
        FillBlankQuestion fillBlankQuestion =
            state.questions[i] as FillBlankQuestion;
        return _buildFillBlankQuestion(i, fillBlankQuestion, markedAnswer);

      case QuestionType.multiplefillblank:
        MultipleFillBlankQuestion multipleFillBlankQuestion =
            state.questions[i] as MultipleFillBlankQuestion;
        return _buildMultipleFillBlankQuestion(
            i, multipleFillBlankQuestion, markedAnswer);
      case QuestionType.trueFalse:
        TrueFalseQuestion trueFalseQuestion =
            state.questions[i] as TrueFalseQuestion;

        bool? isTrueSelected = markedAnswer == 'True';
        bool? isFalseSelected = markedAnswer == 'False';
        return _buildTrueFalseQuestion(
            i, trueFalseQuestion, isTrueSelected, isFalseSelected);

      case QuestionType.matchTheFollowing:
        MatchTheFollowingQuestion matchTheFollowingQuestion =
            state.questions[i] as MatchTheFollowingQuestion;
        var shuffledOptions = matchTheFollowingQuestion.options.entries.toList()
          ..shuffle();
        //!select the odd own out q ui
        // List<String> otions1 = [
        //   'The',
        //   'question',
        //   'will',
        //   'be',
        //   'in',
        //   'options'
        // ];
        // return Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     80.verticalSpacer,
        //     Text(
        //       'The, question, will, be, in, options',
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(
        //         color: Color(0xFF212121),
        //         fontSize: 32,
        //         fontFamily: 'Nunito',
        //         fontWeight: FontWeight.w500,
        //         height: 0,
        //       ),
        //     ),
        //     80.verticalSpacer,
        //     // Text('${i + 1}) ${mcqTextQuestion.question}'),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         ...List.generate(
        //             6,
        //             (index) => Container(
        //                   width: 30.wp,
        //                   padding: EdgeInsets.symmetric(vertical: 2.wp),
        //                   decoration: ShapeDecoration(
        //                     color: const Color(0xFFF4F2FE),
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(17),
        //                     ),
        //                   ),
        //                   child: Text(
        //                     otions1[index],
        //                     textAlign: TextAlign.center,
        //                     style: const TextStyle(
        //                       color: Color(0xFF4F3A9C),
        //                       fontSize: 20,
        //                       fontFamily: 'Nunito',
        //                       fontWeight: FontWeight.w700,
        //                       height: 0,
        //                     ),
        //                   ),
        //                 ))
        //       ],
        //     ),
        //   ],
        // );
        // //!select the correct word  q ui
        // List<String> otions = [
        //   'This',
        //   'is',
        //   'the',
        //   'test',
        //   'question',
        //   'sentence'
        // ];
        // return Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     80.verticalSpacer,
        //     Text(
        //       'This is the test question sentence.',
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(
        //         color: Color(0xFF212121),
        //         fontSize: 32,
        //         fontFamily: 'Nunito',
        //         fontWeight: FontWeight.w500,
        //         height: 0,
        //       ),
        //     ),
        //     80.verticalSpacer,
        //     // Text('${i + 1}) ${mcqTextQuestion.question}'),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         ...List.generate(
        //             6,
        //             (index) => Container(
        //                   width: 30.wp,
        //                   padding: EdgeInsets.symmetric(vertical: 2.wp),
        //                   decoration: ShapeDecoration(
        //                     color: const Color(0xFFF4F2FE),
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(17),
        //                     ),
        //                   ),
        //                   child: Text(
        //                     otions[index],
        //                     textAlign: TextAlign.center,
        //                     style: const TextStyle(
        //                       color: Color(0xFF4F3A9C),
        //                       fontSize: 20,
        //                       fontFamily: 'Nunito',
        //                       fontWeight: FontWeight.w700,
        //                       height: 0,
        //                     ),
        //                   ),
        //                 ))
        //       ],
        //     ),
        //   ],
        // );
        // //! ascending descending q ui
        // return Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     60.verticalSpacer,
        //     Text(
        //       'Arrange the test options in order',
        //       textAlign: TextAlign.center,
        //       style: const TextStyle(
        //         color: Color(0xFF212121),
        //         fontSize: 32,
        //         fontFamily: 'Nunito',
        //         fontWeight: FontWeight.w500,
        //         height: 0,
        //       ),
        //     ),
        //     50.verticalSpacer,
        //     // Text('${i + 1}) ${mcqTextQuestion.question}'),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         ...List.generate(
        //             6,
        //             (index) => Container(
        //                   width: 30.wp,
        //                   padding: EdgeInsets.symmetric(vertical: 2.wp),
        //                   decoration: ShapeDecoration(
        //                     color: const Color(0xFFF4F2FE),
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(17),
        //                     ),
        //                   ),
        //                   child: Text(
        //                     'Option ${index + 1}',
        //                     textAlign: TextAlign.center,
        //                     style: const TextStyle(
        //                       color: Color(0xFF4F3A9C),
        //                       fontSize: 20,
        //                       fontFamily: 'Nunito',
        //                       fontWeight: FontWeight.w700,
        //                       height: 0,
        //                     ),
        //                   ),
        //                 ))
        //       ],
        //     ),
        //     50.verticalSpacer,
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         ...List.generate(
        //             6,
        //             (index) => Container(
        //                   width: 30.wp,
        //                   padding: EdgeInsets.symmetric(vertical: 2.wp),
        //                   decoration: ShapeDecoration(
        //                     color: const Color(0xFFF4F2FE),
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(17),
        //                     ),
        //                   ),
        //                   child: Text(
        //                     'Option ${index + 1}',
        //                     textAlign: TextAlign.center,
        //                     style: const TextStyle(
        //                       color: const Color(0xFFF4F2FE),
        //                       fontSize: 22,
        //                       fontFamily: 'Nunito',
        //                       fontWeight: FontWeight.w700,
        //                       height: 0,
        //                     ),
        //                   ),
        //                 ))
        //       ],
        //     ),
        //   ],
        // );

        return _buildMatchTheFollowingQuestion(
            i, matchTheFollowingQuestion, shuffledOptions, markedAnswer);
      case QuestionType.oneWord:
        OneWordQuestion oneWordQuestion = state.questions[i] as OneWordQuestion;
        String? ans = markedAnswer;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            50.verticalSpacer,
            Text(
              oneWordQuestion.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 32,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            45.verticalSpacer,
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 70.wp,
                      height: 50,
                      child: Image.asset(
                        'assets/images/PNG Icons/Vector.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: 70.wp,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          // labelText: 'Type your answer',
                          border: InputBorder.none,
                        ),
                        initialValue: ans,
                        onChanged: (value) {
                          // if (markedAnswers.length > j) {
                          //   markedAnswers[j] = value;
                          // } else {
                          //   markedAnswers.add(value);
                          // }
                        },
                        onEditingComplete: () {
                          print('complete');
                          context
                              .read<WorksheetSolverCubit>()
                              .setAnswer(i, ans);
                        },
                      ),
                    ),
                  ],
                ),
                5.horizontalSpacerPercent,
                Container(
                    width: 50,
                    child: Image.asset('assets/images/PNG Icons/Cam 1.png'))
              ],
            ),
          ],
        );
      case QuestionType.selectWord:
        SelectWordQuestion selectWordQuestion =
            state.questions[i] as SelectWordQuestion;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i + 1}) ${selectWordQuestion.question}'),
            TextFormField(
              initialValue: (markedAnswer as String?) ?? '',
            ),
            const SizedBox(height: 10),
          ],
        );
      case QuestionType.oddOneOutText:
        OddOneOutTextQuestion oddOneOutTextQuestion =
            state.questions[i] as OddOneOutTextQuestion;
        return _buildOddOneOutTextQuestion(
            i, oddOneOutTextQuestion, markedAnswer);
      case QuestionType.oddOneOutimage:
        OddOneOutImageQuestion oddOneOutImageQuestion =
            state.questions[i] as OddOneOutImageQuestion;
        return _buildOddOneOutImageQuestion(
            i, oddOneOutImageQuestion, markedAnswer);
      case QuestionType.ascDescOrder:
        AscDescOrderQuestion ascDescOrderQuestion =
            state.questions[i] as AscDescOrderQuestion;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i + 1}) ${ascDescOrderQuestion.question}'),
            Text(ascDescOrderQuestion.numbers.join(' ,')),
            TextFormField(
                initialValue: (markedAnswer as List<String>?) == null
                    ? ''
                    : (markedAnswer as List<String>).join(' ,')),
          ],
        );
      case QuestionType.arithmetic:
        return Text(state.questions[i].questionType.toString());
      case QuestionType.longAnswer:
        LongAnswerQuestion longAnswerQuestion =
            state.questions[i] as LongAnswerQuestion;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i + 1}) ${longAnswerQuestion.question}'),
            Text(longAnswerQuestion.questionKeywords.join(', ')),
            TextFormField(initialValue: (markedAnswer as String?) ?? ''),
          ],
        );
      default:
        return const Center(
            child: CircularProgressIndicator.adaptive(
          strokeCap: StrokeCap.round,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0XFFD1CBF9),
          appBar: _appBar(context),
          body: Padding(
              padding: EdgeInsets.fromLTRB(5.wp, 0, 5.wp, 0),
              child: SizedBox.expand(child:
                  BlocBuilder<WorksheetSolverCubit, WorksheetSolverState>(
                builder: (context, state) {
                  if (state.status == WorkSheetSolverStatus.loaded) {
                    // print(jsonEncode(state.questions));
                    print(state.currentQuestion);
                    return Stack(
                      children: [
                        getQuestion(state, state.currentQuestion),
                        Transform.translate(
                          offset: const Offset(-20, -10),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () => context
                                    .read<WorksheetSolverCubit>()
                                    .loadNextQuestion(),
                                icon: RotatedBox(
                                  quarterTurns: 2,
                                  child: Image.asset(
                                    'assets/ui/Group.png',
                                    height: 40,
                                  ),
                                )),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -20),
                          child: const Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Question - 1/21',
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              )),
                        ),
                        Transform.translate(
                          offset: const Offset(20, -10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                                onPressed: () => context
                                    .read<WorksheetSolverCubit>()
                                    .loadPreviousQuestion(),
                                icon: Image.asset(
                                  'assets/ui/Group.png',
                                  height: 40,
                                )),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator.adaptive(
                            strokeCap: StrokeCap.round));
                  }
                },
              ))),
        ),
      ),
    );
  }

  Column _buildOddOneOutImageQuestion(int i,
      OddOneOutImageQuestion oddOneOutImageQuestion, dynamic markedAnswer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${i + 1}) ${oddOneOutImageQuestion.question}'), // Display the question
        Column(
          children: List.generate(
            (oddOneOutImageQuestion.options.length / 2).ceil(),
            (rowIndex) {
              int startIndex = rowIndex * 2;
              int endIndex = startIndex + 2;
              endIndex = endIndex > oddOneOutImageQuestion.options.length
                  ? oddOneOutImageQuestion.options.length
                  : endIndex;

              return Row(
                children: List.generate(
                  endIndex - startIndex,
                  (j) {
                    int optionIndex = startIndex + j;
                    return Expanded(
                      child: ListTile(
                        title: Image.network(
                          oddOneOutImageQuestion.options[optionIndex],
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                        ),
                        leading: Radio<bool>(
                          value: markedAnswer ==
                              oddOneOutImageQuestion.options[optionIndex],
                          groupValue:
                              true, // You need to set the group value accordingly
                          onChanged: (bool? value) {
                            // Handle radio button selection
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column _buildOddOneOutTextQuestion(int i,
      OddOneOutTextQuestion oddOneOutTextQuestion, dynamic markedAnswer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${i + 1}) ${oddOneOutTextQuestion.question}'), // Display the question
        Column(
          children: List.generate(
            (oddOneOutTextQuestion.options.length / 2).ceil(),
            (rowIndex) {
              int startIndex = rowIndex * 2;
              int endIndex = startIndex + 2;
              endIndex = endIndex > oddOneOutTextQuestion.options.length
                  ? oddOneOutTextQuestion.options.length
                  : endIndex;

              return Row(
                children: List.generate(
                  endIndex - startIndex,
                  (j) {
                    int optionIndex = startIndex + j;
                    return Expanded(
                      child: ListTile(
                        title: Text(oddOneOutTextQuestion.options[optionIndex]),
                        leading: Radio<bool>(
                          value: oddOneOutTextQuestion.options[optionIndex] ==
                                  markedAnswer
                              ? true
                              : false,
                          groupValue: true,
                          onChanged: null, // Set to null to disable interaction
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatchTheFollowingQuestion(
      int i,
      MatchTheFollowingQuestion matchTheFollowingQuestion,
      List<MapEntry<String, String>> shuffledOptions,
      dynamic markedAnswer) {
    return MatchTheFollowingTest(
      matchTheFollowingQuestion: matchTheFollowingQuestion,
      shuffledOptions: shuffledOptions,
      markedAnswer: markedAnswer,
    );
  }

  Column _buildTrueFalseQuestion(int i, TrueFalseQuestion trueFalseQuestion,
      bool? isTrueSelected, bool? isFalseSelected) {
    String newAns = '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        80.verticalSpacer,
        Text(
          trueFalseQuestion.question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF212121),
            fontSize: 32,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        80.verticalSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.wp,
              padding: EdgeInsets.symmetric(vertical: 2.wp),
              decoration: ShapeDecoration(
                color: const Color(0xFFF4F2FE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: const Text(
                'True',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4F3A9C),
                  fontSize: 22,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            10.horizontalSpacerPercent,
            Container(
              width: 60.wp,
              padding: EdgeInsets.symmetric(vertical: 2.wp),
              decoration: ShapeDecoration(
                color: const Color(0xFFF4F2FE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: const Text(
                "False",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4F3A9C),
                  fontSize: 22,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Column _buildMultipleFillBlankQuestion(
      int i,
      MultipleFillBlankQuestion multipleFillBlankQuestion,
      dynamic markedAnswer) {
    String ansVal1 = '';
    String ansVal2 = '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${i + 1}) ${multipleFillBlankQuestion.question}'),
        // TextFormField(
        //     initialValue: markedAnswer == null
        //         ? ''
        //         : (markedAnswer as List<String>).join(' ,')),
        TextFormField(
          // initialValue: newAns,
          onChanged: (value) {
            ansVal1 = value;
          },
          onEditingComplete: () {},
        ),
        TextFormField(
            initialValue: markedAnswer == null
                ? ''
                : (markedAnswer as List<String>).join(' ,')),
        TextFormField(
          // initialValue: newAns,
          onChanged: (value) {
            ansVal2 = value;
          },
          onEditingComplete: () {
            print('compelte');
            var ansf = [ansVal1, ansVal2];
            context.read<WorksheetSolverCubit>().setAnswer(i, ansf);
          },
        ),
      ],
    );
  }

  Column _buildFillBlankQuestion(
      int i, FillBlankQuestion fillBlankQuestion, dynamic markedAnswer) {
    List<String> markedAnswers = [];
    print('markedAnswer type: ${markedAnswer.runtimeType}');
    if (markedAnswer is List<dynamic>) {
      markedAnswers.addAll(markedAnswer.map((element) => element.toString()));
      print('listString');
    } else if (markedAnswer is String) {
      markedAnswers.add(markedAnswer);
      print('String');
    }

    print('markedAnswers: $i $markedAnswers');
    int noOfTextFileds = 1;
    if (fillBlankQuestion.answer is List<dynamic>) {
      noOfTextFileds = (fillBlankQuestion.answer as List<dynamic>).length;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        50.verticalSpacer,
        Text(
          fillBlankQuestion.question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF212121),
            fontSize: 32,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        45.verticalSpacer,
        ...List.generate(
          noOfTextFileds,
          (j) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${j + 1}.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF4D4D4D),
                    fontSize: 24,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                5.horizontalSpacerPercent,
                Stack(
                  children: [
                    Container(
                      width: 70.wp,
                      height: 50,
                      child: Image.asset(
                        'assets/images/PNG Icons/Vector.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: 70.wp,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          // labelText: 'Type your answer',
                          border: InputBorder.none,
                        ),
                        initialValue:
                            markedAnswers.length > j ? markedAnswers[j] : '',
                        onChanged: (value) {
                          if (markedAnswers.length > j) {
                            markedAnswers[j] = value;
                          } else {
                            markedAnswers.add(value);
                          }
                        },
                        onEditingComplete: () {
                          print('complete');
                          context
                              .read<WorksheetSolverCubit>()
                              .setAnswer(i, markedAnswers);
                        },
                      ),
                    ),
                  ],
                ),
                5.horizontalSpacerPercent,
                Container(
                    width: 50,
                    child: Image.asset('assets/images/PNG Icons/Cam 1.png'))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildMcqImageQuestion(
      int i, McqImageQuestion mcqImageQuestion, dynamic markedAnswer) {
    String newVal = '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${i + 1}) ${mcqImageQuestion.question}'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (mcqImageQuestion.options.length / 2).ceil(),
          itemBuilder: (BuildContext context, int rowIndex) {
            int startIndex = rowIndex * 2;
            int endIndex = (rowIndex + 1) * 2;
            endIndex = endIndex > mcqImageQuestion.options.length
                ? mcqImageQuestion.options.length
                : endIndex;

            return Row(
              children: List.generate(endIndex - startIndex, (j) {
                int optionIndex = startIndex + j;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('${optionIndex + 1}.'),
                        Container(
                          padding: (markedAnswer as String?) ==
                                  mcqImageQuestion.options[optionIndex]
                              ? const EdgeInsets.all(5)
                              : null,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.amber),
                          child: CachedNetworkImage(
                            imageUrl: mcqImageQuestion.options[optionIndex],
                            width: 50, // Adjust the width as needed
                            height: 50, // Adjust the height as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ),
        TextFormField(
          initialValue: markedAnswer,
          onChanged: (value) {
            newVal = value;
          },
          onEditingComplete: () {
            print('compelte');
            context.read<WorksheetSolverCubit>().setAnswer(i, newVal);
          },
        ),
      ],
    );
  }

  Column _buildMcqTextQuestion(
      int i, McqTextQuestion mcqTextQuestion, dynamic markedAnswer) {
    String newval = '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        80.verticalSpacer,
        Text(
          mcqTextQuestion.question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF212121),
            fontSize: 32,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        80.verticalSpacer,
        // Text('${i + 1}) ${mcqTextQuestion.question}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
                mcqTextQuestion.options.length,
                (index) => Container(
                      width: 40.wp,
                      padding: EdgeInsets.symmetric(vertical: 2.wp),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF4F2FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Text(
                        mcqTextQuestion.options[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF4F3A9C),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ))
          ],
        ),
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: DeviceType().isMobile ? 56 : 80,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0XFF4F3A9C),
      leading: null,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
              height: 36.h,
              width: 36.h,
              child: Image.asset(
                'assets/images/reusable_icons/back_button_primary.png',
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Text(
            // 'Q1. Fill in the Blanks',
            'Q.${context.watch<WorksheetSolverCubit>().state.currentQuestion + 1} ${context.watch<WorksheetSolverCubit>().state.questions[context.watch<WorksheetSolverCubit>().state.currentQuestion].questionType}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 136.sp,
              fontFamily: 'Uniform Rounded',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          const Spacer(),
          Container(
            width: 70,
            height: 40,
            // padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 28),
            decoration: ShapeDecoration(
              color: const Color(0xFF45C375),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            child: const Center(
              child: Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          )
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         context.read<WorksheetSolverCubit>().answerSubmit();
          //       },
          //       child: Container(
          //         margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
          //         height: 36.h,
          //         width: 36.h,
          //         child: Icon(
          //           Icons.swap_vert_circle,
          //           size: 36,
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         List<StudentAnswer> finalAnsSheet = List.from(
          //             context.read<WorksheetSolverCubit>().state.answerSheet);
          //         //sort the finalAnsSheet

          //         finalAnsSheet
          //             .sort((a, b) => a.questionNo.compareTo(b.questionNo));
          //         print(jsonEncode(finalAnsSheet));
          //       },
          //       child: Container(
          //         margin: EdgeInsets.only(left: 2.wp, right: 3.wp),
          //         height: 36.h,
          //         width: 36.h,
          //         child: Icon(
          //           Icons.bookmark_outline_sharp,
          //           size: 36,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

var worksheet = [
  ['Living and non-living things', 'EVS', 'Overdue', 'Teacher\'s Name'],
  ['Vowels and Noun', 'English', '3rd January', 'D. C. Pandey'],
  ['Fraction and Division', 'Maths', '19th January', 'H. C. Verma'],
  ['Name of worksheet', 'EVS', '22nd January', 'H. K. Das'],
];

class Lesson extends StatelessWidget {
  final String title;
  final String greenTxt;
  final String redTxt;
  final String blueTxt;

  const Lesson({
    super.key,
    required this.title,
    required this.greenTxt,
    required this.redTxt,
    required this.blueTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      width: DeviceType().isMobile ? 45.wp : 35.wp,
      height: DeviceType().isMobile ? 2.wp : 10.wp,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (DeviceType().isMobile ? 20 : 35).verticalSpacer,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF4F3A9C),
                fontSize: DeviceType().isMobile ? 18 : 25,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          (DeviceType().isMobile ? 0 : 15).verticalSpacer,
          //!EVS
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 1.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFF9CDDB6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              greenTxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF074C2B),
                fontSize: DeviceType().isMobile ? 16 : 20,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          //!Overdue
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 2.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFFFFC1B8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              redTxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFA94234),
                fontSize: DeviceType().isMobile ? 16 : 20,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          //!Teachers name
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 1.2.wp, horizontal: 2.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFFB3EAFC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              blueTxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF003A54),
                fontSize: DeviceType().isMobile ? 16 : 20,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          10.verticalSpacer,
          //!Solve
          Container(
            width: double.maxFinite,
            // height: 70,
            margin: EdgeInsets.symmetric(vertical: 1.wp, horizontal: 3.wp),
            padding: EdgeInsets.symmetric(vertical: 3.wp, horizontal: 2.wp),
            decoration: ShapeDecoration(
              color: const Color(0xFF8C7DF0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            child: Text(
              'Solve',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: DeviceType().isMobile ? 18 : 24,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          // 15.verticalSpacer,
        ],
      ),
    );
  }
}

DateTime createDateTime(String dateStr, String timeStr) {
  List<int> dateParts =
      dateStr.split('-').map((part) => int.parse(part)).toList();

  List<String> timeParts = timeStr.split(' ');
  List<int> timeHourMinute =
      timeParts[0].split(':').map((part) => int.parse(part)).toList();

  int hour = timeHourMinute[0];
  int minute = timeHourMinute[1];

  if (timeParts[1] == 'pm' && hour != 12) {
    hour += 12;
  }

  return DateTime(dateParts[0], dateParts[1], dateParts[2], hour, minute);
}

DateTime convertToDate(String dateString) {
  List<int> dateParts =
      dateString.split('-').map((part) => int.parse(part)).toList();
  return DateTime(dateParts[0], dateParts[1], dateParts[2]);
}
