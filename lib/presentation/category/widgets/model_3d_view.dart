import 'dart:io';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_ar/temp_testing/asset_download.dart';
// import 'package:flutter_ar/temp_testing/unityScene.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:size_config/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../core/util/device_type.dart';
import '../../../core/util/reusable_widgets/reusable_button.dart';
import '../../../core/util/styles.dart';
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

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url,
        mode: Platform.isAndroid
            ? LaunchMode.inAppBrowserView
            : LaunchMode.externalApplication,
        webOnlyWindowName: 'AR Mode',
        webViewConfiguration: const WebViewConfiguration(
            enableDomStorage: true, enableJavaScript: true))) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F2FE),
      body: ConnectionNotifierToggler(
        loading: const SizedBox.shrink(),
        disconnected: const NetworkDisconnected(),
        connected: BlocBuilder<ModelAssetHandlerBloc, ModelAssetHandlerState>(
          builder: (context, state) {
            if (state.status == ModelAssetHandlerStatus.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                    strokeCap: StrokeCap.round),
              );
            } else if (state.status == ModelAssetHandlerStatus.initial) {
              return Center(
                child: Text(
                  'Initializing...',
                  style: DeviceType().isMobile
                      ? AppTextStyles.nunito100w700black
                      : AppTextStyles.nunito100w700black.copyWith(
                          fontSize: DeviceType().isMobile
                              ? 110.sp
                              : 16 * MediaQuery.of(context).size.aspectRatio,
                        ),
                ),
              );
            } else if (state.status == ModelAssetHandlerStatus.error) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      'Error Downloading model',
                      style: DeviceType().isMobile
                          ? AppTextStyles.nunito100w700black
                          : AppTextStyles.nunito100w700black.copyWith(
                              fontSize: DeviceType().isMobile
                                  ? 110.sp
                                  : 16 *
                                      MediaQuery.of(context).size.aspectRatio,
                            ),
                    ),
                  ),
                  15.verticalSpacer,
                  ReusableButton(
                    buttonColor: AppColors.redMessageSharedFileContainerColor,
                    text: 'Retry',
                    textColor: Colors.white,
                    onPressed: () => context.read<ModelAssetHandlerBloc>().add(
                        RetryLoadModelAsset(modelName: widget.imageFileName)),
                  )
                ],
              );
            } else if (state.status == ModelAssetHandlerStatus.loaded) {
              var downloadCont = context
                  .read<ModelAssetHandlerBloc>()
                  .downloadAssetsController;
              return Padding(
                padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ModelViewer(
                        backgroundColor: const Color(0XFFF4F2FE),
                        src: Platform.isIOS
                            ? '${downloadCont.assetsDir}/${widget.imageFileName}.glb'
                            : 'file:///data/user/0/com.smartxr.kidsv2/app_flutter/assets/${widget.imageFileName}.glb',
                        ar: false,
                        autoPlay: true,
                        autoRotate: true,
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
                    // if (Platform.isIOS)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        //? IOS AR View
                        onTap: () => _launchUrl(Uri.parse(
                            "https://d3ag5oij4wsyi3.cloudfront.net/load_model/index.html?id=${widget.imageFileName}")),

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
                    25.verticalSpacer,
                    BlocBuilder<ModelAssetHandlerBloc, ModelAssetHandlerState>(
                      builder: (context, downloadingstate) {
                        return Text(
                          downloadingstate.progressValue,
                          style: DeviceType().isMobile
                              ? AppTextStyles.nunito100w700black
                              : AppTextStyles.nunito100w700black.copyWith(
                                  fontSize: DeviceType().isMobile
                                      ? 110.sp
                                      : 16 *
                                          MediaQuery.of(context)
                                              .size
                                              .aspectRatio,
                                ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
