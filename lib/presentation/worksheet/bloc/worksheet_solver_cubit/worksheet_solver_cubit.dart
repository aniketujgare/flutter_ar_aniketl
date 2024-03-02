import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../data/models/student_profile_model.dart';
import '../../models/questions.dart';
import '../../models/worksheet_ans_of_student.dart';

part 'worksheet_solver_cubit.freezed.dart';
part 'worksheet_solver_state.dart';

class WorksheetSolverCubit extends Cubit<WorksheetSolverState> {
  int _workSheetId = 0;
  int _studentId = 0;
  WorksheetSolverCubit() : super(const WorksheetSolverState.initial());
  void init(int workSheetId) async {
    _workSheetId = workSheetId;
    StudentProfileModel? studentProfile =
        await AuthenticationRepository().getStudentProfile();
    _studentId = studentProfile?.studentId ?? 0;
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    //Load questions list
    List<Question> questionsList = await getQuestionsList(workSheetId);
    //Load student answer list
    List<StudentAnswer> studentAnswerList =
        await getStudentAnswerList(workSheetId, _studentId);
    debugPrint('final ans sheet1: ${jsonEncode(studentAnswerList)}');
    //Generate final state answerlist
    List<StudentAnswer> answerSheet = [];
    log(jsonEncode(studentAnswerList));
    // map final answer sheet with studentsAnsweList
    if (studentAnswerList.isNotEmpty) {
      answerSheet.addAll(studentAnswerList);
    }
    debugPrint('final ans sheet: ${jsonEncode(answerSheet)}');
    /*
        1) Question
        2) Answer
    */

    emit(state.copyWith(
        status: WorkSheetSolverStatus.loaded,
        questions: questionsList,
        answerSheet: answerSheet));
  }

  void setAnswer(int questionIdx, dynamic newAnswer) {
    debugPrint('setAnswer $newAnswer');
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    // Make a copy of the current state
    List<StudentAnswer> updatedAnswerSheet = List.from(state.answerSheet);
    StudentAnswer? answer = updatedAnswerSheet
        .firstWhereOrNull((element) => element.questionNo == questionIdx);
    if (answer != null) {
      answer.question.answer.answer = '';
      answer.question.answer.answer = newAnswer;
      updatedAnswerSheet
          .removeWhere((element) => element.questionNo == answer.questionNo);
      StudentAnswer newAns = StudentAnswer(
          questionNo: questionIdx,
          question: AnswerQuestion(
              questionType: state.questions[questionIdx].questionType,
              answer: Answer(answer: newAnswer)));
      updatedAnswerSheet.add(newAns);

      debugPrint('dfgv:  ' + '${newAnswer.toString()}');
    } else {
      StudentAnswer newAns = StudentAnswer(
          questionNo: questionIdx,
          question: AnswerQuestion(
              questionType: state.questions[questionIdx].questionType,
              answer: Answer(answer: newAnswer)));
      updatedAnswerSheet.add(newAns);
    }
    debugPrint(jsonEncode(updatedAnswerSheet));

    if (state.currentQuestion == state.questions.length - 1) {
      answerSubmit(true);
    } else {
      answerSubmit(false);
    }
    emit(state.copyWith(
      status: WorkSheetSolverStatus.loaded,
      answerSheet: updatedAnswerSheet,
    ));
  }

  void answerSubmit(bool lastQuestion) async {
    // emit(state.copyWith(status: WorkSheetSolverStatus.loading));

    // Assuming state.answerSheet contains your data
    List<StudentAnswer> answerSheet = List.from(state.answerSheet);
    debugPrint(jsonEncode(answerSheet));
    //sort the finalAnsSheet
    answerSheet.sort((a, b) => a.questionNo.compareTo(b.questionNo));
    Map<String, dynamic> formattedAnswers = {
      "worksheet_id": _workSheetId,
      "student_id": _studentId,
      "data": [],
    };
    for (var studentAnswer in answerSheet) {
      formattedAnswers['data'].add(studentAnswer.question.toJson());
    }
    var dataString = jsonEncode(formattedAnswers["data"]);

    var finalString = {
      "worksheet_id": _workSheetId,
      "student_id": _studentId,
      "data": dataString,
    };
    debugPrint(finalString.toString());
    var headers = {'Content-Type': 'application/json'};
    var uri = Uri.parse(
        'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/addworksheetsolveddatav2');

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(finalString),
      );
      // {"worksheet_id":8085,"student_id":95,"data":"[{\"mcqtext\":{\"answer\":\"45\"}},{\"fillblank\":{\"answer\":\"67\"}}]"}
      debugPrint(response.body);
      debugPrint(response.contentLength.toString());
      debugPrint(response.headers.toString());
      if (response.statusCode == 200) {
        emit(state.copyWith(status: WorkSheetSolverStatus.loaded));
        // log(jsonString);
        debugPrint('Response status code: ${response.statusCode}');
        debugPrint(json.encode(finalString));
        if (lastQuestion) {
          await setStudentWorksheetStatus();
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to Save worksheet');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      emit(state.copyWith(status: WorkSheetSolverStatus.error));
      throw Exception('Failed to save worksheet');
    }
  }

