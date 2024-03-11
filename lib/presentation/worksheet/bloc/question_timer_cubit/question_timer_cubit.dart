import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_timer_state.dart';
part 'question_timer_cubit.freezed.dart';

class QuestionTimerCubit extends Cubit<QuestionTimerState> {
  QuestionTimerCubit() : super(const QuestionTimerState.initial());
  late Timer timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('Timer: ${timer.tick}');
      emit(state.copyWith(
          currentTime: state.endTime - timer.tick,
          status: QuestionTimerStatus.progressing));
      // counter--;
      if (timer.tick == state.endTime) {
        emit(state.copyWith(
            currentTime: state.endTime - timer.tick,
            status: QuestionTimerStatus.end));

        print('Cancel timer');
        timer.cancel();
      }
    });
    emit(state.copyWith(status: QuestionTimerStatus.initial));
  }

  void stopTime() {
    timer.cancel();
    emit(state.copyWith(status: QuestionTimerStatus.initial));
  }
}
