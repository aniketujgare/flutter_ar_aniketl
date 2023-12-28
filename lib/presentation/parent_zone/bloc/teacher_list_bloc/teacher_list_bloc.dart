import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/teacher_model.dart';

part 'teacher_list_event.dart';
part 'teacher_list_state.dart';
part 'teacher_list_bloc.freezed.dart';

class TeacherListBloc extends Bloc<TeacherListEvent, TeacherListState> {
  TeacherListBloc() : super(const Initial()) {
    on<TeacherListEvent>((events, emit) async {
      await events.map(load: (_) async => await _loadTeachersList(emit));
    });
  }

  _loadTeachersList(Emitter<TeacherListState> emit) async {
    if (state.teachersList.isEmpty) {
      emit(state.copyWith(status: TeacherListStatus.loading));
      final teachers = await _getMessagesByTeacher();
      print(teachers?.length);
      emit(state.copyWith(
          status: TeacherListStatus.loaded, teachersList: teachers!));
    }
  }

  Future<List<TeacherModel>?> _getMessagesByTeacher() async {
    var response = await http.post(
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getallteacherbyschool'),
      body: jsonEncode({"school_id": "0"}),
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin":
            "https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodel/models",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Allow-Headers": "X-Requested-With"
      },
    );
    if (response.statusCode == 200) {
      return teacherModelFromJson(response.body);
    } else {
      print('Failed to load categories. Status code: ${response.statusCode}');
    }
  }
}
