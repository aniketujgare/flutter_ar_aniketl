import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show debugPrint;

import '../../../../data/models/parent_details.dart';
import '../../../../data/models/student_profile_model.dart';
import '../../../../data/models/teacher_message.dart';
import '../../../../domain/repositories/authentication_repository.dart';

part 'teacher_message_cubit.freezed.dart';
part 'teacher_message_state.dart';

class TeacherMessageCubit extends Cubit<TeacherMessageState> {
  TeacherMessageCubit() : super(const TeacherMessageState());

  Future<void> answerPollQuestion(int optionIndex, TeacherMessageModel message,
      int messageStateIndex) async {
    // emit(state.copyWith(status: TeacherMessageStatus.loading));
    var entriesM = message.pollOptions!.entries.toList();
    var keys = message.pollOptions!.keys.toList();
    var copiedMessages = Map.fromEntries(entriesM);
    //Get teacher name
    List<ParentDetails> studentProfile = await _getParentDetails();
    String parentName = studentProfile.first.parentName; //"andr8oid";

    //if any option is preselected with currParentName
    bool isPreMarked =
        copiedMessages.values.any((element) => element.name == parentName);
    //isPreMarked is true-> remove the name and cnt--
    if (isPreMarked) {
      copiedMessages.forEach((k, v) {
        if (v.name == parentName) {
          v.name = null;
          v.count = v.count - 1;
        }
      });
    }
    //isPreMarked is false-> add the name and cnt++
    copiedMessages.update(keys[optionIndex],
        (upda) => upda.copyWith(count: upda.count + 1, name: parentName));

    var updatedMsg = message.copyWith(pollOptions: copiedMessages);

    //Send this to api updateMsg

    //Message ID

    print(
        'poll saved $optionIndex || ${jsonEncode(updatedMsg)} || preMarked: $isPreMarked');
    var msgList = List<TeacherMessageModel>.from(state.teachersMessages);
    msgList.removeAt(messageStateIndex);
    msgList.insert(messageStateIndex, updatedMsg);
    emit(state.copyWith(teachersMessages: msgList));
  }

  void loadMessages(String teacherUserId) async {
    emit(state.copyWith(status: TeacherMessageStatus.loading));
    List<TeacherMessageModel>? teacherMessahes =
        await _getTeachersMessages(teacherUserId);

    if (teacherMessahes != null) {
      reverse(teacherMessahes);
    }

    emit(state.copyWith(
        status: TeacherMessageStatus.loaded,
        teachersMessages: teacherMessahes ?? []));
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

  Future<List<TeacherMessageModel>?> _getTeachersMessages(
      String teacherUserId) async {
    StudentProfileModel? studentProfile =
        await AuthenticationRepository().getStudentProfile();
    var response = await http.post(
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getmessagebyteacher'),
      body: jsonEncode({
        "division_id": "${studentProfile?.divisionId}",
        "teacher_user_id": teacherUserId
      }),
    );
    if (response.statusCode == 200) {
      return teacherMessageModelFromJson(response.body);
    } else {
      debugPrint(
          'Failed to load messages. Status code: ${response.statusCode}');
    }
  }
}
