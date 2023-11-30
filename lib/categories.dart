// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_ar/api/api.dart';
// import 'package:flutter_ar/box_page_view.dart';
// import 'package:flutter_ar/category_page_view.dart';

// import 'package:flutter_ar/constants.dart';
// import 'package:flutter_ar/container_page_view.dart';
// import 'package:flutter_ar/model_3d_view.dart';

// import 'model/ar_category.dart';
// import 'model/ar_model.dart';

// class CategoriesView extends StatelessWidget {
//   final bool isMobile;
//   const CategoriesView({
//     Key? key,
//     required this.isMobile,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0XFFF4F2FE),
//         body: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: isMobile ? 110 / 4 : 110 / 2,
//               vertical: isMobile ? 0 : 40 / 2),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 100,
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: isMobile ? 75 : 120,
//                       height: isMobile ? 75 : 120,
//                       padding: const EdgeInsets.only(top: 20),
//                       child: GestureDetector(
//                         onTap: () async {
//                           await API().getCategories();
//                         },
//                         child: Image.asset(
//                           'assets/ui/image 40.png',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             left: isMobile ? 32 : 20,
//                             right: isMobile ? 32 : 20),
//                         child: SizedBox(
//                           width: 120,
//                           height: 120,
//                           child: Image.asset(
//                             'assets/ui/Group.png',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(child: SizedBox()
//                   // Padding(
//                   //     padding: EdgeInsets.symmetric(
//                   //         horizontal: 14 / 2, vertical: isMobile ? 14 : 54),
//                   //     child:
//                   //         // Column(
//                   //         //   chilßdren: [
//                   //         //     Expanded(
//                   //         //       child: Flex(
//                   //         //           direction: Axis.horizontal, // this is unique
//                   //         //           mainAxisAlignment: MainAxisAlignment.start,
//                   //         //           mainAxisSize: MainAxisSize.max,
//                   //         //           verticalDirection: VerticalDirection.down,
//                   //         //           crossAxisAlignment: CrossAxisAlignment.center,
//                   //         //           // verticalDirection: VerticalDirection.down,
//                   //         //           // textDirection: TextDirection.rtl,
//                   //         //           children: <Widget>[
//                   //         //             Expanded(
//                   //         //               flex: 1,
//                   //         //               child: Container(
//                   //         //                 padding: const EdgeInsets.all(8),
//                   //         //                 color: Colors.red,
//                   //         //                 // height: 55,
//                   //         //                 // width: 50,
//                   //         //               ),
//                   //         //             ),
//                   //         //             Expanded(
//                   //         //               flex: 1,
//                   //         //               child: Container(
//                   //         //                 padding: const EdgeInsets.all(8),
//                   //         //                 // height: 55,
//                   //         //                 // width: 50,
//                   //         //                 color: Colors.green,
//                   //         //               ),
//                   //         //             ),
//                   //         //             Expanded(
//                   //         //               child: Container(
//                   //         //                 padding: const EdgeInsets.all(8),
//                   //         //                 // height: 55,
//                   //         //                 // width: 50,
//                   //         //                 color: Colors.blue,
//                   //         //               ),
//                   //         //             ),
//                   //         //           ]),
//                   //         //     ),
//                   //         //     Expanded(
//                   //         //       child: Flex(
//                   //         //           direction: Axis.horizontal, // this is unique
//                   //         //           mainAxisAlignment: MainAxisAlignment.start,
//                   //         //           mainAxisSize: MainAxisSize.max,
//                   //         //           crossAxisAlignment: CrossAxisAlignment.center,
//                   //         //           // verticalDirection: VerticalDirection.down,
//                   //         //           // textDirection: TextDirection.rtl,
//                   //         //           children: <Widget>[
//                   //         //             Expanded(
//                   //         //               flex: 1,
//                   //         //               child: Container(
//                   //         //                 padding: const EdgeInsets.all(8),
//                   //         //                 // height: 55,
//                   //         //                 // width: 50,
//                   //         //                 color: Colors.green,
//                   //         //               ),
//                   //         //             ),
//                   //         //             Expanded(
//                   //         //               child: Container(
//                   //         //                 padding: const EdgeInsets.all(8),
//                   //         //                 // height: 55,
//                   //         //                 // width: 50,
//                   //         //                 color: Colors.blue,
//                   //         //               ),
//                   //         //             ),
//                   //         //             Expanded(
//                   //         //               flex: 1,
//                   //         //               child: Container(
//                   //         //                 padding: const EdgeInsets.all(8),
//                   //         //                 color: Colors.red,
//                   //         //                 // height: 55,
//                   //         //                 // width: 50,
//                   //         //               ),
//                   //         //             ),
//                   //         //           ]),
//                   //         //     ),
//                   //         //   ],
//                   //         // )
//                   //     //     FutureBuilder(
//                   //     //   future: API().getCategories(),
//                   //     //   builder: (context, snapshot) {
//                   //     //     if (snapshot.hasData) {
//                   //     //       var v = snapshot.data;
//                   //     //       return ContainerPageView(
//                   //     //         isMobile: isMobile,
//                   //     //         arModels: snapshot.data!,
//                   //     //       );
//                   //     //     }
//                   //     //     return Center(child: const CircularProgressIndicator());
//                   //     //   },
//                   //     // )
//                   //     // : GridView.builder(
//                   //     //     shrinkWrap: true,
//                   //     //     physics: const NeverScrollableScrollPhysics(),
//                   //     //     gridDelegate:
//                   //     //         const SliverGridDelegateWithFixedCrossAxisCount(
//                   //     //       crossAxisCount: 3,
//                   //     //       crossAxisSpacing: 28.0,
//                   //     //       mainAxisSpacing: 28.0,
//                   //     //       childAspectRatio: 443 / 371,
//                   //     //     ),
//                   //     //     itemCount: 6,
//                   //     //     itemBuilder: (BuildContext context, int index) {
//                   //     //       return RoundedBox(
//                   //     //         image: models[index]['image']!,
//                   //     //         name: models[index]['name']!,
//                   //     //         model: models[index]['model']!,
//                   //     //         isMobile: isMobile,
//                   //     //       );
//                   //     //     },
//                   //     //   ),
//                   //     ),
//                   ),
//               SizedBox(
//                 width: 100,
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         width: isMobile ? 75 : 120,
//                         height: isMobile ? 75 : 120,
//                         padding: const EdgeInsets.only(top: 20),
//                         child: GestureDetector(
//                           onTap: () async {
//                             await API().getModel();
//                           },
//                           child: Image.asset(
//                             'assets/ui/Custom Buttons.002 1.png',
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: RotatedBox(
//                         quarterTurns: 2,
//                         child: SizedBox(
//                           width: 120,
//                           height: 120,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: isMobile ? 32 : 20,
//                                 right: isMobile ? 32 : 20),
//                             child: Image.asset(
//                               'assets/ui/Group.png',
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RoundedBox extends StatelessWidget {
//   final String image;
//   final String name;
//   final String model;
//   final bool isMobile;
//   const RoundedBox({
//     super.key,
//     required this.image,
//     required this.name,
//     required this.model,
//     required this.isMobile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => ModelView(modelUrl: model, modelName: name),
//       )),
//       child: Container(
//         height: 155,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3), // changes the position of the shadow
//             ),
//           ],
//           gradient: const LinearGradient(
//             colors: [Colors.white, Color(0XFF4F3A9C)],
//             tileMode: TileMode.decal,
//             stops: [0.75, 0.25],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.circular(isMobile ? 20 : 40.0),
//           border: Border.all(
//             color: Colors.grey.shade100,
//             width: 0.5,
//           ),
//         ),
//         child: LayoutBuilder(builder: (context, constraints) {
//           return Column(
//             children: [
//               SizedBox(
//                 height: constraints.maxHeight * 0.75,
//                 child: Image.asset(
//                   image,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(
//                 height: constraints.maxHeight * 0.25,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     name,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: isMobile ? 18 : 24,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
