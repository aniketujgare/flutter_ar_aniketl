// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../models/questions.dart';
import '../../models/worksheet_ans_of_student.dart';

part 'worksheet_solver_cubit.freezed.dart';
part 'worksheet_solver_state.dart';

class WorksheetSolverCubit extends Cubit<WorksheetSolverState> {
  WorksheetSolverCubit() : super(const WorksheetSolverState.initial());
  void init() async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    //Load questions list
    List<Question> questionsList = await getQuestionsList();
    //Load student answer list
    List<StudentAnswer> studentAnswerList = await getStudentAnswerList();
    //Generate final state answerlist
    List<StudentAnswer> answerSheet = [];
    // map final answer sheet with studentsAnsweList
    if (studentAnswerList.isNotEmpty) {
      answerSheet.addAll(studentAnswerList);
    }
    print('final ans sheet: ${jsonEncode(answerSheet)}');
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
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    // Make a copy of the current state
    List<StudentAnswer> updatedAnswerSheet = state.answerSheet;
    StudentAnswer? answer = updatedAnswerSheet
        .firstWhereOrNull((element) => element.questionNo == questionIdx);
    if (answer != null) {
      answer.question.answer.answer = newAnswer;
    } else {
      StudentAnswer newAns = StudentAnswer(
          questionNo: questionIdx,
          question: AnswerQuestion(
              questionType: state.questions[questionIdx].questionType,
              answer: Answer(answer: newAnswer)));
      updatedAnswerSheet.add(newAns);
    }
    debugPrint(jsonEncode(updatedAnswerSheet));
    emit(state.copyWith(
      status: WorkSheetSolverStatus.loaded,
      answerSheet: updatedAnswerSheet,
    ));
  }

  void answerSubmit() async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    Map<String, dynamic> formattedAnswers = {
      "worksheet_id": 846,
      "student_id": 9,
      "data": [],
    };
    List<StudentAnswer> answerSheet = state.answerSheet;
    for (var studentAnswer in answerSheet) {
      formattedAnswers['data'].add(studentAnswer.question.toJson());
    }

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/addworksheetsolveddatav2'));
    request.body = json.encode(formattedAnswers);
    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        emit(state.copyWith(status: WorkSheetSolverStatus.loaded));
        debugPrint('answerSubmit: $formattedAnswers');
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

  void saveAnswerSheet() async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    Map<String, dynamic> formattedAnswers = {};
    List<StudentAnswer> answerSheet = state.answerSheet;
    answerSheet.forEach((studentAnswer) {
      formattedAnswers.addAll(studentAnswer.toJson());
    });
    debugPrint(formattedAnswers.toString());
    // "worksheet_id": 846,
    // "student_id": 9,
    // "data":
    // var headers = {'Content-Type': 'application/json'};
    // //Todo: set the correct API url
    // var request = http.Request(
    //     'POST',
    //     Uri.parse(
    //         'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getworksheetdatav2'));
    // request.body = json.encode({"worksheet_id": 687});
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   var responseString = await response.stream.bytesToString();

    //   List<Question> allQuestion = allWorsheetQuestins(responseString);
    // debugPrint('allQuestions: ${json.encode(allQuestion)}');
    emit(state.copyWith(status: WorkSheetSolverStatus.loaded));
    // } else {
    //   debugPrint(response.reasonPhrase);
    // }
  }

  void getWorksheetsData() async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getworksheetdatav2'));
    request.body = json.encode({"worksheet_id": 687});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      List<Question> allQuestion = allWorsheetQuestins(responseString);
      // debugPrint('allQuestions: ${json.encode(allQuestion)}');
      emit(state.copyWith(
          status: WorkSheetSolverStatus.loaded, questions: allQuestion));
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  Future<List<Question>> getQuestionsList() async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getworksheetdatav2'));
    request.body = json.encode({"worksheet_id": 687});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();

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
    request.body = json.encode({"worksheet_id": 687, "student_id": 11});
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

  Future<List<StudentAnswer>> getStudentAnswerList() async {
    emit(state.copyWith(status: WorkSheetSolverStatus.loading));
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getstudentworksheetdatav2'));
    request.body = json.encode({"worksheet_id": 687, "student_id": 11});
    request.headers.addAll(headers);

    try {
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
        return studentAnswersList;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load student answers');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to student answers');
    }
  }
}
