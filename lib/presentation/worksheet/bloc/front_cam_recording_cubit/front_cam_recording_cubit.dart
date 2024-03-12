import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'front_cam_recording_state.dart';
part 'front_cam_recording_cubit.freezed.dart';

class FrontCamRecordingCubit extends Cubit<FrontCamRecordingState> {
  FrontCamRecordingCubit() : super(const FrontCamRecordingState.initial());
}
