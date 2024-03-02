import 'package:bloc/bloc.dart';
import 'package:flutter_ar/data/models/parent_details.dart';
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show debugPrint;

import 'dart:convert';
part 'parent_details_state.dart';
part 'parent_details_cubit.freezed.dart';

class ParentDetailsCubit extends Cubit<ParentDetailsState> {
  ParentDetailsCubit() : super(ParentDetailsState.initial());

  Future<void> getParentDetails() async {
    emit(state.copyWith(status: ParentDetailsStatus.loading));
    var parentDetailsList = await _getParentDetails();
    emit(state.copyWith(
        status: ParentDetailsStatus.loaded, parentDetails: parentDetailsList));
  }

  Future<List<ParentDetails>> _getParentDetails() async {
    var headers = {'Content-Type': 'application/json'};
    var studentProfile = await AuthenticationRepository().getStudentProfile();
    if (studentProfile?.studentId == -1) {
      return [];
    }
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getparentdetails'));
    request.body = json.encode({"parent_id": "${studentProfile?.parentId}"});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        List<ParentDetails> parentDetailsList =
            parentDetailsFromJson(responseBody);
        return parentDetailsList;
      } else {
        debugPrint(response.reasonPhrase);
        return []; // Return an empty list in case of error
      }
    } catch (e) {
      debugPrint('Error during request: $e');
      return []; // Return an empty list in case of exception
    }
  }
}
