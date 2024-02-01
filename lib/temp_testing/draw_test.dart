// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:size_config/size_config.dart';

// import '../core/util/styles.dart';
// import '../presentation/worksheet/bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
// import '../presentation/worksheet/models/questions.dart';

// class MatchTheFollowingTest extends StatefulWidget {
//   const MatchTheFollowingTest(
//       {Key? key,
//       required this.matchTheFollowingQuestion,
//       required this.shuffledOptions,
//       this.markedAnswer})
//       : super(key: key);
//   final MatchTheFollowingQuestion matchTheFollowingQuestion;
//   final List<MapEntry<String, String>> shuffledOptions;
//   final dynamic markedAnswer;
//   @override
//   State<MatchTheFollowingTest> createState() => MatchTheFollowingTestState();
// }

// class MatchTheFollowingTestState extends State<MatchTheFollowingTest> {
//   List<Offset> boxPositions = [];

//   Size boxSizes = const Size(85, 85);

//   Map<String, Offset> currentLine = {};
//   List<Map<String, Offset>> allLines = [];
//   late List<String> questionsList;
//   late List<String> answersList;

//   @override
//   void initState() {
//     super.initState();
//     questionsList = widget.matchTheFollowingQuestion.options.keys.toList();
//     answersList = widget.matchTheFollowingQuestion.options.values.toList()
//       ..shuffle();
//     //?fill question boxes
//     for (var i = 0; i < widget.matchTheFollowingQuestion.options.length; i++) {
//       boxPositions.add(Offset(20.0.wp + (50.wp * i), 40.0.h));
//     }
//     //?fill answer boxes
//     for (var i = widget.matchTheFollowingQuestion.options.length - 1;
//         i >= 0;
//         i--) {
//       boxPositions.add(Offset(20.0.wp + (50.wp * i), 260.0.h));
//     }
//     drawSavedAnswer();
//   }

//   void drawSavedAnswer() {
//     if (widget.markedAnswer != null &&
//         (widget.markedAnswer as List).isNotEmpty) {
//       for (int i = 0; i < widget.markedAnswer.length; i++) {
//         int answerIndex = answersList.indexOf(widget.markedAnswer[i]);
//         if (answerIndex != -1 && i < questionsList.length) {
//           Offset from = Offset(
//             boxPositions[i].dx + boxSizes.width / 2,
//             boxPositions[i].dy + boxSizes.height / 2,
//           );

//           Offset to = Offset(
//             boxPositions[answerIndex + answersList.length].dx +
//                 boxSizes.width / 2,
//             boxPositions[answerIndex + answersList.length].dy +
//                 boxSizes.height / 2,
//           );
//           // answersList.reversed.toList()[toIndex % answersList.length]
//           print('answerIndex ${(answerIndex % answersList.length)}');
//           allLines.add({'from': from, 'to': to});
//         }
//       }
//     }
//   }

