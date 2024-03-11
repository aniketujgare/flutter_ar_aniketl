part of 'question_timer_cubit.dart';

enum QuestionTimerStatus { initial, progressing, end }

@freezed
class QuestionTimerState with _$QuestionTimerState {
  const factory QuestionTimerState.initial({
    @Default(QuestionTimerStatus.end) QuestionTimerStatus status,
    @Default(0) int startTime,
    @Default(30) int endTime,
    @Default(0) int currentTime,
  }) = QuestionTimer;
}
