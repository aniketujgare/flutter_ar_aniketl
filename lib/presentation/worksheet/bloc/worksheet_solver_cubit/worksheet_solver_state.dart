part of 'worksheet_solver_cubit.dart';

enum WorkSheetSolverStatus { initial, loading, loaded, error }

@freezed
class WorksheetSolverState with _$WorksheetSolverState {
  const factory WorksheetSolverState.initial({
    @Default(WorkSheetSolverStatus.initial) WorkSheetSolverStatus status,
    @Default([]) List<Question> questions,
    @Default([]) List<StudentAnswer> answerSheet,
    @Default(0) int currentQuestion,
  }) = Initial;
}
