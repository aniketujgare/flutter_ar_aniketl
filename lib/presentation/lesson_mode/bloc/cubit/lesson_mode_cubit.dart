import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_ar/presentation/lesson_mode/data/model/lesson_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'lesson_mode_state.dart';
part 'lesson_mode_cubit.freezed.dart';

class LessonModeCubit extends Cubit<LessonModeState> {
  LessonModeCubit() : super(const LessonModeState.initial());

  loadLesson() async {
    emit(state.copyWith(status: LessonModeStatus.loading));
    List<LessonModeModel> v = await getLessonMode();
    emit(state.copyWith(status: LessonModeStatus.loaded, lesson: v!));
  }

  Future<void> loadNextQuestion() async {
    if (state.currentQuestion + 1 < state.lesson.length) {
      emit(state.copyWith(status: LessonModeStatus.loading));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(
          status: LessonModeStatus.loaded,
          currentQuestion: state.currentQuestion + 1));
    }
  }

  Future<void> loadPreviousQuestion() async {
    if (state.currentQuestion - 1 >= 0) {
      emit(state.copyWith(status: LessonModeStatus.loading));
      await Future.delayed(const Duration(milliseconds: 100));

      emit(state.copyWith(
          status: LessonModeStatus.loaded,
          currentQuestion: state.currentQuestion - 1));
    }
  }

  Future<List<LessonModeModel>> getLessonMode() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://xc62c4nbgb.execute-api.ap-south-1.amazonaws.com/dev/getlessonplandata'));
    request.body = json.encode({"lesson_id": 229});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        List<LessonModeModel> parsedData =
            lessonModeModelFromJson(responseData);
        print(parsedData); // Use the parsed data as needed
        return parsedData;
      } else {
        print('Error: ${response.reasonPhrase}');
        return []; // Return an empty list in case of error
      }
    } catch (e) {
      print('Exception occurred: $e');
      return []; // Return an empty list in case of exception
    }
  }
}
