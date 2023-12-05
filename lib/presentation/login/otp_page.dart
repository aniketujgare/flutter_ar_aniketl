// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:login_page/controller/auth_service.dart';
// import 'package:login_page/custom%20widgets/login_ui.dart';
// import 'package:login_page/main%20screens/home_screen.dart';
// import 'package:pinput/pinput.dart';

// class OtpPage extends StatefulWidget {
//   const OtpPage({super.key});

//   @override
//   State<OtpPage> createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   //final TextEditingController _otpController = TextEditingController();
//   final TextEditingController _pinController = TextEditingController();
//   final _otpKey = GlobalKey<FormState>();
//   // final _pinKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );

//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       color: Colors.white,
//       border: Border.all(color: const Color.fromRGBO(248, 248, 248, 1)),
//       borderRadius: BorderRadius.circular(20),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: const Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );

//     return Scaffold(
//         // backgroundColor: Colors.amber,
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           //fit: StackFit.loose,
//           children: [
//             const LoginUiWidget(),
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.45,
//               right: MediaQuery.of(context).size.width * 0.1,
//               // ignore: sized_box_for_whitespace
//               child: Container(
//                 //color: Colors.amber,
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Welcome!",
//                       style: TextStyle(
//                           color: const Color.fromRGBO(79, 58, 156, 1),
//                           fontWeight: FontWeight.w700,
//                           fontSize: MediaQuery.of(context).size.width * 0.08,
//                           fontFamily: 'UniformRounded'),
//                     ),
//                     Text(
//                       "Enter the OTP :  ",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "Nunito",
//                         fontWeight: FontWeight.w700,
//                         fontSize: MediaQuery.of(context).size.width * 0.04,
//                       ),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                     Form(
//                       key: _otpKey,
//                       child: Pinput(
//                         controller: _pinController,
//                         length: 6,
//                         defaultPinTheme: defaultPinTheme,
//                         focusedPinTheme: focusedPinTheme,
//                         submittedPinTheme: submittedPinTheme,
//                         validator: (value) {
//                           if (value!.length != 6)
//                             // ignore: curly_braces_in_flow_control_structures
//                             return "Invalid OTP";
//                           return null;
//                         },
//                         pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                         showCursor: true,
//                         // ignore: avoid_print
//                         onCompleted: (pin) => print(pin),
//                       ),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                     // Form(
//                     //   key: _otpKey,
//                     //   child: TextFormField(
//                     //     controller: _otpController,
//                     //     keyboardType: TextInputType.text,
//                     //     decoration: InputDecoration(
//                     //       border: OutlineInputBorder(
//                     //           borderRadius: BorderRadius.circular(30)),
//                     //       contentPadding: const EdgeInsets.all(15),
//                     //       filled: true,
//                     //       fillColor: Colors.white,
//                     //       hintStyle: const TextStyle(color: Colors.grey),
//                     //       prefixStyle: const TextStyle(
//                     //           color: Colors.black,
//                     //           fontFamily: "Nunito",
//                     //           fontWeight: FontWeight.w700,
//                     //           fontSize: 20),
//                     //     ),
//                     //     validator: (value) {
//                     //       if (value!.length != 6) return "Invalid OTP";
//                     //       return null;
//                     //     },
//                     //   ),
//                     // ),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_otpKey.currentState!.validate()) {
//                           AuthService.loginWithOtp(otp: _pinController.text)
//                               .then((value) {
//                             if (value == "success") {
//                               Get.to(const HomeScreen());
//                             } else {
//                               Get.snackbar(
//                                   "Error ", "Please check the OTP entered. ");
//                             }
//                           });
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(18))),
//                         backgroundColor: const Color.fromRGBO(69, 195, 117, 1),
//                       ),
//                       child: Text(
//                         "Submit",
//                         style: TextStyle(
//                           fontFamily: "Nunito",
//                           fontSize: MediaQuery.of(context).size.width * 0.04,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                           height: MediaQuery.of(context).size.width * 0.002,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     OutlinedButton(
//                         onPressed: () {
//                           Get.to(const HomeScreen());
//                         },
//                         child: const Text("Home Screen "))
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }

//   // void OnLoginSuccess(BuildContext context) {
//   //   SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
//   //       .then((_) {
//   //     Get.to(HomeScreen());
//   //   });
//   // }
// }

// //aspect ration 5/11