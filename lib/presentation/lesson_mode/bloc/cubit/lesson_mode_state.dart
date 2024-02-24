part of 'lesson_mode_cubit.dart';

enum LessonModeStatus { initial, loading, loaded, error }

@freezed
class LessonModeState with _$LessonModeState {
  const factory LessonModeState.initial({
    @Default(LessonModeStatus.initial) status,
    @Default([]) List<LessonModeModel> lesson,
    @Default(0) int currentQuestion,
  }) = Initial;
}
