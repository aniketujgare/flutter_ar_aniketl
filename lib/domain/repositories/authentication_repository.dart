import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar/core/route/route_name.dart';
import 'package:flutter_ar/core/util/api/api_string.dart';
import 'package:flutter_ar/data/models/app_api.dart';
import 'package:flutter_ar/data/models/ar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

import '../../presentation/login/bloc/login_bloc/login_bloc.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var client = http.Client();

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
    Uri url = Uri.parse(
        "https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/checkmobilenumberreturnschoolid");
    try {
      var response =
          await client.post(url, body: jsonEncode({"mobno": "91$mobileNo"}));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) == 1;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      return false;
    }
  }

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
