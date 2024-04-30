import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:regform/core/appconstants/appcolors.dart';
import 'package:regform/core/model/allclass.dart';
import 'package:regform/core/model/student.dart';
import 'package:regform/features/student_reg/presentation/widgets/addressbox.dart';
import 'package:regform/features/student_reg/presentation/widgets/textfiled.dart';

int academicYearId = -1;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Future<List<Student>> getAcademicYear() async {
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

  Future<List<AllClass>> getClassCourse(String academicYearId) async {
    final client = http.Client();

    print(academicYearId);
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

  @override
  void initState() {
    getAcademicYear();
    super.initState();
  }

  var academicYear;
  var selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  height: MediaQuery.of(context).size.height - 80,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Text(
                              'Registration',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     color: Colors.deepPurple.withOpacity(0.3),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Text("Academic Year"),
                          //       Container(
                          //         child: DropdownButton(
                          //           items: data.map((e) {
                          //             return DropdownMenuItem(
                          //               child: Text(e['academicYear']),
                          //               value: e['acemicYearId'],
                          //             );
                          //           }).toList(),
                          //           value: _value,
                          //           onChanged: (v) {
                          //             _value = v as int;
                          //             setState(() {});
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          FutureBuilder<List<Student>>(
                            future: getAcademicYear(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton(
                                  // Initial Value
                                  value: academicYear,
                                  hint: Text('Select Academic Year'),
                                  isExpanded: true,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: snapshot.data!.map((item) {
                                    return DropdownMenuItem(
                                      value: item.academicYearId,
                                      child: Text(item.academicYear.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    academicYear = value;
                                    setState(() {});
                                  },
                                );
                              } else {
                                return Center(
                                    child: const CircularProgressIndicator());
                              }
                            },
                          ),

                          FutureBuilder<List<AllClass>>(
                            future: getClassCourse(academicYearId.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton(
                                  // Initial Value
                                  value: selectedClass,
                                  hint: Text('Select Class / Course'),
                                  isExpanded: true,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: snapshot.data!.map((item) {
                                    return DropdownMenuItem(
                                      value: item.courseTreeId,
                                      child: Text(item.course.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedClass = value;
                                    setState(() {});
                                  },
                                );
                              } else {
                                return Center(
                                    child: const CircularProgressIndicator());
                              }
                            },
                          ),

                          RegTextFiled(
                            hintText: "Student Name",
                            icon: Icon(Icons.person),
                          ),
                          RegTextFiled(
                            hintText: "Whatsapp Number",
                            icon: Icon(Icons.phone),
                          ),
                          RegTextFiled(
                            hintText: "Email",
                            icon: Icon(Icons.email),
                          ),
                          Addressbox(),
                          RegTextFiled(hintText: "Guardian Name"),
                          RegTextFiled(hintText: "Contact Number"),
                          Text(
                            "Student Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          RegTextFiled(hintText: 'User Name'),
                          RegTextFiled(hintText: 'Password'),
                          RegTextFiled(hintText: 'Conform Password'),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
