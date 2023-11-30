import 'dart:convert';

import 'package:flutter_ar/model/ar_category.dart';
import 'package:flutter_ar/model/ar_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_ar/api/api_string.dart';

class API {
  var client = http.Client();

  Future<List<ArCategory>?> getCategories() async {
    var url = Uri.parse(APIString.categoryUrl);
    var response = await http.post(url);

    if (response.statusCode == 200) {
      // Assuming ArModel has a factory method fromJson
      var decodedBody = jsonDecode(response.body);
      // Use map to convert each JSON object to ArModel
      var arCategoryList = (decodedBody as List<dynamic>)
          .map((json) => ArCategory.fromJson(json))
          .toList();
      print('Response status: ${response.statusCode}');
      print('category len: ${arCategoryList.length}');
      return arCategoryList;
    } else {
      print('Failed to load categories. Status code: ${response.statusCode}');
    }
  }

  Future<List<ArModel>?> getModel(String category) async {
    var url = Uri.parse(APIString.modelUrl);
    // Convert the request body to a JSON string
    var requestBody = jsonEncode({"categoryid": category});

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        // "Access-Control-Allow-Origin":
        //     "https://d3ag5oij4wsyi3.cloudfront.net/kidsappmodel/models",
        // "Access-Control-Allow-Methods": "*",
        // "Access-Control-Allow-Headers": "X-Requested-With"
      },
      body: requestBody,
    );
    if (response.statusCode == 200) {
      // Assuming ArModel has a factory method fromJson
      var decodedBody = jsonDecode(response.body);
      // Use map to convert each JSON object to ArModel
      var modelsList = (decodedBody as List<dynamic>)
          .map((json) => ArModel.fromJson(json))
          .toList();
      print('Response status: ${response.statusCode}');
      print('Model property: ${modelsList.length}');
      return modelsList;
    } else {
      print('Failed to load categories. Status code: ${response.statusCode}');
    }
    // var res = jsonDecode(response.body);
  }
}
