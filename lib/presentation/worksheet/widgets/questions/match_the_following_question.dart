import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/constants.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/styles.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';

class MatchFollowingQuestion extends StatefulWidget {
  const MatchFollowingQuestion(
      {Key? key,
      required this.question,
      this.markedAnswer,
      required this.screenSize})
      : super(key: key);
  final MatchTheFollowingQuestion question;
  final Size screenSize;

  final dynamic markedAnswer;
  @override
  State<MatchFollowingQuestion> createState() => MatchFollowingQuestionState();
}

class MatchFollowingQuestionState extends State<MatchFollowingQuestion> {
  List<Offset> boxPositions = [];

  late Size boxSizes;

  Map<String, Offset> currentLine = {};
  List<Map<String, Offset>> allLines = [];
  late List<String> questionsList;
  late List<String> answersList;
  bool isImageQuestion = true;
  @override
  void initState() {
    super.initState();
    debugPrint(
        'screenSize: ${widget.screenSize.width} || ${widget.screenSize.height}');
    // debugPrint('options mtd: ${widget.question.options}');
    // super.initState();
    questionsList = widget.question.options.keys.toList();
    double halfEmptyBox = (questionsList.length - 1 + 2) / 2;
    int fullQuesBox = questionsList.length;
    double singleBoxSize =
        widget.screenSize.width / (fullQuesBox + halfEmptyBox);
    debugPrint('singleBoxSize: $singleBoxSize');

    //check for question has images or text
    if (questionsList.first.contains('http')) {
      if (Platform.isAndroid) {
        singleBoxSize = 110.h;
      }
      //image question
      boxSizes = Size(singleBoxSize, singleBoxSize);
    } else {
      //text question
      isImageQuestion = false;
      boxSizes = Size(singleBoxSize, 75.h);
    }
    answersList = widget.question.options.values.toList()..shuffle();

    double availableVerticSpace = widget.screenSize.height -
        singleBoxSize -
        2 * Constants.appBarSizeWorksheet -
        singleBoxSize / 5; //app-btm bar,boxsize
    double availableVerticSpaceText = widget.screenSize.height -
        75.h -
        2 * Constants.appBarSizeWorksheet -
        singleBoxSize / 5; //app-btm bar,boxsize
    double availableWidth =
        widget.screenSize.width - questionsList.length * singleBoxSize;
    for (var i = 0; i < widget.question.options.length; i++) {
      boxPositions.add(Offset(
          availableWidth / (questionsList.length + 1) +
              ((singleBoxSize + (availableWidth / (questionsList.length + 1))) *
                  i),
          singleBoxSize / 5));
    }
    //?fill answer boxes
    for (var i = widget.question.options.length - 1; i >= 0; i--) {
      boxPositions.add(Offset(
          availableWidth / (questionsList.length + 1) +
              ((singleBoxSize + (availableWidth / (questionsList.length + 1))) *
                  i),
          isImageQuestion ? availableVerticSpace : availableVerticSpaceText));
    }

    drawSavedAnswer();
  }

  void drawSavedAnswer() {
    if (widget.markedAnswer != null &&
        (widget.markedAnswer as List).isNotEmpty) {
      for (int i = 0; i < widget.markedAnswer.length; i++) {
        int answerIndex = answersList.indexOf(widget.markedAnswer[i]);

        // debugPrint('answerIndex original:$i: ${originalAns[i]}');

        // debugPrint('answerIndex marked ${widget.markedAnswer[i]}');
        // debugPrint('answerlist index ${answersList[answerIndex]}');
        if (answerIndex != -1 && i < questionsList.length) {
          Offset from = Offset(
            boxPositions[i].dx + boxSizes.width / 2,
            boxPositions[i].dy + boxSizes.height / 2,
          );

          Offset to = Offset(
            boxPositions[(answersList.length - answerIndex - 1) +
                        answersList.length]
                    .dx +
                boxSizes.width / 2,
            boxPositions[(answersList.length - answerIndex - 1) +
                        answersList.length]
                    .dy +
                boxSizes.height / 2,
          );
          // answersList.reversed.toList()[toIndex % answersList.length]

          allLines.add({'from': from, 'to': to});
        }
      }
    }
  }

