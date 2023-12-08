// import 'package:flutter/material.dart';
// import 'package:flutter_ar/core/util/device_type.dart';
// import 'package:flutter_ar/core/util/styles.dart';
// import 'package:size_config/size_config.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         extendBody: true,
//         backgroundColor: AppColors.accentColor,
//         body: Padding(
//           padding: EdgeInsets.fromLTRB(
//               0, DeviceType().isMobile ? 100.h : 40.h, 0, 0),
//           child: Stack(
//             alignment: Alignment.center,
//             clipBehavior: Clip.none,
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Image.asset(
//                   'assets/images/Dog/dog01.png',
//                   height: 200.h,
//                 ),
//               ),
//               RotatedBox(
//                 quarterTurns: 4,
//                 child: ClipPath(
//                   clipper: CurvedTopRectangleClipper(),
//                   child: Container(
//                     color: AppColors.secondaryColor,
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 280.h),
//                           Text(
//                             'Welcome!',
//                             textAlign: TextAlign.center,
//                             style: DeviceType().isMobile
//                                 ? AppTextStyles.unitedRounded270w700
//                                 : AppTextStyles.unitedRounded140w700,
//                           ),
//                           SizedBox(height: 25.h),
//                           Text(
//                             'Enter your mobile number to login',
//                             textAlign: TextAlign.center,
//                             style: DeviceType().isMobile
//                                 ? AppTextStyles.nunito110w400white
//                                 : AppTextStyles.nunito56w400white,
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           const ReusableTextField(),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           SizedBox(
//                             width: 2000.w,
//                             height: 75.h,
//                             child: ReusableButton(
//                               buttonColor: AppColors.primaryColor,
//                               text: 'Send OTP',
//                               textColor: Colors.white,
//                               onPressed: () {},
//                             ),
//                           ),
//                           SizedBox(
//                             height: 70.h,
//                           ),
//                           Text(
//                             'or continue as guest ',
//                             textAlign: TextAlign.center,
//                             style: DeviceType().isMobile
//                                 ? AppTextStyles.nunito110w400white
//                                 : AppTextStyles.nunito56w400white,
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           SizedBox(
//                             width: 2000.w,
//                             height: 75.h,
//                             child: ReusableButton(
//                               text: 'Guest',
//                               buttonColor: AppColors.accentColor,
//                               textColor: AppColors.primaryColor,
//                               onPressed: () {},
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 140.h,
//                 child: Image.asset(
//                   'assets/images/Dog/dog03.png',
//                   height: 100.h,
//                   alignment: Alignment.topCenter,
//                 ),
//               ),
//               Positioned(
//                 top: 150.h,
//                 child: Image.asset(
//                   'assets/images/Dog/Paws.png',
//                   height: 100.h,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class ReusableButton extends StatelessWidget {
//   final String text;
//   final Color buttonColor;
//   final Color textColor;
//   final VoidCallback? onPressed;
//   const ReusableButton({
//     super.key,
//     required this.buttonColor,
//     required this.text,
//     required this.textColor,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(18))),
//           backgroundColor: buttonColor),
//       child: Text(
//         text,
//         style: DeviceType().isMobile
//             ? AppTextStyles.nunito120w700white.copyWith(color: textColor)
//             : AppTextStyles.nunito80w700white.copyWith(color: textColor),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// class ReusableTextField extends StatelessWidget {
//   const ReusableTextField({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 2000.w,
//       height: 75.h,
//       child: TextFormField(
//         keyboardType: TextInputType.phone,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//           contentPadding: const EdgeInsets.all(15),
//           filled: true,
//           fillColor: Colors.white,
//           prefixText: "+91",
//           prefixStyle: TextStyle(
//             color: Colors.black,
//             fontFamily: "Nunito",
//             fontWeight: FontWeight.w700,
//             fontSize: MediaQuery.of(context).size.width * 0.05,
//           ),
//         ),
//         style: AppTextStyles.nunito80w700white,
//       ),
//     );
//   }
// }

// class CurvedTopRectangleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path()
//       ..moveTo(0, DeviceType().isMobile ? 250.h : 350.h) // Move to top-left
//       ..quadraticBezierTo(
//           size.width / 2,
//           DeviceType().isMobile ? 70.h : 0,
//           size.width,
//           DeviceType().isMobile ? 250.h : 350.h) // Curve to top-right
//       ..lineTo(size.width, size.height) // Line to bottom-right
//       ..lineTo(0, size.height) // Line to bottom-left
//       ..close(); // Close the path

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
