import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/teacher_message.dart';
import 'package:http/http.dart' as http;

part 'teacher_message_state.dart';
part 'teacher_message_cubit.freezed.dart';

class TeacherMessageCubit extends Cubit<TeacherMessageState> {
  TeacherMessageCubit() : super(const TeacherMessageState());
  void loadMessages() async {
    emit(state.copyWith(status: TeacherMessageStatus.loading));
    List<TeacherMessageModel>? teacherMessahes = await _getTeachersMessages();
    emit(state.copyWith(
        status: TeacherMessageStatus.loaded,
        teachersMessages: teacherMessahes ?? []));
  }

  Future<List<TeacherMessageModel>?> _getTeachersMessages() async {
    var response = await http.post(
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getmessagebyteacher'),
      body: jsonEncode({"division_id": "0", "teacher_user_id": "1"}),
    );
    if (response.statusCode == 200) {
      return teacherMessageModelFromJson(response.body);
    } else {
      print('Failed to load messages. Status code: ${response.statusCode}');
    }
  }
}
