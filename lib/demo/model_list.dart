// import 'package:flutter/material.dart';
// import 'package:flutter_ar/core/util/styles.dart';

// import '../presentation/category/widgets/model_3d_view.dart';

// class ModelsList3D extends StatelessWidget {
//   ModelsList3D({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           '3D Models .GLB',
//           style: AppTextStyles.uniformRounded100Bold,
//         ),
//         backgroundColor: AppColors.secondaryColor,
//       ),
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3, // Number of columns in each row
//           crossAxisSpacing: 8.0, // Spacing between columns
//           mainAxisSpacing: 8.0, // Spacing between rows
//         ),
//         itemCount: vehicles.length,
//         itemBuilder: (context, index) {
//           final vehicle = vehicles[index];
//           return Container(
//             color: AppColors.accentColor,
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 primary: Colors.purpleAccent,
//                 onSurface: Colors.grey, // Disable color
//               ),
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => ModelView(
//                     modelUrl: vehicle.first,
//                     modelName: vehicle.last,
//                   ),
//                 ));
//               },
//               child: Text(vehicle.last),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   final List<List<String>> vehicles = [
//     ['assets/vehicles/ambulance/ambulance.glb', 'ambulance'],
//     ['assets/vehicles/dump_truck/dump_truck.glb', 'dump_truck'],
//     ['assets/vehicles/Fighter_jett/Fighter_jett.glb', 'Fighter_jett'],
//     ['assets/vehicles/hatchback/hatchback.glb', 'hatchback'],
//     ['assets/vehicles/helicopters/helicopters.glb', 'helicopters'],
//     ['assets/vehicles/motorcycle/Motercycle.glb', 'Motercycle'],
//     ['assets/vehicles/Pickup_truck/pickup_truck.glb', 'pickup_truck'],
//     ['assets/vehicles/police_car/police_car.glb', 'police_car'],
//     ['assets/vehicles/Sportscar/Sportscar.glb', 'Sportscar'],
//     ['assets/vehicles/tram/tram.glb', 'tram'],
//   ];
// }
