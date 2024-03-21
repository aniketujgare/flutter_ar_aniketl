import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/models/student_profile_model.dart';
import '../main.dart';
import '../presentation/worksheet/models/published_worksheets.dart';
import 'package:http/http.dart' as http;

import '../presentation/worksheet/models/worksheet_details.dart';

class TestingClass extends StatefulWidget {
  const TestingClass({super.key});

  @override
  State<TestingClass> createState() => _TestingClassState();
}

class _TestingClassState extends State<TestingClass> {
  bool _isworksheetloaded = false;
  bool _isDetailsloaded = false;
  List<PublishedWorksheets> worksheetIds = [];
  List<List<WorksheetDetails>> workDetails = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  workDetails.clear();
                  setState(() {
                    _isworksheetloaded = false;
                  });

                  worksheetIds = await getPublishedWorksheet();
                  setState(() {
                    _isworksheetloaded = true;
                  });
                },
                child: const Text('Get worksheet stts'),
              ),
              if (!_isworksheetloaded) CircularProgressIndicator(),
              if (_isworksheetloaded)
                ...List.generate(
                    worksheetIds.length,
                    (index) =>
                        Text(worksheetIds[index].worksheetId.toString())),
            ],
          ),
          Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  workDetails.clear();
                  setState(() {
                    _isDetailsloaded = false;
                  });
                  for (var element in worksheetIds) {
                    var v = await getWorksheetDetails('${element.worksheetId}');
                    workDetails.add(v);
                  }

                  setState(() {
                    _isDetailsloaded = true;
                  });
                },
                child: const Text('Get worksheet stts'),
              ),
              if (!_isDetailsloaded) CircularProgressIndicator(),
              if (_isDetailsloaded)
                ...List.generate(workDetails.length,
                    (index) => Text(workDetails[index].first.status)),
            ],
          ),
        ],
      ),
    );
  }
}

Future<List<WorksheetDetails>> getWorksheetDetails(String worksheetId) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
    'POST',
    Uri.parse(
        'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getworksheetdetails'),
  );
  request.body = json.encode({"worksheet_id": worksheetId});
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      List<WorksheetDetails> worksheetDetails =
          worksheetDetailsFromJson(responseString);
      // debugPrint('worksheetDetails: ${json.encode(worksheetDetails)}');
      return worksheetDetails;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load worksheet details');
    }
  } catch (e) {
    debugPrint('Error during request: $e');
    throw Exception('Failed to load worksheet details');
  }
}

Future<List<PublishedWorksheets>> getPublishedWorksheet() async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
    'POST',
    Uri.parse(
        'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getpublishedworksheets'),
  );
  StudentProfileModel? studentProfile =
      await authenticationRepository.getStudentProfile();
  if (studentProfile?.studentId == -1) {
    return [];
  }
  // log(jsonEncode(studentProfile));
  request.body = json.encode({
    "standard_id": "${studentProfile!.standardId}",
    "division_id": "${studentProfile!.divisionId}"
  });
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final dynamic responseString = await response.stream.bytesToString();
      if (responseString == '0') {
        return []; // Return an empty list if no data exists
      }
      List<PublishedWorksheets> publishedworksheets =
          publishedworksheetsFromJson(responseString);
      return publishedworksheets;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load published worksheets');
    }
  } catch (e) {
    debugPrint('Error during request: $e');
    throw Exception('Failed to load published worksheets');
  }
}
