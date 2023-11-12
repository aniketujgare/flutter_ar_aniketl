import 'package:flutter/material.dart';
import 'package:flutter_ar/local_and_web_objects_view.dart';
import 'package:flutter_ar/model_3d_view.dart';

class ModelsList3D extends StatelessWidget {
  const ModelsList3D({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LocalAndWebObjectsView()));
              },
              child: const Text('AR Core')),
        ),

        //tiger
        Expanded(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ModelView(
                      modelUrl:
                          'https://modelviewer.dev/shared-assets/models/Astronaut.glb'),
                ));
              },
              child: const Text('Astronaut Model')),
        ),
        Expanded(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ModelView(
                      // NeilArmstrong.glb
                      modelUrl:
                          'https://modelviewer.dev/shared-assets/models/NeilArmstrong.glb'),
                ));
              },
              child: const Text('Neil Armstrong Model')),
        ),
      ],
    );
  }
}
