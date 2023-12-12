import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import 'package:flutter_ar/presentation/login/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import 'core/route/go_router_provider.dart';
import 'core/util/device_type.dart';
import 'core/util/styles.dart';
import 'firebase_options.dart';
import 'presentation/category/bloc/category_cubit/category_cubit.dart';
import 'presentation/category/bloc/category_page_cubit/category_page_cubit.dart';
import 'presentation/category/bloc/model_page_controler_cubit/models_page_controller_cubit.dart';
import 'presentation/category/bloc/models_cubit/models_cubit.dart';

final authenticationRepository = AuthenticationRepository();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);
  if (Platform.isAndroid) {
    // Include Android-specific AR code
    print('Platform.isAndroid');
  } else if (Platform.isIOS) {
    // Include iOS-specific AR code
    print('Platform.isIOS');
  } else {
    // Handle other platforms or provide a message
    print('AR functionality not supported on this platform.');
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  static const String _title = 'AR Plugin Demo';

  // @override
  // void initState() {
  //   super.initState();
  //   initPlatformState();
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     platformVersion = await ArFlutterPlugin.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    DeviceType();
    AppStyles();
    return SizeConfigInit(
      referenceHeight: 1179,
      referenceWidth: 2556,
      builder: (BuildContext context, Orientation orientation) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CategoryCubit()..loadCategory(),
            ),
            BlocProvider(
              create: (context) => CategoryPageCubit(),
            ),
            BlocProvider(
              create: (context) => ModelsPageControllerCubit(),
            ),
            BlocProvider(
              create: (context) => ModelsCubit(),
            ),
            BlocProvider(
              create: (context) => LoginBloc(authenticationRepository),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: GoRouterProvider().goRouter(),
          ),
        );
      },
    );
  }
}

// import 'arkitdemo/body_tracking_page.dart';
// import 'arkitdemo/camera_position_scene.dart';
// import 'arkitdemo/check_support_page.dart';
// import 'arkitdemo/custom_animation_page.dart';
// import 'arkitdemo/custom_object_page.dart';
// import 'arkitdemo/load_gltf_or_glb_page.dart';
// import 'arkitdemo/distance_tracking_page.dart';
// import 'arkitdemo/custom_light_page.dart';
// import 'arkitdemo/earth_page.dart';
// import 'arkitdemo/hello_world.dart';
// import 'arkitdemo/image_detection_page.dart';
// import 'arkitdemo/light_estimate_page.dart';
// import 'arkitdemo/manipulation_page.dart';
// import 'arkitdemo/measure_page.dart';
// import 'arkitdemo/midas_page.dart';
// import 'arkitdemo/network_image_detection.dart';
// import 'arkitdemo/occlusion_page.dart';
// import 'arkitdemo/physics_page.dart';
// import 'arkitdemo/plane_detection_page.dart';
// import 'arkitdemo/tap_page.dart';
// import 'arkitdemo/face_detection_page.dart';
// import 'arkitdemo/panorama_page.dart';
// import 'arkitdemo/real_time_updates.dart';
// import 'package:flutter/material.dart';

// import 'arkitdemo/network_image_detection.dart';

