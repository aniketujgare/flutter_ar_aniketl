import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';

// class CameraFeature extends StatefulWidget {
//   const CameraFeature({Key? key}) : super(key: key);

//   @override
//   State<CameraFeature> createState() => _CameraFeatureState();
// }

// class _CameraFeatureState extends State<CameraFeature> {
//   late List<CameraDescription> cameras;

//   @override
//   void initState() {
//     initaCamers();
//     super.initState();
//   }

//   initaCamers() async {
//     cameras = await MaskForCameraView.initialize();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaskForCameraView(
//       visiblePopButton: false,
//       // insideLine: MaskForCameraViewInsideLine(
//       //   position: MaskForCameraViewInsideLinePosition.endPartThree,
//       //   direction: MaskForCameraViewInsideLineDirection.horizontal,
//       // ),
//       // boxBorderWidth: 2.6,
//       boxHeight: 500,
//       boxWidth: 1920,
//       // [cameras.first] is rear camera.
//       cameraDescription: cameras.first,
//       onTake: (MaskForCameraViewResult? res) => res != null
//           ? showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               backgroundColor: Colors.transparent,
//               builder: (context) => Container(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 12.0, horizontal: 14.0),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(26.0),
//                     topRight: Radius.circular(26.0),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       "Cropped Images",
//                       style: TextStyle(
//                         fontSize: 24.0,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 12.0),
//                     res.croppedImage != null
//                         ? Container(
//                             height: 200,
//                             child: MyImageView(imageBytes: res.croppedImage!))
//                         : Container(),
//                     const SizedBox(height: 8.0),
//                     Container(
//                       height: 200,
//                       child: Row(
//                         children: [
//                           res.firstPartImage != null
//                               ? Expanded(
//                                   child: MyImageView(
//                                       imageBytes: res.firstPartImage!))
//                               : Container(),
//                           res.firstPartImage != null &&
//                                   res.secondPartImage != null
//                               ? const SizedBox(width: 8.0)
//                               : Container(),
//                           res.secondPartImage != null
//                               ? Expanded(
//                                   child: MyImageView(
//                                       imageBytes: res.secondPartImage!))
//                               : Container(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : {},
//     );
//   }
// }

// class MyImageView extends StatelessWidget {
//   const MyImageView({Key? key, required this.imageBytes}) : super(key: key);
//   final Uint8List imageBytes;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(4.0),
//       child: SizedBox(
//         width: double.infinity,
//         height: 200,
//         child: Image.memory(
//           imageBytes,
//           fit: BoxFit.fitHeight,
//         ),
//       ),
//     );
//   }
// }
class CameraFeature extends StatefulWidget {
  const CameraFeature({super.key});

  @override
  CameraFeatureState createState() => CameraFeatureState();
}

class CameraFeatureState extends State<CameraFeature> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      // cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      debugPrint("NO any camera found");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future _cropImage(XFile imageFile) async {
    final double cropWidth =
        MediaQuery.of(context).size.width * 0.7; // 80% of screen width
    final double cropHeight =
        MediaQuery.of(context).size.height * 0.1; // 50% of screen height
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(
        ratioX: cropWidth,
        ratioY: cropHeight,
      ),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: "Resize text in rectangle",
          showCropGrid: false,
          hideBottomControls: true,
        )
      ],
    );
    if (croppedFile != null) {
      debugPrint('image cropped');
      File image = File(croppedFile.path);
      //Todo: Add API for sending image to backend
      debugPrint(croppedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(children: [
      SizedBox(
          child: controller == null
              ? const Center(child: Text("Loading Camera..."))
              : !controller!.value.isInitialized
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CameraPreview(controller!)),
      Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton.icon(
          //image capture button
          onPressed: () async {
            try {
              if (controller != null) {
                controller!.setFlashMode(FlashMode.off);
                //check if contrller is not null
                if (controller!.value.isInitialized) {
                  //check if controller is initialized
                  image = await controller!.takePicture(); //capture image
                  if (image != null) {
                    _cropImage(image!);
                  }
                  setState(() {
                    //update UI
                  });
                }
              }
            } catch (e) {
              debugPrint(e.toString()); //show error
            }
          },
          icon: const Icon(Icons.camera),
          label: const Text("Capture"),
        ),
      ),
      Transform.translate(
        offset: Offset(0, -size.height * 0.08),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width * 0.6,
            height: size.height * 0.1,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white)),
          ),
        ),
      )
    ]);
  }
}
