import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_timer_state.dart';
part 'question_timer_cubit.freezed.dart';

class QuestionTimerCubit extends Cubit<QuestionTimerState> {
  QuestionTimerCubit() : super(const QuestionTimerState.initial());
  late Timer timer;
  void initTimer() {
    timer = Timer(Duration.zero, () {});
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('Timer: ${state.endTime - timer.tick}');
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
  }

  void stopTime() {
    timer.cancel();
    emit(state.copyWith(status: QuestionTimerStatus.initial));
  }
}