// void main() => runApp(MaterialApp(home: MyApp()));

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final samples = [
//       Sample(
//         'Hello World',
//         'The simplest scene with all geometries.',
//         Icons.home,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => HelloWorldPage())),
//       ),
//       Sample(
//         'Check configuration',
//         'Shows which kinds of AR configuration are supported on the device',
//         Icons.settings,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => CheckSupportPage())),
//       ),
//       Sample(
//         'Earth',
//         'Sphere with an image texture and rotation animation.',
//         Icons.language,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => EarthPage())),
//       ),
//       Sample(
//         'Tap',
//         'Sphere which handles tap event.',
//         Icons.touch_app,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => TapPage())),
//       ),
//       Sample(
//         'Midas',
//         'Turns walls, floor, and Earth itself into gold by tap.',
//         Icons.touch_app,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => MidasPage())),
//       ),
//       Sample(
//         'Plane Detection',
//         'Detects horizontal plane.',
//         Icons.blur_on,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => PlaneDetectionPage())),
//       ),
//       Sample(
//         'Distance tracking',
//         'Detects horizontal plane and track distance on it.',
//         Icons.blur_on,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => DistanceTrackingPage())),
//       ),
//       Sample(
//         'Measure',
//         'Measures distances',
//         Icons.linear_scale,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => MeasurePage())),
//       ),
//       Sample(
//         'Physics',
//         'A sphere and a plane with dynamic and static physics',
//         Icons.file_download,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => PhysicsPage())),
//       ),
//       Sample(
//         'Image Detection',
//         'Detects Earth photo and puts a 3D object near it.',
//         Icons.collections,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => ImageDetectionPage())),
//       ),
//       Sample(
//         'Network Image Detection',
//         'Detects Mars photo and puts a 3D object near it.',
//         Icons.collections,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => NetworkImageDetectionPage())),
//       ),
//       Sample(
//         'Custom Light',
//         'Hello World scene with a custom light spot.',
//         Icons.lightbulb_outline,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => CustomLightPage())),
//       ),
//       Sample(
//         'Light Estimation',
//         'Estimates and applies the light around you.',
//         Icons.brightness_6,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => LightEstimatePage())),
//       ),
//       Sample(
//         'Custom Object',
//         'Place custom object on plane with coaching overlay.',
//         Icons.nature,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => CustomObjectPage())),
//       ),
//       Sample(
//         'Load .gltf or .glb',
//         'Load .gltf or .glb from the Flutter assets or the Documents folder',
//         Icons.folder_copy,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => LoadGltfOrGlbFilePage())),
//       ),
//       Sample(
//         'Occlusion',
//         'Spheres which are not visible after horizontal and vertical planes.',
//         Icons.blur_circular,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => OcclusionPage())),
//       ),
//       Sample(
//         'Manipulation',
//         'Custom objects with pinch and rotation events.',
//         Icons.threed_rotation,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => ManipulationPage())),
//       ),
//       Sample(
//         'Face Tracking',
//         'Face mask sample.',
//         Icons.face,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => FaceDetectionPage())),
//       ),
//       Sample(
//         'Body Tracking',
//         'Dash that follows your hand.',
//         Icons.person,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => BodyTrackingPage())),
//       ),
//       Sample(
//         'Panorama',
//         '360 photo sample.',
//         Icons.panorama,
//         () => Navigator.of(context)
//             .push<void>(MaterialPageRoute(builder: (c) => PanoramaPage())),
//       ),
//       // Sample(
//       //   'Video',
//       //   '360 video sample.',
//       //   Icons.videocam,
//       //   () => Navigator.of(context)
//       //       .push<void>(MaterialPageRoute(builder: (c) => VideoPage())),
//       // ),
//       Sample(
//         'Custom Animation',
//         'Custom object animation. Port of https://github.com/eh3rrera/ARKitAnimation',
//         Icons.accessibility_new,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => CustomAnimationPage())),
//       ),
//       // Sample(
//       //   'Widget Projection',
//       //   'Flutter widgets in AR',
//       //   Icons.widgets,
//       //   () => Navigator.of(context).push<void>(
//       //       MaterialPageRoute(builder: (c) => WidgetProjectionPage())),
//       // ),
//       Sample(
//         'Real Time Updates',
//         'Calls a function once per frame',
//         Icons.timer,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => RealTimeUpdatesPage())),
//       ),
//       // Sample(
//       //   'Snapshot',
//       //   'Make a photo of AR content',
//       //   Icons.camera,
//       //   () => Navigator.of(context)
//       //       .push<void>(MaterialPageRoute(builder: (c) => SnapshotScenePage())),
//       // ),
//       Sample(
//         'Camera position',
//         'Get position of the camera in AR scene',
//         Icons.location_on,
//         () => Navigator.of(context).push<void>(
//             MaterialPageRoute(builder: (c) => CameraPositionScenePage())),
//       ),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ARKit Demo'),
//       ),
//       body:
//           ListView(children: samples.map((s) => SampleItem(item: s)).toList()),
//     );
//   }
// }

// class SampleItem extends StatelessWidget {
//   const SampleItem({
//     required this.item,
//     Key? key,
//   }) : super(key: key);
//   final Sample item;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () => item.onTap(),
//         child: ListTile(
//           leading: Icon(item.icon),
//           title: Text(
//             item.title,
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           subtitle: Text(
//             item.description,
//             style: Theme.of(context).textTheme.titleSmall,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Sample {
//   const Sample(this.title, this.description, this.icon, this.onTap);
//   final String title;
//   final String description;
//   final IconData icon;
//   final Function onTap;
// }
