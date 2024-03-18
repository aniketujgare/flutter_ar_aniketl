import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;

import '../models/questions.dart';
import 'package:http/http.dart' as http;

import '../models/worksheet_ans_of_student.dart';

class WorksheetSolverRepository {
  var client = http.Client();
  Future<List<Question>> getQuestionsList(int worksheetId) async {
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

  Future<List<StudentAnswer>> getStudentAnswerList(
      int worksheetId, int studentId) async {
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
        print(responseString.runtimeType);

        // Check if response is 0
        if (responseString == '0') {
          return []; // Return an empty list if no data exists
        }

        List<Map<String, dynamic>> jsonList =
            List<Map<String, dynamic>>.from(jsonDecode(responseString));

        List<StudentAnswer> studentAnswersList =
            jsonList.asMap().entries.map((entry) {
          return StudentAnswer.fromJson(entry.key.toString(), entry.value);
        }).toList();

        // Sorting the list based on questionNo
        studentAnswersList.sort((a, b) => a.questionNo.compareTo(b.questionNo));
        debugPrint('studentAnsSheet: ${jsonEncode(studentAnswersList)}');

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
