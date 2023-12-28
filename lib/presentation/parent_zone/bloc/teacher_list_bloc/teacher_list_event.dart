part of 'teacher_list_bloc.dart';

@freezed
class TeacherListEvent with _$TeacherListEvent {
  const factory TeacherListEvent.load() = LoadTeachersList;
}
