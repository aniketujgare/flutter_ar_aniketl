part of 'worksheet_history_cubit.dart';

enum WorksheetHistoryStatus { initial, loading, loaded, error }

@freezed
class WorksheetHistoryState with _$WorksheetHistoryState {
  const factory WorksheetHistoryState.initial({
    @Default(WorksheetHistoryStatus.initial) WorksheetHistoryStatus status,
    @Default([]) List<WorksheetDetailsModel> historyWorksheets,
  }) = Initial;
}
