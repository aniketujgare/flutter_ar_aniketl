// import 'dart:convert';
// import 'dart:developer';

// import 'package:hive_flutter/adapters.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart' show debugPrint;

// import '../data/models/student_profile_model.dart';

// class HiveTesting {
//   var client = http.Client();
//   final String baseUrl =
//       'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev';

//   Future<void> saveDataToHive() async {
//     int parentId = await getParentId('8698671748');
//     getStudentProfiles(parentId);
//   }

//   Future<void> getStudentProfiles(int parentId) async {
//     try {
//       var studentProfileBox =
//           await Hive.openBox<StudentProfileModel>('student_profile');

//       Uri url = Uri.parse("$baseUrl/getstudentprofilesnew");
//       var response =
//           await client.post(url, body: jsonEncode({"parent_id": "$parentId"}));

//       if (response.statusCode == 200) {
//         var allProfiles = studentProfileModelFromJson(response.body);
//         if (allProfiles.isNotEmpty && allProfiles[0].isNotEmpty) {
//           studentProfileBox.add(allProfiles[0][0]);
//           debugPrint('Data saved successfully.');
//         } else {
//           throw Exception('Empty profiles received');
//         }
//       } else {
//         throw Exception(
//             'Failed to load profiles. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error in getStudentProfiles: $e');
//     }
//   }

//   Future<int> getParentId(String mobileNo) async {
//     Uri url = Uri.parse("$baseUrl/getparentid");
//     try {
//       var response =
//           await client.post(url, body: jsonEncode({"mobno": "91$mobileNo"}));
//       if (response.statusCode == 200) {
//         int parentId = jsonDecode(response.body);

//         return parentId;
//       } else {
//         // If the server did not return a 200 OK response,
//         // then throw an exception.
//         throw Exception('Failed to load parentId');
//       }
//     } catch (e) {
//       // Handle errors here
//       debugPrint('Error in getParentId: $e');
//       // You might want to rethrow the exception or return a default value here
//       throw Exception('Failed to get parentId');
//     }
//   }

//   Future<StudentProfileModel?> getStudentProfile() async {
//     try {
//       var studentProfileBox =
//           await Hive.openBox<StudentProfileModel>('student_profile');
//       var profiles = studentProfileBox.values.toList();

//       if (profiles.isNotEmpty) {
//         log('Retrieved profile: ${jsonEncode(profiles.first)}');
//         return profiles.first;
//       } else {
//         debugPrint('No profiles found in the box.');
//         return null; // Returning null if no profiles are found
//       }
//     } catch (e) {
//       debugPrint('Error in getStudentProfile: $e');
//       return null;
//     }
//   }
// }
