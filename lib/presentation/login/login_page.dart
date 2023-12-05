import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom widgets/login_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.amber,
      body: Stack(
        //fit: StackFit.loose,
        children: [
          const LoginUiWidget(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            right: MediaQuery.of(context).size.width * 0.1,
            // ignore: sized_box_for_whitespace
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              //padding: EdgeInsets.all(10.0),
              //color: Colors.amber,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.,
                children: [
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        color: const Color.fromRGBO(79, 58, 156, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontFamily: 'UniformRounded'),
                  ),
                  Text(
                    "Enter your mobile number to login ",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.052,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _userPhoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        contentPadding: const EdgeInsets.all(15),
                        filled: true,
                        fillColor: Colors.white,
                        prefixText: "+91",
                        prefixStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // getUserDataFromServer(context, "required");
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        backgroundColor: const Color.fromRGBO(79, 58, 156, 1)),
                    child: Text(
                      "Send OTP",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: MediaQuery.of(context).size.width * 0.002,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    "or continue as guest ",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        backgroundColor: Colors.white),
                    child: Text(
                      "Guest",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(79, 58, 156, 1),
                        height: MediaQuery.of(context).size.width * 0.001,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void getUserDataFromServer(BuildContext context, String section) async {
  //   String userPhone = _userPhoneController.text;

  //   if (userPhone.isEmpty) {
  //     Get.snackbar(
  //       " Incorrect Details  ",
  //       "Mobile Number is invalid  ",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  //   final response = await http.post(
  //     Uri.parse(
  //         'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/checkmobilenumberreturnschoolid'),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({"mobno": "91$userPhone"}),
  //   );
  //   if (response.body != '"null"') {
  //     //Get.snackbar("Phone number exist  ", "success");
  //     AuthService.sentOtp(
  //         phone: "+91$userPhone",
  //         errorStep: () => Get.snackbar("Error", "Error in sending OTP"),
  //         nextStep: () => Get.to(const OtpPage()));

  //     //Get.to(OtpPage());
  //   } else {
  //     Get.snackbar(
  //       "Unsuccessful", "User does not exist",
  //       // "Error : ${response.statusCode} - ${response.body}",
  //       // "unsuccessful"
  //     );
  //   }
  // }
}




//aspect ration 5/11

//   "mobno": "919665445556"
