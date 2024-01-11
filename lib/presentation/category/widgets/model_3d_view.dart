import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/ar_core/flutter_ar.dart';
import 'package:flutter_ar/presentation/category/widgets/ar_view_ios.dart';
import 'package:flutter_ar/temp_testing/asset_download.dart';
import 'package:flutter_ar/temp_testing/unityScene.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:size_config/size_config.dart';

import '../bloc/model_asset_handler_bloc/model_asset_handler_bloc.dart';
import '../bloc/model_asset_handler_bloc/model_asset_handler_bloc.dart';

class ModelView extends StatefulWidget {
  final String modelUrl;
  final String modelName;
  final String imageFileName;
  const ModelView(
      {super.key,
      required this.modelUrl,
      required this.modelName,
      required this.imageFileName});

  @override
  State<ModelView> createState() => _ModelViewState();
}

class _ModelViewState extends State<ModelView> {
  @override
  void initState() {
    context
        .read<ModelAssetHandlerBloc>()
        .add(LoadModelAsset(modelName: widget.imageFileName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFF4F2FE),
        body: BlocBuilder<ModelAssetHandlerBloc, ModelAssetHandlerState>(
          builder: (context, state) {
            print('current state: ${state.status}');
            if (state.status == ModelAssetHandlerStatus.error) {
              return const Center(
                child: Text('Error Downloading model'),
              );
            }
            if (state.status == ModelAssetHandlerStatus.loaded) {
              return Padding(
                padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ModelViewer(
                        backgroundColor: const Color(0XFFF4F2FE),
                        src:
                            'file:///data/user/0/com.example.flutter_ar/app_flutter/assets/${widget.imageFileName}.glb',
                        alt: 'A 3D model of an astronaut',
                        ar: Platform.isAndroid ? true : false,
                        autoPlay: true,
                        autoRotate: true,
                        // scale: '0.1 0.1 0.1',
                        arPlacement: ArPlacement.floor,
                        arModes: const ['scene-viewer'],
                        disableZoom: true,
                        loading: Loading.eager,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                          height: 65.h,
                          width: 65.h,
                          child: Image.asset(
                            'assets/ui/fi-br-volume 2.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    if (Platform.isIOS)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          //? IOS AR View
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return ARViewIOS(
                                  modelUrl: widget.modelUrl,
                                  imageFileName: widget.imageFileName,
                                );
                                // return ARViewIOS(modelUrl: widget.modelUrl);
                              }),
                            );
                          },
                          child: SizedBox(
                              height: 65.h,
                              width: 65.h,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(13.h),
                                  child: Image.asset(
                                    'assets/images/PNG Icons/AR Icon.png',
                                  ),
                                ),
                              )),
                        ),
                      ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 65.h,
                        width: 65.h,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Image.asset(
                            'assets/ui/Group.png',
                            fit: BoxFit.scaleDown,
                            // height: 45,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 65.h,
                        // width: 65.h,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 3.0),
                            ),
                            child: Text(
                              widget.modelName,
                              style: AppTextStyles.uniformRounded100Bold
                                  .copyWith(
                                      fontSize: 80.sp,
                                      color: const Color(0XFF212121)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status == ModelAssetHandlerStatus.downloading) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator.adaptive(
                      strokeCap: StrokeCap.round,
                    ),
                    Text(state.progressValue),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round),
              );
            }
          },
        ),
      ),
    );
  }
}
