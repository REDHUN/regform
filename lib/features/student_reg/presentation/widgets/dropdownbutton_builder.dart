import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:regform/core/model/allclass.dart';
import 'package:regform/core/model/student.dart';

int academicYearId = -1;

class DropDownButtonBuilder {
  static Future<List<Student>> getAcademicYear() async {
    final client = http.Client();
    try {
      final respose = await client.get(Uri.parse(
          'https://llabdemo.orell.com/api/masters/anonymous/getAcademicYear/32'));
      final data = jsonDecode(respose.body) as List;
      if (respose.statusCode == 200) {
        Map<String, dynamic> firstItem = data.first;
        int id = firstItem['academicYearId'];
        academicYearId = id;

        getClassCourse(id.toString());
        return data.map((dynamic json) {
          final map = json as Map<String, dynamic>;

          return Student(
              academicYearId: map['academicYearId'],
              academicYear: map['academicYear']);
        }).toList();

        // final List<Student> posts =
        //     resposeBody.map((json) => Student.fromJson(json)).toList();

        // return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('');
    }
  }

  static Future<List<AllClass>> getClassCourse(String academicYearId) async {
    try {
      final respose = await post(
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
        },
        Uri.parse(
            'https://llabdemo.orell.com/api/masters/anonymous/getAllClassList'),
        body: jsonEncode({
          "institutionId": "32", // Convert to string
          "academicYearId": academicYearId
        }),
      );
      final data = jsonDecode(respose.body) as List;

      if (respose.statusCode == 200) {
        return data.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return AllClass(
              course: map['course'], courseTreeId: map['courseTreeId']);
        }).toList();

        // final List<Student> posts =
        //     resposeBody.map((json) => Student.fromJson(json)).toList();

        // return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('');
    }
  }
}
