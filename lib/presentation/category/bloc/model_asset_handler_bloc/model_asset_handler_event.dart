part of 'model_asset_handler_bloc.dart';

@freezed
class ModelAssetHandlerEvent with _$ModelAssetHandlerEvent {
  const factory ModelAssetHandlerEvent.load({required final String modelName}) =
      LoadModelAsset;
  const factory ModelAssetHandlerEvent.retry(
      {required final String modelName}) = RetryLoadModelAsset;
}
