import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/util/device_type.dart';
import '../../bloc/worksheet_solver_cubit/worksheet_solver_cubit.dart';
import '../../models/questions.dart';
import '../question_text.dart';

class LongAnswerQuestion extends StatefulWidget {
  const LongAnswerQuestion({
    super.key,
    required this.questionIndex,
    required this.question,
    required this.markedAnswer,
    required this.screenSize,
  });
  final int questionIndex;
  final LongAnswerQuestionType question;
  final dynamic markedAnswer;
  final Size screenSize;

  @override
  State<LongAnswerQuestion> createState() => _LongAnswerQuestionState();
}

class _LongAnswerQuestionState extends State<LongAnswerQuestion> {
  late ImagePicker _picker;

  @override
  void initState() {
    if (widget.markedAnswer != null) {
      uploadedImgUrl = widget.markedAnswer;
    }
    super.initState();
    _picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  String uploadedImgUrl = '';
  bool _showPreview = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapped outside the TextField
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_showPreview) ...[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                Container(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0.h),
                      child: Image.network(uploadedImgUrl),
                    ),
                  ),
                  height: 300.h,
                  width: 300.h,
                )
              ],
              if (uploadedImgUrl != '')
                Transform.translate(
                  offset: Offset(300.h, 55.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onLongPressEnd: (details) => setState(() {
                        // _showPreview = true;
                      }),
                      child: Container(
                          height: 200.h,
                          width: 200.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(uploadedImgUrl)))),
                    ),
                  ),
                ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DeviceType().isMobile
                      ? 105.verticalSpacer
                      : (widget.screenSize.height * 0.3).verticalSpacer,
                  QuestionText(question: widget.question.question),
                  DeviceType().isMobile ? 55.verticalSpacer : 85.verticalSpacer,
                  GestureDetector(
                    onTap: () async {
                      try {
                        XFile? file =
                            await _picker.pickImage(source: ImageSource.camera);

                        // Send the image to the dummy API
                        if (file != null) {
                          String url = await sendImageToAPI(file.path);
                          uploadedImgUrl = url;
                          if (context.mounted) {
                            context
                                .read<WorksheetSolverCubit>()
                                .setAnswer(widget.questionIndex, url);
                          }
                          setState(() {});
                        }
                      } catch (e) {
                        debugPrint('Error taking picture: $e');
                      }
                    },
                    child: SizedBox(
                        height: 55,
                        child:
                            Image.asset('assets/images/PNG Icons/Cam 1.png')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> sendImageToAPI(String filePath) async {
    // Read the image file as bytes
    List<int> imageBytes = File(filePath).readAsBytesSync();

    // Encode the image bytes to Base64
    String base64Image = base64Encode(imageBytes);

    // Your API endpoint
    String apiUrl =
        'https://xc62c4nbgb.execute-api.ap-south-1.amazonaws.com/dev/uploadimage';

    // Extract the file name from the file path
    String fileName = filePath.split('/').last;

    // Create the request body
    Map<String, String> requestBody = {
      'body': base64Image,
      'file_path_name': 'studentfiles/0/0/$fileName', // Include the file name
    };

    // Convert the request body to JSON
    String jsonBody = jsonEncode(requestBody);

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody,
      );

      // Check the response
      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Extract the URL
        String imageUrl = responseBody['url'];

        debugPrint('Image uploaded successfully. URL: $imageUrl');

        // Return the URL
        return imageUrl;
      } else {
        // Handle HTTP errors
        debugPrint(
            'Failed to upload image. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network and other errors
      debugPrint('Error uploading image: $error');
      throw Exception('Error uploading image: $error');
    }
  }
}
