part of 'worksheet_cubit.dart';

enum WorksheetStatus { initial, loading, loaded, error }

@freezed
class WorksheetState with _$WorksheetState {
  const factory WorksheetState.initial({
    @Default(WorksheetStatus.initial) WorksheetStatus status,
    @Default([]) List<WorksheetDetailsModel> worksheets,
  }) = Initial;
}
