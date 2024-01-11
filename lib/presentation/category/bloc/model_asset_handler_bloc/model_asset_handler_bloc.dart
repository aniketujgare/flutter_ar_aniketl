import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:download_assets/download_assets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_asset_handler_event.dart';
part 'model_asset_handler_state.dart';
part 'model_asset_handler_bloc.freezed.dart';

class ModelAssetHandlerBloc
    extends Bloc<ModelAssetHandlerEvent, ModelAssetHandlerState> {
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  ModelAssetHandlerBloc() : super(const Initial()) {
    on<ModelAssetHandlerEvent>((events, emit) async {
      await downloadAssetsController.init();
      await events.map(load: (event) async => await _loadAssets(event, emit));
    });
  }

  _loadAssets(
      LoadModelAsset event, Emitter<ModelAssetHandlerState> emit) async {
    emit(state.copyWith(status: ModelAssetHandlerStatus.loading));
    bool isExists = await checkModelExists(event.modelName);
    if (isExists) {
      emit(state.copyWith(
          status: ModelAssetHandlerStatus.loaded, modelPath: event.modelName));
    } else {
      _downloadAssets(event.modelName);
    }
  }

  Future<bool> checkModelExists(String modelName) async {
    bool isExists =
        await downloadAssetsController.assetsFileExists('$modelName.glb');
    return isExists;
  }

  Future _downloadAssets(String modelName) async {
    try {
      //  double value = 0.0;
      await downloadAssetsController.startDownload(
        // onCancel: () {
        //   message = 'Cancelled by user';
        //   setState(() {});
        // },
        assetsUrls: [
          // 'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/images/$modelName.png',
          'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/models/$modelName.glb',
          // widget.modelUrl,
          //  'https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodellist/images/${widget.modelName}.glb'
          // 'https://github.com/edjostenes/download_assets/raw/main/download/image_1.png',
          // 'https://github.com/edjostenes/download_assets/raw/main/download/assets.zip',
          // 'https://github.com/edjostenes/download_assets/raw/main/download/image_2.png',
          // 'https://github.com/edjostenes/download_assets/raw/main/download/image_3.png',
        ],
        onProgress: (progressValue) {
          // downloaded = false;
          // value = progressValue;
          emit(state.copyWith(
              status: ModelAssetHandlerStatus.downloading,
              progressValue:
                  'Downloading - ${progressValue.toStringAsFixed(2)}'));
          // setState(() {
          //   downloaded = progressValue >= 100.0;
          //   message = 'Downloading - ${progressValue.toStringAsFixed(2)}';
          //   print(message);

          //   if (downloaded) {
          //     message =
          //         'Download completed\nClick in refresh button to force download';
          //   }
          // });
          if (progressValue >= 100.0) {
            emit(state.copyWith(
                status: ModelAssetHandlerStatus.loaded, modelPath: modelName));
          }
        },
      );
    } on DownloadAssetsException catch (e) {
      // print(e.toString());
      // setState(() {
      //   downloaded = false;
      //   message = 'Error: ${e.toString()}';
      // });
      emit(state.copyWith(
          status: ModelAssetHandlerStatus.error,
          errorMessage: 'Error: ${e.toString()}'));
    }
  }
}