  var usedColors = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: LinePainter(allLines),
        ),
        // Transform.translate(
        //   offset: const Offset(0.0, 10.0),
        //   child: Align(
        //     alignment: Alignment.topCenter,
        //     child: Text(
        //       widget.matchTheFollowingQuestion.question,
        //       style: AppTextStyles.unitedRounded140w700,
        //     ),
        //   ),
        // ),
        for (int i = 0; i < boxPositions.length; i++)
          Positioned(
            left: boxPositions[i].dx,
            top: boxPositions[i].dy,
            child: Container(
                width: boxSizes.width,
                height: boxSizes.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: i < boxPositions.length / 2
                    ? questionsList[i].contains('http')
                        ? CachedNetworkImage(
                            imageUrl: questionsList[i],
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              width: boxSizes.width,
                              height: boxSizes.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive(
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Center(
                            child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.wp),
                            padding: EdgeInsets.symmetric(horizontal: 1.wp),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                questionsList[i],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.nunito120w700primary,
                              ),
                            ),
                          ))
                    : answersList[boxPositions.length - i - 1].contains('http')
                        ? CachedNetworkImage(
                            imageUrl: answersList[boxPositions.length - i - 1],
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              width: boxSizes.width,
                              height: boxSizes.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                              child: Center(
                                child: CircularProgressIndicator.adaptive(
                                    strokeCap: StrokeCap.round),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.wp),
                              padding: EdgeInsets.symmetric(horizontal: 1.wp),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  answersList[boxPositions.length - i - 1],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF4F3A9C),
                                    fontSize: 120.sp,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          )),
          ),

        GestureDetector(
          onPanStart: (details) {
            setState(() {
              Offset touchPoint = details.localPosition;

              int touchedBoxIndex = _getTouchedBox(touchPoint);
              // touch should lie inside boxes and box should be of question
              if (touchedBoxIndex != -1 &&
                  touchedBoxIndex < boxPositions.length / 2) {
                debugPrint('start line');
                // get mid point of touchehd box
                Offset middleOfBox = Offset(
                  boxPositions[touchedBoxIndex].dx + boxSizes.width / 2,
                  boxPositions[touchedBoxIndex].dy + boxSizes.height / 2,
                );
                // If new line strting from a box who is alrady attach with some ans then remove that pre connected line
                allLines.removeWhere((line) => (line['from'] == middleOfBox));
                currentLine['from'] = middleOfBox;
              }
            });
          },
          onPanUpdate: (details) {
            setState(() {
              Offset touchPoint = details.localPosition;
              currentLine['to'] = touchPoint;
              allLines.removeWhere((line) => line['to'] == currentLine['to']);
              allLines.add(currentLine);

              // if (allLines.last['from'] == null ||
              //     allLines.last['to'] == null ||
              //     _getTouchedBox(allLines.last['to']!) == -1) {
              //   allLines.removeLast();
              // }
            });
            // debugPrint('-------------');
            // for (var element in allLines) {
            //   debugPrint(
            //       'from: ${_getTouchedBox(element['from']!)} -> to: ${_getTouchedBox(element['to']!)}');
            // }
            // debugPrint('-------------');
          },
          onPanEnd: (details) {
            //remove unattached lines (null safe code dont remove)
            allLines.removeWhere(
                (line) => line['from'] == null || line['to'] == null);
            // remove unattached lines
            allLines.removeWhere((line) =>
                _getTouchedBox(line['from']!) == -1 ||
                _getTouchedBox(line['to']!) == -1 ||
                _getTouchedBox(line['to']!) < boxPositions.length / 2);
            allLines.removeWhere(
                (line) => line['from'] == null || line['to'] == null);
            // debugPrint('total lines: ${allLines.length}');
            // debugPrint('-------------');
            // for (var element in allLines) {
            //   debugPrint(
            //       'from: ${_getTouchedBox(element['from']!)} -> to: ${_getTouchedBox(element['to']!)}');
            // }
            // debugPrint('-------------');
            // last line attach to center of box
            if (allLines.isNotEmpty) {
              var lastLine = allLines.last;

              int touchBoxIndex = _getTouchedBox(lastLine['to']!);
              allLines.last['to'] = Offset(
                boxPositions[touchBoxIndex].dx + boxSizes.width / 2,
                boxPositions[touchBoxIndex].dy + boxSizes.height / 2,
              );

              //If ans has 2 lines then remove previous line
              for (int i = 0; i < allLines.length - 1; i++) {
                if (allLines[i]['to'] == allLines.last['to']) {
                  allLines.removeAt(i);
                  break;
                }
              }
            }

            Set<Map<String, Offset>> uniqueLines = Set.from(allLines);
            allLines = List.from(uniqueLines);
            setState(() {
              currentLine = {};
            });
            if (allLines.length == questionsList.length) {
              debugPrint('all lines are connected');
              Map<String, Map<int, String>> v = extractConnectedBoxes(allLines);
              debugPrint('mtf ans: $v');
              var ans = v['answer']!.values.toList();

              var state = context.read<WorksheetSolverCubit>().state;
              context
                  .read<WorksheetSolverCubit>()
                  .setAnswer(state.currentQuestion, ans);
              // [{"1":{"fillblank":{"answer":"test1"}}}]
            }
          },
          child: Container(
            margin: const EdgeInsets.all(1.0),
            alignment: Alignment.topLeft,
            color: Colors.transparent,
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }

  Map<String, Map<int, String>> extractConnectedBoxes(
      List<Map<String, Offset>> lines) {
    Map<String, Map<int, String>> result = {
      "answer": {},
    };

    for (var line in lines) {
      if (line['from'] != null) {
        int fromIndex = _getTouchedBox(line['from']!);
        int toIndex = _getTouchedBox(line['to']!);
        // result["answer"]![fromIndex] = answersList[toIndex % answersList.length];
        result["answer"]![fromIndex] =
            answersList.reversed.toList()[toIndex % answersList.length];
      }
    }
    result["answer"] = Map.fromEntries(result["answer"]!.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key)));
    return result;
  }

  bool _isInsideBox(Offset touchPoint, Offset boxPosition, Size boxSize) {
    return touchPoint.dx >= boxPosition.dx &&
        touchPoint.dx <= boxPosition.dx + boxSize.width &&
        touchPoint.dy >= boxPosition.dy &&
        touchPoint.dy <= boxPosition.dy + boxSize.height;
  }

  int _getTouchedBox(Offset touchPoint) {
    for (int i = 0; i < boxPositions.length; i++) {
      Offset boxPosition = boxPositions[i];
      Size boxSize = boxSizes;

      if (_isInsideBox(touchPoint, boxPosition, boxSize)) {
        return i;
      }
    }
    return -1;
  }
}

class LinePainter extends CustomPainter {
  final List<Map<String, Offset>> lines;
  LinePainter(this.lines);
  final availableColors = []; //RBYG
  int colorIndex = 0; // Initialize color index to 0

  @override
  void paint(Canvas canvas, Size size) {
    var choosecol = ['FF644E', '0092D2', 'FFC605', '0D9855'];
    for (int i = 0; i < lines.length; i++) {
      availableColors.add(choosecol[i % choosecol.length]);
    }
    for (int i = 0; i < lines.length; i++) {
      Paint paint = Paint()
        ..color = Color(int.parse('0xFF${availableColors[colorIndex]}'))
        ..strokeWidth = 5;

      if (lines[i]['from'] != null && lines[i]['to'] != null) {
        canvas.drawLine(lines[i]['from']!, lines[i]['to']!, paint);
      }

      // Increment the color index and cycle through available colors
      colorIndex = (colorIndex + 1) % availableColors.length;
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}
