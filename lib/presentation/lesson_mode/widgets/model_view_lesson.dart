import 'dart:io';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter_ar/core/util/reusable_widgets/reusable_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../core/util/styles.dart';
// import 'package:flutter_ar/temp_testing/asset_download.dart';
// import 'package:flutter_ar/temp_testing/unityScene.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:size_config/size_config.dart';

import '../../category/bloc/model_asset_handler_bloc/model_asset_handler_bloc.dart';
import '../../category/widgets/ar_view_ios.dart';

class ModelViewLesson extends StatefulWidget {
  final String modelUrl;
  final String modelName;

  const ModelViewLesson({
    super.key,
    required this.modelUrl,
    required this.modelName,
  });

  @override
  State<ModelViewLesson> createState() => _ModelViewLessonState();
}

class _ModelViewLessonState extends State<ModelViewLesson> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFF4F2FE),
        body: ConnectionNotifierToggler(
          loading: const SizedBox.shrink(),
          disconnected: const NetworkDisconnected(),
          connected: Padding(
            padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ModelViewer(
                    backgroundColor: const Color(0XFFF4F2FE),
                    src: widget.modelUrl,
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
                // Align(
                //   alignment: Alignment.bottomLeft,
                //   child: SizedBox(
                //       height: 65.h,
                //       width: 65.h,
                //       child: Image.asset(
                //         'assets/ui/fi-br-volume 2.png',
                //         fit: BoxFit.cover,
                //       )),
                // ),
                // if (Platform.isIOS)
                //   Align(
                //     alignment: Alignment.bottomRight,
                //     child: GestureDetector(
                //       //? IOS AR View
                //       onTap: () {
                //         // Navigator.of(context).push(
                //         //   MaterialPageRoute(builder: (context) {
                //         //     return ARViewIOS(
                //         //       modelUrl: widget.modelUrl,
                //         //       imageFileName: widget.modelName,
                //         //     );
                //         //     // return ARViewIOS(modelUrl: widget.modelUrl);
                //         //   }),
                //         // );
                //       },
                //       child: SizedBox(
                //           height: 65.h,
                //           width: 65.h,
                //           child: CircleAvatar(
                //             radius: 30,
                //             backgroundColor: Colors.green,
                //             child: Padding(
                //               padding: EdgeInsets.all(13.h),
                //               child: Image.asset(
                //                 'assets/images/PNG Icons/AR Icon.png',
                //               ),
                //             ),
                //           )),
                //     ),
                //   ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: SizedBox(
                //     height: 65.h,
                //     width: 65.h,
                //     child: GestureDetector(
                //       onTap: () => Navigator.of(context).pop(),
                //       child: Image.asset(
                //         'assets/ui/Group.png',
                //         fit: BoxFit.scaleDown,
                //         // height: 45,
                //       ),
                //     ),
                //   ),
                // ),
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
                          '3D Model',
                          style: AppTextStyles.uniformRounded100Bold.copyWith(
                              fontSize: 80.sp, color: const Color(0XFF212121)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
