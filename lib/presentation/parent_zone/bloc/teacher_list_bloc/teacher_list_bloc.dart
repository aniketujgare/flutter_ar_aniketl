import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/student_profile_model.dart';
import '../../../../data/models/teacher_message.dart';
import '../../../../data/models/teacher_model.dart';

part 'teacher_list_bloc.freezed.dart';
part 'teacher_list_event.dart';
part 'teacher_list_state.dart';

class TeacherListBloc extends Bloc<TeacherListEvent, TeacherListState> {
  TeacherListBloc() : super(const Initial()) {
    on<TeacherListEvent>((events, emit) async {
      await events.map(load: (_) async => await _loadTeachersList(emit));
    });
  }

  _loadTeachersList(Emitter<TeacherListState> emit) async {
    if (state.teachersList.isEmpty) {
      emit(state.copyWith(status: TeacherListStatus.loading));
      List<TeacherModel>? teachers = await _getMessagesByTeacher();
      List<TeacherMessageModel> teacherMessages = [];
      if (teachers != null) {
        for (var teacher in teachers) {
          print('here');
          var tMessages =
              await _getTeachersMessages(teacher.teacherUserId.toString());
          teacherMessages.addAll(tMessages ?? []);
        }
      }

      print(teachers?.length);
      emit(state.copyWith(
          status: TeacherListStatus.loaded,
          teachersList: teachers!,
          teacherMessage: teacherMessages.first));
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
      print('Failed to load messages. Status code: ${response.statusCode}');
    }
  }

  Future<List<TeacherModel>?> _getMessagesByTeacher() async {
    StudentProfileModel? studentProfile =
        await AuthenticationRepository().getStudentProfile();
    var response = await http.post(
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getallteacherbyschool'),
      body: jsonEncode({"school_id": "${studentProfile?.schoolId}"}),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin":
            "https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodel/models",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Allow-Headers": "X-Requested-With"
      },
    );
    if (response.statusCode == 200) {
      List<TeacherModel> teachers = teacherModelFromJson(response.body);
      List<TeacherModel> newTeachers = [];
      for (var teacher in teachers) {}
      print(teachers);

      return teachers;
    } else {
      print('Failed to load categories. Status code: ${response.statusCode}');
    }
  }

  Future<String> getSubjectName(int subjectId) async {
    Uri url = Uri.parse(
        "https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getsubjectname");
    try {
      var response =
          await http.post(url, body: jsonEncode({"mobno": "$subjectId"}));
      if (response.statusCode == 200) {
        String subjectName = jsonDecode(response.body);
        print(subjectName);
        return subjectName;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load parentId');
      }
    } catch (e) {
      // Handle errors here
      print('Error in getParentId: $e');
      // You might want to rethrow the exception or return a default value here
      throw Exception('Failed to get parentId');
    }
  }
}
