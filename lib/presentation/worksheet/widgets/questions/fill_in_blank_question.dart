import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../../models/recognition_response.dart';
import '../../recognizer/interface/text_recognizer.dart';
import '../../recognizer/mlkit_text_recognizer.dart';
import '../../recognizer/tesseract_text_recognizer.dart';

class FillInTheBlankQuestion extends StatefulWidget {
  const FillInTheBlankQuestion({
    super.key,
    required this.questionIndex,
    required this.fillBlankQuestion,
    required this.markedAnswer,
  });
  final int questionIndex;
  final FillBlankQuestion fillBlankQuestion;
  final dynamic markedAnswer;

  @override
  State<FillInTheBlankQuestion> createState() => _FillInTheBlankQuestionState();
}

class _FillInTheBlankQuestionState extends State<FillInTheBlankQuestion> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;

  RecognitionResponse? _response;

  List<String> markedAnswers = [];
  int noOfTextFileds = 1;
  List<TextEditingController> textControllers = [];

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();

    /// Can be [MLKitTextRecognizer] or [TesseractTextRecognizer]
    _recognizer = MLKitTextRecognizer();
    // _recognizer = TesseractTextRecognizer();
    // Initialize controllers based on the number of text fields
    if (widget.markedAnswer is List<dynamic>) {
      markedAnswers.addAll(
        (widget.markedAnswer is List<dynamic>)
            ? widget.markedAnswer
                .map((element) => element.toString())
                .cast<String>()
            : [widget.markedAnswer.toString()],
      );
    } else if (widget.markedAnswer is String) {
      markedAnswers.add(widget.markedAnswer);
    }

    if (widget.fillBlankQuestion.answer is List<dynamic>) {
      noOfTextFileds =
          (widget.fillBlankQuestion.answer as List<dynamic>).length;
    }
    textControllers =
        List.generate(noOfTextFileds, (index) => TextEditingController());
    for (int i = 0; i < textControllers.length; i++) {
      textControllers[i].text =
          markedAnswers.length > i ? markedAnswers[i] : '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
    // Dispose the text controllers
    for (var controller in textControllers) {
      controller.dispose();
    }
  }

  void processImage(String imgPath, int textFiledIndex) async {
    final recognizedText = await _recognizer.processImage(imgPath);
    print('recognized Text $recognizedText');
    setState(() {
      _response = RecognitionResponse(
        imgPath: imgPath,
        recognizedText: recognizedText,
      );
    });
    if (_response != null) {
      String multiLineText =
          json.encode(_response!.recognizedText.replaceAll('\n', ' '));
      // multiLineText = multiLineText.substring(1, multiLineText.length - 1);
      multiLineText = multiLineText.substring(1, multiLineText.length - 1);

      print('multiline text: ' + multiLineText);
      textControllers[textFiledIndex].text = multiLineText;
      context
          .read<WorksheetSolverCubit>()
          .setAnswer(widget.questionIndex, multiLineText);
    }
  }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapped outside the TextField
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            noOfTextFileds == 1
                ? (DeviceType().isMobile
                    ? 120.verticalSpacer
                    : 160.verticalSpacer)
                : (DeviceType().isMobile
                    ? 80.verticalSpacer
                    : 160.verticalSpacer),
            Text(
              widget.fillBlankQuestion.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF212121),
                fontSize: 160.sp,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
            ...List.generate(
              noOfTextFileds,
              (j) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (noOfTextFileds != 1)
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
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70.wp,
                          height: 60,
                          child: Image.asset(
                            'assets/images/PNG Icons/Vector.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -3.h),
                          child: Container(
                            width: 70.wp,
                            padding: EdgeInsets.symmetric(horizontal: 75.sp),
                            child: TextFormField(
                              // maxLines: null,
                              controller: textControllers[j],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              // initialValue: markedAnswers.length > j
                              //     ? markedAnswers[j]
                              //     : '',
                              onChanged: (value) {
                                if (markedAnswers.length > j) {
                                  markedAnswers[j] = value;
                                  context
                                      .read<WorksheetSolverCubit>()
                                      .setAnswer(
                                          widget.questionIndex, markedAnswers);
                                } else {
                                  markedAnswers.add(value);
                                  context
                                      .read<WorksheetSolverCubit>()
                                      .setAnswer(
                                          widget.questionIndex, markedAnswers);
                                }
                              },
                              onEditingComplete: () {
                                print('complete');
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    5.horizontalSpacerPercent,
                    GestureDetector(
                      onTap: () async {
                        final imgPath = await obtainImage(ImageSource.camera);
                        if (imgPath == null) return;
                        processImage(imgPath, j);
                      },
                      child: SizedBox(
                          height: 55,
                          child:
                              Image.asset('assets/images/PNG Icons/Cam 1.png')),
                    )
                  ],
                ),
              ),
            ),
            // _response == null
            //     ? const Center(
            //         child: Text('Pick image to continue'),
            //       )
            //     : Container(
            //         height: 100,
            //         child: ListView(
            //           children: [
            //             // SizedBox(
            //             //   height: MediaQuery.of(context).size.width,
            //             //   width: MediaQuery.of(context).size.width,
            //             //   child: Image.file(File(_response!.imgPath)),
            //             // ),
            //             Padding(
            //                 padding: const EdgeInsets.all(16),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         Expanded(
            //                           child: Text(
            //                             "Recognized Text",
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .titleLarge,
            //                           ),
            //                         ),
            //                         IconButton(
            //                           onPressed: () {
            //                             Clipboard.setData(
            //                               ClipboardData(
            //                                   text: _response!.recognizedText),
            //                             );
            //                             ScaffoldMessenger.of(context)
            //                                 .showSnackBar(
            //                               const SnackBar(
            //                                 content:
            //                                     Text('Copied to Clipboard'),
            //                               ),
            //                             );
            //                           },
            //                           icon: const Icon(Icons.copy),
            //                         ),
            //                       ],
            //                     ),
            //                     const SizedBox(height: 10),
            //                     Text(_response!.recognizedText),
            //                   ],
            //                 )),
            //           ],
            //         ),
            //       )
          ],
        ),
      ),
    );
  }
}
