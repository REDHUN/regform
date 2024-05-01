import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:regform/core/appconstants/app_constants.dart';
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
  final _formKey = GlobalKey<FormState>();

  late TextEditingController studentNameController;
  late TextEditingController whatsappNumberController;
  late TextEditingController emailController;
  late TextEditingController adresssNameController;
  late TextEditingController guardianNameController;
  late TextEditingController contactNumercontroller;
  late TextEditingController usenamecontroller;
  late TextEditingController passwordController;
  late TextEditingController conformPasswordcontroller;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  String imageChosenString = 'No file chosen';
  var academicYear;
  var selectedClass;
  var academicYeardata;
  var selectedClassdata;

  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image == null) return;
      imageChosenString = image.path.split('/').last;
    });
  }

  void submitDetails() async {
    if (_formKey.currentState!.validate()) {}
    final url = Uri.https(
        'schooloo-2e036-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "userId": "0",
        "institutionId": 32,
        "name": studentNameController.text.toString(),
        "userCode": "${usenamecontroller.text.toString()}.orell1",
        "address": "ORELL SOFTWARE SOLUTIONS PVT LTD\nBCG TOWER 1ST FLOOR",
        "emailId": emailController.text,
        "mobileCode": "",
        "whatsappCode": "",
        "mobileNo": contactNumercontroller.text,
        "whatsappNo": whatsappNumberController.text,
        "image": "",
        "password": passwordController.text,
        "userType": "STUDENT",
        "academicYearId": academicYear,
        "createdBy": "",
        "modifiedBy": "",
        "userClassDetailsList": [
          {"userClassId": 0, "userId": "0", "classId": '${selectedClass}'}
        ],
        "areaofintrest": "Test Orell"
      }),
    );
    print(response.body);
    print(response.statusCode);

    final Map<String, dynamic> resData = json.decode(response.body);

    if (!context.mounted) {
      return;
    }
  }

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
    // print(academicYearId);
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

  void initializeControllers() {
    studentNameController = TextEditingController()
      ..addListener(controllerListener);
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    conformPasswordcontroller = TextEditingController()
      ..addListener(controllerListener);
    whatsappNumberController = TextEditingController()
      ..addListener(controllerListener);
    contactNumercontroller = TextEditingController()
      ..addListener(controllerListener);
    adresssNameController = TextEditingController()
      ..addListener(controllerListener);
    guardianNameController = TextEditingController()
      ..addListener(controllerListener);
    usenamecontroller = TextEditingController()
      ..addListener(controllerListener);
  }

  void controllerListener() {
    final name = studentNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = studentNameController.text;

    if (name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty)
      return;
    else {
      fieldValidNotifier.value = true;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    studentNameController.dispose();
    whatsappNumberController.dispose();
    emailController.dispose();
    adresssNameController.dispose();
    guardianNameController.dispose();
    usenamecontroller.dispose();
    passwordController.dispose();
    conformPasswordcontroller.dispose();
    contactNumercontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(
          child: ListView(
            children: [
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      height: MediaQuery.of(context).size.height - 100,
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.manual,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: Text(
                                  'Registration',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  'Academic Year',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              FutureBuilder<List<Student>>(
                                future: getAcademicYear(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: DropdownButton(
                                        // Initial Value
                                        value: academicYear,
                                        hint: Text('Select Academic Year'),
                                        isExpanded: true,
                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),

                                        // Array list of items
                                        items: snapshot.data!.map((item) {
                                          return DropdownMenuItem(
                                            value: item.academicYearId,
                                            child: Text(
                                                item.academicYear.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          academicYear = value;
                                          setState(() {
                                            Student selectedAcademicYear =
                                                snapshot.data!.firstWhere(
                                              (element) =>
                                                  element.academicYearId ==
                                                  value,
                                              orElse: () =>
                                                  snapshot.data!.first,
                                            );
                                            academicYeardata =
                                                selectedAcademicYear
                                                    .academicYear;
                                          });
                                        },
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  'Class/Semester',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              FutureBuilder<List<AllClass>>(
                                future:
                                    getClassCourse(academicYearId.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: DropdownButton(
                                        // Initial Value
                                        value: selectedClass,
                                        hint:
                                            const Text('Select Class / Course'),
                                        isExpanded: true,
                                        // Down Arrow Icon
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),

                                        // Array list of items
                                        items: snapshot.data!.map((item) {
                                          return DropdownMenuItem(
                                            value: item.courseTreeId,
                                            child: Text(item.course.toString()),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          selectedClass = value;
                                          setState(() {
                                            AllClass selectedClassItem =
                                                snapshot.data!.firstWhere(
                                              (element) =>
                                                  element.courseTreeId == value,
                                              orElse: () =>
                                                  snapshot.data!.first,
                                            );
                                            selectedClassdata =
                                                selectedClassItem.course;
                                          });
                                        },
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      RegTextFiled(
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? 'pleaseEnterName'
                                              : null;
                                        },
                                        controller: studentNameController,
                                        hintText: "Student Name",
                                        icon: Icon(Icons.person),
                                      ),
                                      RegTextFiled(
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? 'please enter whatsapp number'
                                              : value.length != 10
                                                  ? "Invalid  whatsapp number"
                                                  : null;
                                        },
                                        controller: whatsappNumberController,
                                        hintText: "Whatsapp Number",
                                        icon: Icon(Icons.phone),
                                      ),
                                      RegTextFiled(
                                        // onChanged: (_) =>
                                        //     _formKey.currentState?.validate(),
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? 'pleaseEnterEmailAddress'
                                              : AppConstants.emailRegex
                                                      .hasMatch(value)
                                                  ? null
                                                  : 'invalidEmailAddress';
                                        },
                                        hintText: "Email",
                                        icon: const Icon(Icons.email),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: TextButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors.white)),
                                                  onPressed: pickImage,
                                                  child: const Text(
                                                      'Choose File')),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  230,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text(
                                                imageChosenString,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Addressbox(
                                        controller: adresssNameController,
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? 'please Enter the address'
                                              : null;
                                        },
                                      ),
                                      RegTextFiled(
                                        hintText: "Guardian Name",
                                        controller: guardianNameController,
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? 'please enter guardian name'
                                              : null;
                                        },
                                      ),
                                      RegTextFiled(
                                        hintText: "Contact Number",
                                        controller: contactNumercontroller,
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? 'please enter contact number'
                                              : value.length != 10
                                                  ? "Invalid phone number"
                                                  : null;
                                        },
                                      ),
                                      const Text(
                                        "Student Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      RegTextFiled(
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? "please enter the username"
                                              : null;
                                        },
                                        hintText: 'User Name',
                                        controller: usenamecontroller,
                                      ),
                                      RegTextFiled(
                                        // onChanged: (_) =>
                                        //     _formKey.currentState?.validate(),
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? "please enter the password"
                                              : null;
                                        },
                                        hintText: 'Password',
                                        obscureText: true,
                                        controller: passwordController,
                                      ),
                                      RegTextFiled(
                                        obscureText: true,
                                        // onChanged: (_) =>
                                        //     _formKey.currentState?.validate(),
                                        validator: (value) {
                                          return value!.isEmpty
                                              ? "pleaseEnterPassword"
                                              : value == passwordController.text
                                                  ? null
                                                  : 'please enter the matching password';
                                        },
                                        hintText: 'Conform Password',
                                        controller: conformPasswordcontroller,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ValueListenableBuilder(
                    //   valueListenable: fieldValidNotifier,
                    //   builder: (_, isValid, __) {
                    //     return FilledButton(
                    //       onPressed: isValid
                    //           ? () {
                    //               print('Registration Complete');
                    //               studentNameController.clear();
                    //               emailController.clear();
                    //               passwordController.clear();
                    //               conformPasswordcontroller.clear();
                    //               whatsappNumberController.clear();
                    //               guardianNameController.clear();
                    //               usenamecontroller.clear();
                    //               contactNumercontroller.clear();
                    //             }
                    //           : null,
                    //       child: const Text("Register"),
                    //     );
                    //   },
                    // ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: submitDetails,
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
