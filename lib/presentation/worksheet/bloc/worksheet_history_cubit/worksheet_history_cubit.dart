import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/worksheet_details_model.dart';

part 'worksheet_history_state.dart';
part 'worksheet_history_cubit.freezed.dart';

class WorksheetHistoryCubit extends Cubit<WorksheetHistoryState> {
  WorksheetHistoryCubit() : super(const WorksheetHistoryState.initial());
}
