import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_ar/data/models/student_profile_model.dart';
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
part 'student_profile_state.dart';
part 'student_profile_cubit.freezed.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  StudentProfileCubit() : super(StudentProfileState.initial());

  Future<void> initProfile(StudentProfileModel? profile) async {
    if (profile != null && profile.studentId != -1) {
      var standAndDiv = await getStandardAndDivision(
          standardId: profile.standardId!, schoolId: profile.schoolId!);

      profile.grade = standAndDiv['grade'];
      profile.division = standAndDiv['division'];
      String schoolName = await getSchoolName(profile.schoolId!);
      profile.schoolName = schoolName;
      print('profile initialslize');
      emit(state.copyWith(
          status: StudentProfileStauts.loaded, studentProfileModel: profile));
    }
    emit(state.copyWith(
        status: StudentProfileStauts.loaded, studentProfileModel: profile));
  }

  Future<Map<String, String>> getStandardAndDivision(
      {required int standardId, required int schoolId}) async {
    var headers = {'Content-Type': 'application/json'};
    var body = {"standard_id": "$standardId", "school_id": "$schoolId"};

    try {
      var response = await http.post(
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getstandardanddivisions'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var jsonMap = jsonDecode(response.body);
        String grade = jsonMap[0].first;
        String division = (jsonMap.last as List<dynamic>).firstWhere(
            (element) => element[0] == 0,
            orElse: () => ['0', ''])[1];
        // print('Grade: $grade');
        // print('Division: $division');
        return {'grade': grade.split(' ').last, 'division': division};
      } else {
        print('Failed with status code: ${response.statusCode}');
        throw Exception(
            'Failed to get standard and division: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get standard and division: $e');
    }
  }

  Future<String> getSchoolName(int schoolId) async {
    var headers = {'Content-Type': 'application/json'};
    var body = {"school_id": "$schoolId"};

    try {
      var response = await http.post(
        Uri.parse(
            'https://cnpewunqs5.execute-api.ap-south-1.amazonaws.com/dev/getschooldetails'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var jsonMap = jsonDecode(response.body);
        String schoolName = jsonMap[0]['school_name'];

        print('school_name: $schoolName');
        return schoolName;
      } else {
        print('Failed with status code: ${response.statusCode}');
        throw Exception('Failed to get school name: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get school name: $e');
    }
  }
}
