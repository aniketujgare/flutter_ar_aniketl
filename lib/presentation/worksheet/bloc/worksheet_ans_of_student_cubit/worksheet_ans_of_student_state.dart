part of 'worksheet_ans_of_student_cubit.dart';

enum WorksheetAnsOfStudentStatus { initial, loading, loaded, error }

@freezed
class WorksheetAnsOfStudentState with _$WorksheetAnsOfStudentState {
  const factory WorksheetAnsOfStudentState.initial({
    @Default(WorksheetAnsOfStudentStatus.initial)
    WorksheetAnsOfStudentStatus status,
    @Default({}) Map<String, StudentWorksheetData> workshitAnsOfStudent,
  }) = Initial;
}
