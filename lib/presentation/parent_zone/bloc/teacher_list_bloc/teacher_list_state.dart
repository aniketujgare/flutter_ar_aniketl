part of 'teacher_list_bloc.dart';

enum TeacherListStatus { initial, loading, loaded, error }

@freezed
class TeacherListState with _$TeacherListState {
  const factory TeacherListState({
    @Default(TeacherListStatus.initial) TeacherListStatus status,
    @Default([]) final List<TeacherModel> teachersList,
    @Default([]) final List<TeacherMessageModel> teacherMessage,
    @Default('Failed to load teachers list') String errorMessage,
  }) = Initial;
}
