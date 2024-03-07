import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_ar/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/student_profile_model.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../models/published_worksheets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../models/questions.dart';
import '../../models/worksheet_ans_of_student.dart';
import '../../models/worksheet_details.dart';
import '../../models/worksheet_details_model.dart';

part 'worksheet_state.dart';
part 'worksheet_cubit.freezed.dart';

class WorksheetCubit extends Cubit<WorksheetState> {
  WorksheetCubit() : super(const WorksheetState.initial());
  //?API's using in UI

  void getWorksheets() async {
    emit(state.copyWith(status: WorksheetStatus.loading));
    List<WorksheetDetailsModel> allWorksheetDetails = [];
    List<WorksheetDetailsModel> solvedWorksheets = [];
    List<PublishedWorksheets> publishedWorksheets =
        await getPublishedWorksheet();
    await Future.forEach(publishedWorksheets,
        (PublishedWorksheets sheet) async {
      List<WorksheetDetails> worksheetDetails =
          await getWorksheetDetails('${sheet.worksheetId}');
      worksheetDetails.removeWhere((element) => element.status != "active");

      //Remove worksheets marked with status 'submitted'
      // Perform your operation on worksheetDetails here, if needed
      await Future.forEach(worksheetDetails,
          (WorksheetDetails sheetDetail) async {
        StudentProfileModel? studentProfile =
            //Mark no of q solved on worksheet card
            await AuthenticationRepository().getStudentProfile();
        int solvedQCnt = await getSolvedQCount(
            sheetDetail.id, studentProfile?.studentId ?? 0);
        // Get All Questions count
        int allQuestionCnt = await getQuestionsCount(sheetDetail.id);
        // print('worksheet ID: ${sheetDetail.id} || allQCnt: $allQuestionCnt');
        WorksheetDetailsModel worksheet = WorksheetDetailsModel(
          id: sheetDetail.id,
          status: sheetDetail.status,
          topic: sheetDetail.topicId.toString(),
          worksheetName: sheetDetail.worksheetName,
          subject: '',
          teacher: '',
          solvedQuestinCount: solvedQCnt,
          allQuestionCount: allQuestionCnt,
          deadline: DateFormat('dd MMM yy').format(sheet.deadline),
        );
        String subject = await getsubjectname(sheetDetail.subjectId.toString());
        String teacherName =
            await getteachername(sheetDetail.teacherId.toString());
        worksheet.subject = subject;
        worksheet.teacher = teacherName;
        if (solvedQCnt != allQuestionCnt || allQuestionCnt == 0) {
          allWorksheetDetails.add(worksheet);
        } else if (allQuestionCnt != 0) {
          solvedWorksheets.add(worksheet);
        }
      });
    });
    // debugPrint('All WorkSheet: ${json.encode(allWorksheetDetails)}');
    emit(state.copyWith(
        status: WorksheetStatus.loaded,
        worksheets: allWorksheetDetails,
        historyWorksheets: solvedWorksheets));
  }

  Future<int> getQuestionsCount(int worksheetId) async {
    emit(state.copyWith(status: WorksheetStatus.loading));
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
        print(responseString);
        if (responseString == 'null') {
          return 0;
        }
        List<Question> allQuestion = allWorsheetQuestins(responseString);
        return allQuestion.length;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load worksheet questions');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to loadworksheet questions');
    }
  }

  Future<int> getSolvedQCount(int worksheetId, int studentId) async {
    emit(state.copyWith(status: WorksheetStatus.loading));
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
            // log('entry: ${entry.value}');

            return StudentAnswer.fromJson(entry.key.toString(), entry.value);
          }).toList();
          print('studentAnsSheet: ${jsonEncode(studentAnswersList)}');

          // Sorting the list based on questionNo
          studentAnswersList
              .sort((a, b) => a.questionNo.compareTo(b.questionNo));
          return jsonList.length;
        } else {
          return 0;
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

  Future<String> getStudentWorksheet(
      String worksheetId, String studentId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getstudentworksheets'));
    request.body =
        json.encode({"worksheet_id": worksheetId, "student_id": studentId});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        return responseString;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load worksheet history');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to load worksheet history');
    }
  }

  void getWorksheetsHistory() async {
    emit(state.copyWith(status: WorksheetStatus.loading));
    StudentProfileModel? studentProfile =
        await authenticationRepository.getStudentProfile();
    List<WorksheetDetailsModel> worksheetList =
        List.from(state.worksheets); // Convert to modifiable list
    List<WorksheetDetailsModel> worksheetsToRemove = [];

    for (var worksheet in worksheetList) {
      String response = await getStudentWorksheet(
          worksheet.id.toString(), '${studentProfile?.studentId}');

      if (response == '0') {
        worksheetsToRemove.add(worksheet);
      } else {}
    }

    // Remove worksheets after the loop

    worksheetList
        .removeWhere((worksheet) => worksheetsToRemove.contains(worksheet));

    emit(state.copyWith(
      status: WorksheetStatus.loaded,
      historyWorksheets: worksheetList,
    ));
  }

//? All APIs Available for Worksheets
  Future<List<PublishedWorksheets>> getPublishedWorksheet() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getpublishedworksheets'),
    );
    StudentProfileModel? studentProfile =
        await authenticationRepository.getStudentProfile();
    if (studentProfile?.studentId == -1) {
      return [];
    }
    // log(jsonEncode(studentProfile));
    request.body = json.encode({
      "standard_id": "${studentProfile!.standardId}",
      "division_id": "${studentProfile!.divisionId}"
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final dynamic responseString = await response.stream.bytesToString();
        if (responseString is int || responseString == "0") {
          print('no list in the db');
          return [];
        }
        List<PublishedWorksheets> publishedworksheets =
            publishedworksheetsFromJson(responseString);
        return publishedworksheets;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load published worksheets');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to load published worksheets');
    }
  }

  Future<List<WorksheetDetails>> getWorksheetDetails(String worksheetId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getworksheetdetails'),
    );
    request.body = json.encode({"worksheet_id": worksheetId});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        List<WorksheetDetails> worksheetDetails =
            worksheetDetailsFromJson(responseString);
        // debugPrint('worksheetDetails: ${json.encode(worksheetDetails)}');
        return worksheetDetails;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load worksheet details');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to load worksheet details');
    }
  }

  Future<String> getteachername(String teacherId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getteachername'));
      request.body = json.encode({"teacher_user_id": teacherId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        // debugPrint('Teacher\'s Name: ${json.decode(responseString)}');
        return json.decode(responseString);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to get teacher name');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to get teacher name');
    }
  }

  Future<String> getsubjectname(String subjectId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getsubjectname'));
      request.body = json.encode({"subject_id": subjectId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        // debugPrint('Subject Name: ${json.decode(responseString)}');
        return json.decode(responseString);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to get subject name');
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      throw Exception('Failed to get subject name');
    }
  }
}