  Future<void> setStudentWorksheetStatus() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      // Get current date in the format 'yyyy-MM-dd'
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/setstudentworksheetstatus'));
      request.body = json.encode({
        "worksheet_id": _workSheetId,
        "student_id": _studentId,
        "status": "submitted",
        "submitdate": currentDate
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        debugPrint(await response.stream.bytesToString());
      } else {
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      // Handle exceptions here
      debugPrint('Error: $e');
    }
  }

  Future<List<Question>> getQuestionsList(int worksheetId) async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getworksheetdatav2'));
    request.body = json.encode({"worksheet_id": worksheetId});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        debugPrint(responseString);
        if (responseString == 'null') {
          return [];
        }
        List<Question> allQuestion = allWorsheetQuestins(responseString);
        return allQuestion;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load worksheet questions');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to loadworksheet questions');
    }
  }

  void getStudentWorksheetData() async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getstudentworksheetdatav2'));
    request.body =
        json.encode({"worksheet_id": _workSheetId, "student_id": _studentId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      Map<String, dynamic> jsonMap = jsonDecode(responseString);

      List<StudentAnswer> studentAnswersList = jsonMap.entries
          .map(
            (entry) => StudentAnswer.fromJson(entry.key, entry.value),
          )
          .toList();
      // Sorting the list based on questionNo
      studentAnswersList.sort((a, b) => a.questionNo.compareTo(b.questionNo));
      emit(state.copyWith(
          status: WorkSheetSolverStatus.loaded,
          answerSheet: studentAnswersList));
      // debugPrint('WorksheetStudentAns ${json.encode(responseString)}');
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  Future<List<StudentAnswer>> getStudentAnswerList(
      int worksheetId, int studentId) async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getstudentworksheetdatav2'),
    );
    request.body =
        json.encode({"worksheet_id": worksheetId, "student_id": studentId});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();

        if (responseString != '0') {
          List<Map<String, dynamic>> jsonList =
              List<Map<String, dynamic>>.from(jsonDecode(responseString));

          List<StudentAnswer> studentAnswersList =
              jsonList.asMap().entries.map((entry) {
            log('entry: ${entry.value}');

            return StudentAnswer.fromJson(entry.key.toString(), entry.value);
          }).toList();
          debugPrint('studentAnsSheet: ${jsonEncode(studentAnswersList)}');

          // Sorting the list based on questionNo
          studentAnswersList
              .sort((a, b) => a.questionNo.compareTo(b.questionNo));
          return studentAnswersList;
        } else {
          return [];
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load student answers');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to student answers');
    }
  }

  Future<void> loadNextQuestion() async {
    if (state.currentQuestion + 1 < state.questions.length) {
      emit(state.copyWith(status: WorkSheetSolverStatus.loading));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(
          status: WorkSheetSolverStatus.loaded,
          currentQuestion: state.currentQuestion + 1));
    }
  }

  Future<void> loadPreviousQuestion() async {
    if (state.currentQuestion - 1 >= 0) {
      emit(state.copyWith(status: WorkSheetSolverStatus.loading));
      await Future.delayed(const Duration(milliseconds: 100));

      emit(state.copyWith(
          status: WorkSheetSolverStatus.loaded,
          currentQuestion: state.currentQuestion - 1));
    }
  }

  void setCurrentQuestionZero() {
    emit(state.copyWith(currentQuestion: 0));
  }
}
