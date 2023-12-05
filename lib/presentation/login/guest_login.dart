// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:login_page/Login%20page%20Screens/otp_page.dart';
// import 'package:login_page/controller/auth_service.dart';
// import 'package:login_page/custom%20widgets/login_ui.dart';
// import 'package:http/http.dart' as http;
// import 'package:login_page/main%20screens/main_menu.dart';

// class GuestLoginPage extends StatefulWidget {
//   const GuestLoginPage({super.key});

//   @override
//   State<GuestLoginPage> createState() => _GuestLoginPageState();
// }

// class _GuestLoginPageState extends State<GuestLoginPage> {
//   final TextEditingController _guestNameController = TextEditingController();
//   final TextEditingController _guestPhoneController = TextEditingController();

//   final _guestNameKey = GlobalKey<FormState>();
//   final _guestPhoneKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       // backgroundColor: Colors.amber,
//       body: Stack(
//         //fit: StackFit.loose,
//         children: [
//           const LoginUiWidget(),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.45,
//             right: MediaQuery.of(context).size.width * 0.1,
//             // ignore: sized_box_for_whitespace
//             child: Container(
//               //color: Colors.amber,

//               width: MediaQuery.of(context).size.width * 0.8,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Welcome!",
//                     style: TextStyle(
//                         color: const Color.fromRGBO(79, 58, 156, 1),
//                         fontWeight: FontWeight.w700,
//                         fontSize: MediaQuery.of(context).size.width * 0.08,
//                         fontFamily: 'UniformRounded'),
//                   ),
//                   Text(
//                     "Enter your details to signup as guest  ",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "Nunito",
//                         fontWeight: FontWeight.w400,
//                         fontSize: MediaQuery.of(context).size.width * 0.052),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.width * 0.05,
//                   ),
//                   Form(
//                     key: _guestNameKey,
//                     child: TextFormField(
//                       controller: _guestNameController,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                         contentPadding: const EdgeInsets.all(15),
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: "Enter parents full name ",
//                         hintStyle: const TextStyle(color: Colors.grey),
//                         prefixStyle: TextStyle(
//                             color: Colors.black,
//                             fontFamily: "Nunito",
//                             fontWeight: FontWeight.w700,
//                             fontSize: MediaQuery.of(context).size.width * 0.05),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty)
//                           // ignore: curly_braces_in_flow_control_structures
//                           return "Enter Name";
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Form(
//                     key: _guestPhoneKey,
//                     child: TextFormField(
//                       controller: _guestPhoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                         contentPadding: const EdgeInsets.all(15),
//                         filled: true,
//                         fillColor: Colors.white,
//                         prefixText: "+91",
//                         hintText: "Enter Mobile no. ",
//                         hintStyle: const TextStyle(color: Colors.grey),
//                         prefixStyle: TextStyle(
//                             color: Colors.black,
//                             fontFamily: "Nunito",
//                             fontWeight: FontWeight.w700,
//                             fontSize: MediaQuery.of(context).size.width * 0.05),
//                       ),
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: "Nunito",
//                           fontWeight: FontWeight.w700,
//                           fontSize: MediaQuery.of(context).size.width * 0.05),
//                       validator: (value) {
//                         if (value!.length != 10)
//                           // ignore: curly_braces_in_flow_control_structures
//                           return "Invalid phone number";
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_guestNameKey.currentState!.validate() &&
//                           _guestPhoneKey.currentState!.validate())
//                         // ignore: curly_braces_in_flow_control_structures
//                         sendGuestDataToServer(context, "required");
//                     },
//                     style: ElevatedButton.styleFrom(
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(18))),
//                         backgroundColor: const Color.fromRGBO(79, 58, 156, 1)),
//                     child: Text(
//                       "Send OTP",
//                       style: TextStyle(
//                         fontFamily: "Nunito",
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         height: MediaQuery.of(context).size.width * 0.001,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   TextButton(
//                       onPressed: () {
//                         Get.to(MainMenu());
//                       },
//                       child: Text("Skip"))
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// // function to add the guest data to
//   void sendGuestDataToServer(BuildContext context, String section) async {
//     String guestName = _guestNameController.text;
//     String guestPhone = _guestPhoneController.text;

//     // if (guestName.length == 0 || guestPhone.length != 10) {
//     //   Get.snackbar(
//     //     "Enter Details ",
//     //     "Name or Phone number is invalid ",
//     //     snackPosition: SnackPosition.TOP,
//     //     //backgroundColor: Colors.green,
//     //   );
//     //   return;
//     // }
//     final response = await http.post(
//       Uri.parse(
//           'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/addguestuser'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(
//           {'guest_user_number': guestPhone, 'guest_user_name': guestName}),
//     );
//     if (response.statusCode == 200) {
//       Get.snackbar("guest Id created succesfully ", "success");
//       AuthService.sentOtp(
//           phone: "+91$guestPhone",
//           errorStep: () => Get.snackbar("Error", "Error in sending OTP"),
//           nextStep: () => Get.to(const OtpPage()));
//       //Get.to(OtpPage());
//     } else {
//       Get.snackbar(
//           "Error : ${response.statusCode} - ${response.body}", "unsuccessful");
//     }
//   }
// }

// //aspect ration 5/11
