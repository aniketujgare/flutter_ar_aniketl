part of 'teacher_message_cubit.dart';

enum TeacherMessageStatus { initial, loading, loaded, error }

@freezed
class TeacherMessageState with _$TeacherMessageState {
  const factory TeacherMessageState({
    @Default(TeacherMessageStatus.initial) TeacherMessageStatus status,
    @Default([]) List<TeacherMessageModel> teachersMessages,
  }) = Initial;
}
