import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/worksheet/widgets/question_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../../models/recognition_response.dart';
import '../../recognizer/interface/text_recognizer.dart';
import '../../recognizer/mlkit_text_recognizer.dart';

class LongAnswerQuestion extends StatefulWidget {
  const LongAnswerQuestion({
    super.key,
    required this.questionIndex,
    required this.question,
    required this.markedAnswer,
  });
  final int questionIndex;
  final LongAnswerQuestionType question;
  final dynamic markedAnswer;

  @override
  State<LongAnswerQuestion> createState() => _LongAnswerQuestionState();
}

class _LongAnswerQuestionState extends State<LongAnswerQuestion> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;

  RecognitionResponse? _response;

  int noOfTextFileds = 1;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();

    /// Can be [MLKitTextRecognizer] or [TesseractTextRecognizer]
    _recognizer = MLKitTextRecognizer();
    // _recognizer = TesseractTextRecognizer();
    // Initialize controllers based on the number of text fields

    textController.text = widget.markedAnswer ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
    // Dispose the text controllers
    textController.dispose();
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
      textController.text = multiLineText;
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
            DeviceType().isMobile ? 105.verticalSpacer : 160.verticalSpacer,
            QuestionText(question: widget.question.question),
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
                              controller: textController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              // initialValue: markedAnswers.length > j
                              //     ? markedAnswers[j]
                              //     : '',
                              onChanged: (value) {
                                context
                                    .read<WorksheetSolverCubit>()
                                    .setAnswer(widget.questionIndex, value);
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
          ],
        ),
      ),
    );
  }
}
