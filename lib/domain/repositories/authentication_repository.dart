import 'dart:async';
import 'dart:convert';
import 'package:flutter_ar/core/util/api/api_string.dart';
import 'package:flutter_ar/data/models/app_api.dart';
import 'package:flutter_ar/data/models/ar_model.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
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

  Future<bool> checkMobNoExists() async {
    Uri url = Uri.parse(
        "https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/checkmobilenumberreturnschoolid");
    try {
      var response =
          await client.post(url, body: jsonEncode({"mobno": "919665445556"}));
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
}
