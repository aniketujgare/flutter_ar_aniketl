// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../main screens/settings screen /settings_groups.dart';
// import '../main screens/settings screen /settings_home.dart';
// import '../main screens/settings screen /settings_reports.dart';

// class SettingBottomBar extends StatefulWidget {
//   const SettingBottomBar({super.key});

//   @override
//   State<SettingBottomBar> createState() => _SettingBottomBarState();
// }

// class _SettingBottomBarState extends State<SettingBottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Get.to(SettingsGroup());
//           },
//           child: Image.asset(
//             'assets/images/PNG Icons/groups.png',
//             height: MediaQuery.of(context).size.height * 0.09,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Get.to(SettingHome());
//           },
//           child: Image.asset(
//             'assets/images/PNG Icons/home.png',
//             height: MediaQuery.of(context).size.height * 0.09,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Get.to(SettingsReport());
//           },
//           child: Image.asset(
//             'assets/images/PNG Icons/reports.png',
//             height: MediaQuery.of(context).size.height * 0.09,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Image.asset(
//             'assets/images/PNG Icons/settings.png',
//             height: MediaQuery.of(context).size.height * 0.09,
//           ),
//         ),
//       ],
//     );
//   }
// }
