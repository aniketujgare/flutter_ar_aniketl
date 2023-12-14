import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFFF4F2FE),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Image.asset(
                'assets/ui/Group.png',
                // height: 45,
              ),
            ),
          ),
          title: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Text(
                widget.modelName,
                style: const TextStyle(fontSize: 18, color: Color(0XFF4F3A9C)),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            ModelViewer(
              backgroundColor: const Color(0XFFF4F2FE),
              src: widget.modelUrl,
              alt: 'A 3D model of an astronaut',
              ar: true,
              autoPlay: true,
              autoRotate: true,
              scale: '0.1 0.1 0.1',
              arPlacement: ArPlacement.floor,
              arModes: const ['scene-viewer'],
              iosSrc: widget.modelUrl,
              disableZoom: true,
            ),
            Positioned(
              bottom: 25,
              left: 15,
              child: SizedBox(
                  height: 40,
                  child: Image.asset(
                    'assets/ui/fi-br-volume 2.png',
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
