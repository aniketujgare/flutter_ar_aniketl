// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   static String verifyId = "";
//   //to send and Otp to user
//   static Future sentOtp(
//       {required String phone,
//       required Function errorStep,
//       required Function nextStep}) async {
//     return await _firebaseAuth
//         .verifyPhoneNumber(
//             timeout: const Duration(seconds: 120),
//             phoneNumber: phone,
//             // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//             verificationCompleted: (PhoneAuthCredential) async {
//               return;
//             },
//             verificationFailed: (error) async {
//               return;
//             },
//             codeSent: (verificationId, forceResendingToken) async {
//               verifyId = verificationId;
//               nextStep();
//             },
//             codeAutoRetrievalTimeout: (verificationId) async {
//               return;
//             })
//         .onError((error, stackTrace) {
//       errorStep();
//     });
//   }

//   //function to verify code and login
//   static Future loginWithOtp({required String otp}) async {
//     final cred =
//         PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
//     try {
//       final user = await _firebaseAuth.signInWithCredential(cred);
//       if (user.user != null) {
//         return "success";
//       } else {
//         return "error in otp login ";
//       }
//     } on FirebaseAuthException catch (e) {
//       return e.message.toString();
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   //funtion to logout the user
//   static Future logout() async {
//     await _firebaseAuth.signOut();
//   }

//   // check if the user is logged in or not
//   static Future<bool> isLoggedIn() async {
//     var user = _firebaseAuth.currentUser;
//     return user != null;
//   }
// }
