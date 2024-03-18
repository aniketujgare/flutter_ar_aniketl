import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../../models/recognition_response.dart';
import '../../recognizer/interface/text_recognizer.dart';
import '../../recognizer/mlkit_text_recognizer.dart';

class OneWordQuestion extends StatefulWidget {
  const OneWordQuestion({
    super.key,
    required this.context,
    required this.oneWordQuestion,
    required this.markedAnswer,
    required this.questionIndex,
    required this.screenSize,
  });
  final int questionIndex;
  final BuildContext context;
  final OneWordQuestionType oneWordQuestion;
  final dynamic markedAnswer;
  final Size screenSize;

  @override
  State<OneWordQuestion> createState() => _OneWordQuestionState();
}

class _OneWordQuestionState extends State<OneWordQuestion> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;
  RecognitionResponse? _response;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.markedAnswer != null) {
      textEditingController.text = widget.markedAnswer;
    }
    _picker = ImagePicker();

    /// Can be [MLKitTextRecognizer] or [TesseractTextRecognizer]
    _recognizer = MLKitTextRecognizer();
  }

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
    // Dispose the text controllers
    textEditingController.dispose();
  }

  void processImage(String imgPath) async {
    final recognizedText = await _recognizer.processImage(imgPath);
    debugPrint('recognized Text $recognizedText');
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

      debugPrint('multiline text: ' + multiLineText);
      textEditingController.text = multiLineText;
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
        // debugPrint('tapped outside textfield');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DeviceType().isMobile
                ? 120.verticalSpacer
                : (widget.screenSize.height * 0.27).verticalSpacer,
            Text(
              widget.oneWordQuestion.question,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
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
                        offset: Offset(0, 5.h),
                        child: Container(
                          width: 70.wp,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: const InputDecoration(
                              // labelText: 'Type your answer',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              context
                                  .read<WorksheetSolverCubit>()
                                  .setAnswer(widget.questionIndex, value);
                            },
                            onEditingComplete: () {
                              debugPrint('complete');
                              FocusScope.of(context).requestFocus(FocusNode());
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
                      processImage(imgPath);
                    },
                    child: SizedBox(
                        height: 55,
                        child:
                            Image.asset('assets/images/PNG Icons/Cam 1.png')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
