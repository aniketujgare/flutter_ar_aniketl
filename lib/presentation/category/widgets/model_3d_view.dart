import 'package:flutter/material.dart';
import 'package:flutter_ar/arkitdemo/custom_object_page.dart';
import 'package:flutter_ar/core/util/device_type.dart';
import 'package:flutter_ar/core/util/styles.dart';
import 'package:flutter_ar/presentation/ar_core/flutter_ar.dart';
import 'package:flutter_ar/presentation/category/widgets/ar_view_ios.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:size_config/size_config.dart';

class ModelView extends StatefulWidget {
  final String modelUrl;
  final String modelName;
  const ModelView({super.key, required this.modelUrl, required this.modelName});

  @override
  State<ModelView> createState() => _ModelViewState();
}

class _ModelViewState extends State<ModelView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFF4F2FE),
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: const Color(0XFFF4F2FE),
        //   centerTitle: true,
        //   leading: Padding(
        //     padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
        //     child: GestureDetector(
        //       onTap: () => Navigator.of(context).pop(),
        //       child: Image.asset(
        //         'assets/ui/Group.png',
        //         // height: 45,
        //       ),
        //     ),
        //   ),
        //   title: FittedBox(
        //     fit: BoxFit.contain,
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(15.0),
        //         border: Border.all(color: Colors.black, width: 2.0),
        //       ),
        //       child: Text(
        //         widget.modelName,
        //         style: const TextStyle(fontSize: 18, color: Color(0XFF4F3A9C)),
        //       ),
        //     ),
        //   ),
        // ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(116.w, 40.h, 116.w, 40.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ModelViewer(
                  backgroundColor: const Color(0XFFF4F2FE),
                  src: widget.modelUrl,
                  alt: 'A 3D model of an astronaut',
                  ar: false,
                  autoPlay: true,
                  autoRotate: true,
                  scale: '0.1 0.1 0.1',
                  arPlacement: ArPlacement.floor,
                  arModes: const ['scene-viewer'],
                  iosSrc: widget.modelUrl,
                  disableZoom: true,
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
              // if (!DeviceType().isMobile)
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  //? IOS AR View
                  // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>
                  //         FlutterAR(modelUrl: widget.modelUrl))),
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
    );
  }
}