//   var usedColors = [];
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CustomPaint(
//           painter: LinePainter(allLines),
//         ),
//         // Transform.translate(
//         //   offset: const Offset(0.0, 10.0),
//         //   child: Align(
//         //     alignment: Alignment.topCenter,
//         //     child: Text(
//         //       widget.matchTheFollowingQuestion.question,
//         //       style: AppTextStyles.unitedRounded140w700,
//         //     ),
//         //   ),
//         // ),
//         for (int i = 0; i < boxPositions.length; i++)
//           Positioned(
//             left: boxPositions[i].dx,
//             top: boxPositions[i].dy,
//             child: Container(
//               width: boxSizes.width,
//               height: boxSizes.height,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(14)),
//               child: i < boxPositions.length / 2
//                   ? questionsList[i].contains('http')
//                       ? CachedNetworkImage(
//                           imageUrl: questionsList[i],
//                           fit: BoxFit.cover,
//                           imageBuilder: (context, imageProvider) => Container(
//                             width: boxSizes.width,
//                             height: boxSizes.height,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               image: DecorationImage(
//                                 image: imageProvider,
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           placeholder: (context, url) => const Placeholder(),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         )
//                       : Text(questionsList[i])
//                   : answersList[boxPositions.length - i - 1].contains('http')
//                       ? CachedNetworkImage(
//                           imageUrl: answersList[boxPositions.length - i - 1],
//                           fit: BoxFit.cover,
//                           imageBuilder: (context, imageProvider) => Container(
//                             width: boxSizes.width,
//                             height: boxSizes.height,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               image: DecorationImage(
//                                 image: imageProvider,
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                           placeholder: (context, url) => const Center(
//                             child: CircularProgressIndicator.adaptive(
//                                 strokeCap: StrokeCap.round),
//                           ),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         )
//                       : Text(answersList[boxPositions.length - i - 1]),
//             ),
//           ),
//         GestureDetector(
//           onPanUpdate: (details) {
//             setState(() {
//               Offset touchPoint = details.localPosition;
//               currentLine['to'] = touchPoint;

//               for (int i = 0; i < boxPositions.length; i++) {
//                 if (_isInsideBox(
//                     currentLine['to']!, boxPositions[i], boxSizes)) {
//                   currentLine['to'] = Offset(
//                     boxPositions[i].dx + boxSizes.width / 2,
//                     boxPositions[i].dy + boxSizes.height / 2,
//                   );

//                   Offset endPoint = currentLine['to']!;
//                   if (allLines.any((line) => line['to'] == endPoint)) {
//                     allLines.removeWhere((line) => line['to'] == endPoint);
//                   }
//                   setState(() {
//                     allLines.add(currentLine);
//                   });
//                   return;
//                 }
//               }
//             });
//           },
//           onPanEnd: (details) {
//             // Remove lines connecting question to question or answer to answer container
//             allLines.removeWhere((line) {
//               int fromIndex = _getTouchedBox(line['from']!);
//               int toIndex = _getTouchedBox(line['to']!);

//               int fromSection =
//                   fromIndex ~/ widget.matchTheFollowingQuestion.options.length;
//               int toSection =
//                   toIndex ~/ widget.matchTheFollowingQuestion.options.length;

//               return fromSection == toSection;
//             });
//             Set<Map<String, Offset>> uniqueLines = Set.from(allLines);
//             allLines = List.from(uniqueLines);
//             setState(() {
//               currentLine = {};
//             });
//             if (allLines.length == questionsList.length) {
//               print('all lines are connected');
//               Map<String, Map<int, String>> v = extractConnectedBoxes(allLines);
//               print('mtf ans: $v');
//               var ans = v['answer']!.values.toList();

//               // List<String> listString = [];

//               // v.forEach((outerKey, innerMap) {
//               //   innerMap.forEach((innerKey, innerValue) {
//               //     listString.add(innerValue);
//               //   });
//               // });

//               // print(listString);
//               var state = context.read<WorksheetSolverCubit>().state;
//               context
//                   .read<WorksheetSolverCubit>()
//                   .setAnswer(state.currentQuestion, ans);
//               // [{"1":{"fillblank":{"answer":"test1"}}}]
//             }
//           },
//           onPanStart: (details) {
//             setState(() {
//               Offset touchPoint = details.localPosition;
//               print(touchPoint);
//               int touchedBoxIndex = _getTouchedBox(touchPoint);
//               if (touchedBoxIndex != -1) {
//                 Offset middleOfBox = Offset(
//                   boxPositions[touchedBoxIndex].dx + boxSizes.width / 2,
//                   boxPositions[touchedBoxIndex].dy + boxSizes.height / 2,
//                 );
//                 // If new line strting from a box who is alrady attach with some ans then remove that pre connected line
//                 allLines.removeWhere((line) {
//                   return (line['from'] == middleOfBox);
//                 });
//                 currentLine['from'] = middleOfBox;
//               }
//             });
//           },
//           child: Container(
//             margin: const EdgeInsets.all(1.0),
//             alignment: Alignment.topLeft,
//             color: Colors.transparent,
//             child: const SizedBox.expand(),
//           ),
//         ),
//       ],
//     );
//   }

//   Map<String, Map<int, String>> extractConnectedBoxes(
//       List<Map<String, Offset>> lines) {
//     Map<String, Map<int, String>> result = {
//       "answer": {},
//     };

//     for (var line in lines) {
//       int fromIndex = _getTouchedBox(line['from']!);
//       int toIndex = _getTouchedBox(line['to']!);
//       // result["answer"]![fromIndex] = answersList[toIndex % answersList.length];
//       result["answer"]![fromIndex] =
//           answersList.reversed.toList()[toIndex % answersList.length];
//     }
//     result["answer"] = Map.fromEntries(result["answer"]!.entries.toList()
//       ..sort((a, b) => a.key.compareTo(b.key)));
//     return result;
//   }

//   bool _isInsideBox(Offset touchPoint, Offset boxPosition, Size boxSize) {
//     return touchPoint.dx >= boxPosition.dx &&
//         touchPoint.dx <= boxPosition.dx + boxSize.width &&
//         touchPoint.dy >= boxPosition.dy &&
//         touchPoint.dy <= boxPosition.dy + boxSize.height;
//   }

//   int _getTouchedBox(Offset touchPoint) {
//     for (int i = 0; i < boxPositions.length; i++) {
//       Offset boxPosition = boxPositions[i];
//       Size boxSize = boxSizes;

//       if (_isInsideBox(touchPoint, boxPosition, boxSize)) {
//         return i;
//       }
//     }
//     return -1;
//   }
// }

// class LinePainter extends CustomPainter {
//   final List<Map<String, Offset>> lines;
//   LinePainter(this.lines);
//   final availableColors = ['FF644E', '0092D2', 'FFC605', '0D9855']; //RBYG
//   int colorIndex = 0; // Initialize color index to 0

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (int i = 0; i < lines.length; i++) {
//       Paint paint = Paint()
//         ..color = Color(int.parse('0xFF${availableColors[colorIndex]}'))
//         ..strokeWidth = 5;

//       if (lines[i]['from'] != null && lines[i]['to'] != null) {
//         canvas.drawLine(lines[i]['from']!, lines[i]['to']!, paint);
//       }

//       // Increment the color index and cycle through available colors
//       colorIndex = (colorIndex + 1) % availableColors.length;
//     }
//   }

//   @override
//   bool shouldRepaint(LinePainter oldDelegate) => true;
// }
