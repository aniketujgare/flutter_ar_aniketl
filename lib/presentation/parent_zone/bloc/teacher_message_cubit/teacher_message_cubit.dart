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

class PollData {
  final String count;
  final String option;
  List<String>? name;

  PollData({required this.count, required this.option, this.name});

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'option': option,
      'name': name,
    };
  }
}

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
    bool isPreMarked = false;

    for (var element in copiedMessages.values) {
      if (element.name != null) {
        element.name!.contains(parentName);
        isPreMarked = true;
        break;
      }
    }

    //isPreMarked is true-> remove the name and cnt--
    if (isPreMarked) {
      copiedMessages.forEach((k, v) {
        if (v.name != null && v.name!.contains(parentName)) {
          v.name!.removeWhere((element) => element == parentName);
          v.count = v.count - 1; // Decreasing count
          return; // Exit the loop after decrementing count once
        }
      });
    }
    //isPreMarked is false-> add the name and cnt++
    var names = copiedMessages[keys[optionIndex]]?.name ?? [];
    names.add(parentName);
    copiedMessages.update(keys[optionIndex],
        (upda) => upda.copyWith(count: upda.count + 1, name: names));

    var updatedMsg = message.copyWith(pollOptions: copiedMessages);

    //Send this to api updateMsg

    //Message ID

    print(
        'poll saved $optionIndex || ${jsonEncode(convertToApiFormat(updatedMsg.toJson()))} || preMarked: $isPreMarked');
    var msgList = List<TeacherMessageModel>.from(state.teachersMessages);
    msgList.removeAt(messageStateIndex);
    msgList.insert(messageStateIndex, updatedMsg);
    emit(state.copyWith(teachersMessages: msgList));
  }

  Map<String, dynamic> convertToApiFormat(Map<String, dynamic> data) {
    // Extract necessary fields from the original data
    final content = data['content'];
    final time = data['time'];
    final messageId = data['message_id'];
    final pollData = data['data'] as Map<String, dynamic>;

    // Map your poll data to the API structure
    final apiPollData = pollData.entries.map((entry) {
      return PollData(
              count: entry.value['count'],
              option: entry.key,
              name: entry.value['name'])
          .toJson();
    }).toList();

    // Construct the API-compatible payload
    final apiPayload = {
      'teacher_user_id': data['teacher_user_id'],
      'subject': data['subject'],
      'content': content,
      'time': time,
      'type': data['type'],
      'data': {'polldata': apiPollData},
      'link': data['link'],
      'message_id': messageId,
    };

    return apiPayload;
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
