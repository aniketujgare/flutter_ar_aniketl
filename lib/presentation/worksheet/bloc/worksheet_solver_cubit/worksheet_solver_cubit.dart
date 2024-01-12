// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/questions.dart';
import '../../../../data/models/student_worksheet_data.dart';
import '../../../../data/models/worksheet_ans_of_student.dart';
import '../../../../data/models/worksheet_data.dart';

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