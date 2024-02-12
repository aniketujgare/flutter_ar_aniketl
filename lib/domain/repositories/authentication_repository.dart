import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/route/route_name.dart';
import '../../core/util/api/api_string.dart';
import '../../data/models/app_api.dart';
import '../../data/models/ar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

import '../../data/models/student_profile_model.dart';
import '../../presentation/login/bloc/login_bloc/login_bloc.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var client = http.Client();
  final String baseUrl =
      'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev';
  Future<Map<String, ApiEndpointModel>> getAllApis() async {
    Uri uri = Uri.parse(APIString.baseApi);
    try {
      var response = await client.post(uri);
      if (response.statusCode == 200) {
        Map<String, ApiEndpointModel> appApi =
            apiEndpointModelFromJson(response.body);

        //  Map<String, String> g = {};
        // appApi.forEach((key, value) {
        //   g.putIfAbsent(value.key, () => value.value);
        // });

        return appApi;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception('Failed to load APIs. Error: $e');
    }
  }

  Future<bool> checkMobNoExists(String mobileNo) async {
    Uri url = Uri.parse("$baseUrl/checkmobilenumberreturnschoolid");
    try {
      var response =
          await client.post(url, body: jsonEncode({"mobno": "91$mobileNo"}));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) != "null";
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      return false;
    }
  }

  //!
  Future<void> saveDataToHive(String mobileNo) async {
    int parentId = await getParentId(mobileNo);
    if (parentId != -1) {
      await saveStudentProfiles(parentId);
    } else {
      await saveStudentProfilesGuest(parentId);
    }
  }

  Future<void> saveStudentProfiles(int parentId) async {
    try {
      var studentProfileBox =
          await Hive.openBox<StudentProfileModel>('student_profile');

      Uri url = Uri.parse("$baseUrl/getstudentprofilesnew");
      var response =
          await client.post(url, body: jsonEncode({"parent_id": "$parentId"}));

      if (response.statusCode == 200) {
        var allProfiles = studentProfileModelFromJson(response.body);
        if (allProfiles.isNotEmpty && allProfiles[0].isNotEmpty) {
          studentProfileBox.clear();
          studentProfileBox.add(allProfiles[0][0]);
          log(jsonEncode(allProfiles[0][0]));
          print('Data saved successfully.');
        } else {
          throw Exception('Empty profiles received');
        }
      } else {
        throw Exception(
            'Failed to load profiles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getStudentProfiles: $e');
    }
  }

  Future<void> saveStudentProfilesGuest(int parentId) async {
    try {
      var studentProfileBox =
          await Hive.openBox<StudentProfileModel>('student_profile');

      studentProfileBox.add(StudentProfileModel(studentId: -1));
    } catch (e) {
      print('Error in getStudentProfiles: $e');
    }
  }

  Future<int> getParentId(String mobileNo) async {
    Uri url = Uri.parse("$baseUrl/getparentid");
    try {
      var response =
          await client.post(url, body: jsonEncode({"mobno": "91$mobileNo"}));
      if (response.statusCode == 200) {
        var parentId = jsonDecode(response.body);
        if (parentId == "null") {
          return -1;
        }
        print(parentId);
        return parentId;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load parentId');
      }
    } catch (e) {
      // Handle errors here
      print('Error in getParentId: $e');
      // You might want to rethrow the exception or return a default value here
      throw Exception('Failed to get parentId');
    }
  }

  Future<StudentProfileModel?> getStudentProfile() async {
    try {
      var studentProfileBox =
          await Hive.openBox<StudentProfileModel>('student_profile');
      var profiles = studentProfileBox.values.toList();

      if (profiles.isNotEmpty) {
        log('Retrieved profile: ${jsonEncode(profiles.first)}');
        return profiles.first;
      } else {
        print('No profiles found in the box.');
        return null; // Returning null if no profiles are found
      }
    } catch (e) {
      print('Error in getStudentProfile: $e');
      return null;
    }
  }

  //!
  // Future<void> getallstandardsofschool() async {
  //   Uri url = Uri.parse("$baseUrl/getallstandardsofschool");
  //   try {
  //     var response =
  //         await client.post(url, body: jsonEncode({"school_id": "0"}));
  //     if (response.statusCode == 200) {
  //       var decodedBody = jsonDecode(response.body);
  //       var kidsAppBox = await Hive.openBox("kidsApp");
  //       kidsAppBox.put('allStandardsOfSchool', decodedBody);
  //       print(kidsAppBox.get('allStandardsOfSchool'));
  //     } else {
  //       // If the server did not return a 200 OK response,
  //       // then throw an exception.
  //       throw Exception('Failed to load album');
  //     }
  //   } catch (e) {}
  // }

  // Future<void> getstudentprofilesnew() async {
  //   Uri url = Uri.parse("$baseUrl/getstudentprofilesnew");
  //   try {
  //     var kidsAppBox = await Hive.openBox("kidsApp");
  //     var studentProfileBox =
  //         await Hive.openBox<StudentProfileModel>('student_profile');
  //     var response = await client.post(url,
  //         body: jsonEncode({"parent_id": "${kidsAppBox.get('parentId')}"}));
  //     if (response.statusCode == 200) {
  //       var decodedBody = jsonDecode(response.body);

  //       // studentProfileBox.add(studentProfileModelFromJson(response.body));
  //       print(kidsAppBox.get('studentProfiles'));
  //     } else {
  //       // If the server did not return a 200 OK response,
  //       // then throw an exception.
  //       throw Exception('Failed to load album');
  //     }
  //   } catch (e) {}
  // }

  Future<void> sendGuestDataToServer(
      {required String guestName, required String guestPhone}) async {
    final response = await http.post(
      Uri.parse(
          'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/addguestuser'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'guest_user_number': guestPhone, 'guest_user_name': guestName}),
    );
    if (response.statusCode == 200) {
      print("guest Id created succesfully ");
    } else {
      print("Error : ${response.statusCode} - ${response.body}");
    }
  }
}
