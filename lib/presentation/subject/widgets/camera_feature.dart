import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';

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
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future _cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 50, ratioY: 9),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: "Resize text in rectangle",
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          showCropGrid: false,
          hideBottomControls: true,
        )
      ],
    );
    if (croppedFile != null) {
      print('image cropped');
      File image = File(croppedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
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
              print(e); //show error
            }
          },
          icon: const Icon(Icons.camera),
          label: const Text("Capture"),
        ),
      ),
      // Container(
      //   //show captured image
      //   padding: const EdgeInsets.all(30),
      //   child: image == null
      //       ? const Text("No image captured")
      //       : Image.file(
      //           File(image!.path),
      //           height: 300,
      //         ),
      //   //display captured image
      // )
    ]);
  }
}
