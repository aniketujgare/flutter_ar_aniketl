part of 'model_asset_handler_bloc.dart';

enum ModelAssetHandlerStatus { initial, downloading, loading, loaded, error }

@freezed
class ModelAssetHandlerState with _$ModelAssetHandlerState {
  const factory ModelAssetHandlerState.initial({
    @Default(ModelAssetHandlerStatus.initial) ModelAssetHandlerStatus status,
    @Default('') String errorMessage,
    @Default('') String modelPath,
    @Default('') String progressValue,
  }) = Initial;
}
