import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/student_worksheet_data.dart';

part 'worksheet_ans_of_student_cubit.freezed.dart';
part 'worksheet_ans_of_student_state.dart';

class WorksheetAnsOfStudentCubit extends Cubit<WorksheetAnsOfStudentState> {
  WorksheetAnsOfStudentCubit()
      : super(const WorksheetAnsOfStudentState.initial());

  void getStudentWorksheetData() async {
    emit(state.copyWith(status: WorksheetAnsOfStudentStatus.loading));
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
      // var studentWorksheetsData = studentWorksheetDataFromJson(responseString);
      // emit(state.copyWith(
      //     status: WorksheetAnsOfStudentStatus.loaded,
      //     workshitAnsOfStudent: studentWorksheetsData));
      // debugPrint('WorksheetsData: ${json.encode(studentWorksheetsData)}');
    } else {
      debugPrint(response.reasonPhrase);
    }
  }
}
