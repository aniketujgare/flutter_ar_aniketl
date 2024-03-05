import 'dart:io';

import 'package:download_assets/download_assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_asset_handler_event.dart';
part 'model_asset_handler_state.dart';
part 'model_asset_handler_bloc.freezed.dart';

class ModelAssetHandlerBloc
    extends Bloc<ModelAssetHandlerEvent, ModelAssetHandlerState> {
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();

  ModelAssetHandlerBloc() : super(const Initial()) {
    _initialize();
    on<ModelAssetHandlerEvent>(_handleEvent);
  }
  Future<void> _initialize() async {
    await downloadAssetsController.init();
    on<ModelAssetHandlerEvent>(_handleEvent);
  }

  Future<void> _handleEvent(ModelAssetHandlerEvent event,
      Emitter<ModelAssetHandlerState> emit) async {
    if (event is LoadModelAsset) {
      await _loadAssets(event, emit);
    } else if (event is RetryLoadModelAsset) {
      _retryLoadAssets(event, emit);
    }
  }

  Future<void> _loadAssets(
      LoadModelAsset event, Emitter<ModelAssetHandlerState> emit) async {
    emit(state.copyWith(status: ModelAssetHandlerStatus.loading));
    bool isExists = await checkModelExists(event.modelName);
    if (isExists) {
      emit(state.copyWith(
          status: ModelAssetHandlerStatus.loaded, modelPath: event.modelName));
    } else {
      await _downloadAssets(event.modelName, emit);
    }
  }

  Future<bool> checkModelExists(String modelName) async {
    bool isExists =
        await downloadAssetsController.assetsFileExists('$modelName.glb');
    return isExists;
  }

  Future<void> _downloadAssets(
      String modelName, Emitter<ModelAssetHandlerState> emit) async {
    emit(state.copyWith(status: ModelAssetHandlerStatus.downloading));
    try {
      await downloadAssetsController.startDownload(
        assetsUrls: [
          'https://d3ag5oij4wsyi3.cloudfront.net/classroom_app/models/$modelName.glb',
        ],
        onProgress: (progressValue) {
          print('progress value:$progressValue');
          emit(state.copyWith(
              status: ModelAssetHandlerStatus.downloading,
              progressValue:
                  'Downloading - ${progressValue.toStringAsFixed(2)}'));
          if (progressValue >= 100.0) {
            emit(state.copyWith(
                status: ModelAssetHandlerStatus.loaded, modelPath: modelName));
          }
        },
      );
    } on DownloadAssetsException catch (e) {
      emit(state.copyWith(
          status: ModelAssetHandlerStatus.error,
          errorMessage: 'Error: ${e.toString()}'));
    }
  }

  void _retryLoadAssets(
      RetryLoadModelAsset event, Emitter<ModelAssetHandlerState> emit) {
    emit(state.copyWith(status: ModelAssetHandlerStatus.loading));
    _downloadAssets(event.modelName, emit);
  }
}
