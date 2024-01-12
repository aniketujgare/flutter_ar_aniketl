import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_ar/data/models/student_worksheet_data.dart';
import 'package:flutter_ar/data/models/worksheet_data.dart';
import 'package:flutter_ar/data/models/worksheet_details.dart';
import 'package:flutter_ar/data/models/worksheet_details_model.dart';
import '../../../../data/models/published_worksheets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'worksheet_state.dart';
part 'worksheet_cubit.freezed.dart';

class WorksheetCubit extends Cubit<WorksheetState> {
  WorksheetCubit() : super(const WorksheetState.initial());
  //?API's using in UI

  void getWorksheets() async {
    emit(state.copyWith(status: WorksheetStatus.loading));
    List<WorksheetDetailsModel> allWorksheetDetails = [];
    List<PublishedWorksheets> publishedWorksheets =
        await getPublishedWorksheet();
    await Future.forEach(publishedWorksheets,
        (PublishedWorksheets sheet) async {
      List<WorksheetDetails> worksheetDetails =
          await getWorksheetDetails('${sheet.worksheetId}');

      // Perform your operation on worksheetDetails here, if needed
      await Future.forEach(worksheetDetails,
          (WorksheetDetails sheetDetail) async {
        WorksheetDetailsModel worksheet = WorksheetDetailsModel(
          id: sheetDetail.id,
          status: sheetDetail.status,
          topic: sheetDetail.topicId.toString(),
          worksheetName: sheetDetail.worksheetName,
          subject: '',
          teacher: '',
        );
        String subject = await getsubjectname(sheetDetail.subjectId.toString());
        String teacherName =
            await getteachername(sheetDetail.teacherId.toString());
        worksheet.subject = subject;
        worksheet.teacher = teacherName;
        allWorksheetDetails.add(worksheet);
      });
    });
    // debugPrint('All WorkSheet: ${json.encode(allWorksheetDetails)}');
    emit(state.copyWith(
        status: WorksheetStatus.loaded, worksheets: allWorksheetDetails));
  }

  void getStudentWorksheet() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getstudentworksheets'));
    request.body = json.encode({"worksheet_id": "787", "student_id": "1"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      // debugPrint('StudentWorksheet: ${json.decode(responseString)}');
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

//? All APIs Available for Worksheets
  Future<List<PublishedWorksheets>> getPublishedWorksheet() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getpublishedworksheets'),
    );
    request.body = json.encode({"standard_id": "3", "division_id": "0"});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final String responseString = await response.stream.bytesToString();
        List<PublishedWorksheets> publishedworksheets =
            publishedworksheetsFromJson(responseString);
        // debugPrint('publishedworksheets: ${json.encode(publishedworksheets)}');
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
    request.body = json.encode({"worksheet_id": "$worksheetId"});
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