import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/student_profile_model.dart';
import '../../../../data/models/teacher_message.dart';
import '../../../../domain/repositories/authentication_repository.dart';

part 'teacher_message_cubit.freezed.dart';
part 'teacher_message_state.dart';

class TeacherMessageCubit extends Cubit<TeacherMessageState> {
  TeacherMessageCubit() : super(const TeacherMessageState());
  void loadMessages(String teacherUserId) async {
    emit(state.copyWith(status: TeacherMessageStatus.loading));
    List<TeacherMessageModel>? teacherMessahes =
        await _getTeachersMessages(teacherUserId);
    emit(state.copyWith(
        status: TeacherMessageStatus.loaded,
        teachersMessages: teacherMessahes ?? []));
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
      print('Failed to load messages. Status code: ${response.statusCode}');
    }
  }
}
