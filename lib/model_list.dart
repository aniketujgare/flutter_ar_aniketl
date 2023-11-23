// import 'package:flutter/material.dart';
// import 'package:flutter_ar/local_and_web_objects_view.dart';
// import 'package:flutter_ar/model_3d_view.dart';

// class ModelsList3D extends StatelessWidget {
//   const ModelsList3D({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const LocalAndWebObjectsView()));
//               },
//               child: const Text('AR Core')),
//         ),

//         //tiger
//         Expanded(
//           child: TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const ModelView(
//                       modelUrl: 'assets/g-man_rigged__animated.glb'modelName: ),
//                 ));
//               },
//               child: const Text('g-man')),
//         ),
//         Expanded(
//           child: TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const ModelView(
//                       // NeilArmstrong.glb
//                       modelUrl: 'assets/Untitled.obj'),
//                 ));
//               },
//               child: const Text('Neil Armstrong Model')),
//         ),
//       ],
//     );
//   }
// }
