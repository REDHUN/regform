import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:regform/core/appconstants/app_constants.dart';
import 'package:regform/core/appconstants/appcolors.dart';
import 'package:regform/core/model/allclass.dart';
import 'package:regform/core/model/student.dart';
import 'package:regform/features/student_reg/presentation/widgets/addressbox.dart';
import 'package:regform/features/student_reg/presentation/widgets/dropdownbutton_builder.dart';
import 'package:regform/features/student_reg/presentation/widgets/textfiled.dart';

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

  //From Submit data

  submitDetails() async {
    if (_formKey.currentState!.validate() &&
        academicYear != -1 &&
        selectedClass != null) {
      try {
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
            "address": adresssNameController.text.toString(),
            "emailId": emailController.text,
            "mobileCode": "",
            "whatsappCode": "",
            "mobileNo": contactNumercontroller.text,
            "whatsappNo": whatsappNumberController.text,
            "image": "",
            "password": passwordController.text,
            "userType": "STUDENT",
            "academicYearId": academicYear.toString(),
            "createdBy": "",
            "modifiedBy": "",
            "userClassDetailsList": [
              {"userClassId": 0, "userId": "0", "classId": '${selectedClass}'}
            ],
            "areaofintrest": "Test Orell"
          }),
        );
        // print(response.body);
        // print(response.statusCode);

        if (response.statusCode == 200) {
          passwordController.clear();
          studentNameController.clear();
          whatsappNumberController.clear();
          emailController.clear();
          adresssNameController.clear();
          guardianNameController.clear();
          contactNumercontroller.clear();
          usenamecontroller.clear();
          passwordController.clear();
          conformPasswordcontroller.clear();
          adresssNameController.clear();
          setState(() {
            academicYear = null;
            selectedClass = null;
            academicYeardata == null;
            selectedClassdata = null;
          });

          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(20),
              content: Text('Registration Successfull'),
              backgroundColor: Colors.deepPurple,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 100.0, right: 10, left: 10),
            ),
          );
        }

        if (!context.mounted) {
          return;
        }
      } catch (e) {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration UnSucessfull'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          ),
        );
      }
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration UnSucessfull'),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      ));
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
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  BoxDecoration(color: AppColors.appBarColor),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 20),
                                child: Text(
                                  'Registration',
                                  style: TextStyle(
                                      fontFamily: 'Barlow',
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 20, top: 30),
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                'Academic Year',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Barlow'),
                              ),
                            ),
                            FutureBuilder<List<Student>>(
                              future: DropDownButtonBuilder.getAcademicYear(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: AppColors.textFiledColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        // Initial Value
                                        value: academicYear,
                                        hint: const Text(
                                          'Select Academic Year',
                                          style: TextStyle(
                                              fontFamily: 'Barlow',
                                              color: Colors.black),
                                        ),
                                        isExpanded: true,

                                        // Down Arrow Icon
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        iconSize: 30,

                                        elevation: 16,
                                        borderRadius: BorderRadius.circular(15),

                                        dropdownColor: Colors.white,

                                        padding: EdgeInsets.all(10),
                                        style: TextStyle(
                                            fontFamily: 'Barlow',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),

                                        // Down Arrow Icon

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
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: AppColors.textFiledColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        onChanged: (value) {},
                                        // Initial Value
                                        value: selectedClass,

                                        hint: const Text(
                                          'Select Class / Course',
                                          style:
                                              TextStyle(fontFamily: 'Barlow'),
                                        ),
                                        isExpanded: true,
                                        // Down Arrow Icon
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        iconSize: 30,

                                        //  elevation: 16,
                                        borderRadius: BorderRadius.circular(15),

                                        dropdownColor: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        style: TextStyle(
                                            fontFamily: 'Barlow',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),

                                        // Array list of items
                                        items: null,
                                      ),
                                    ),
                                  ));
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
                              future: DropDownButtonBuilder.getClassCourse(
                                  academicYearId.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: AppColors.textFiledColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        // Initial Value
                                        value: selectedClass,

                                        hint: const Text(
                                          'Select Class / Course',
                                          style:
                                              TextStyle(fontFamily: 'Barlow'),
                                        ),
                                        isExpanded: true,
                                        // Down Arrow Icon
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        iconSize: 30,

                                        //  elevation: 16,
                                        borderRadius: BorderRadius.circular(15),

                                        dropdownColor: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        style: TextStyle(
                                            fontFamily: 'Barlow',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),

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
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: AppColors.textFiledColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        onChanged: (value) {},
                                        // Initial Value
                                        value: selectedClass,

                                        hint: const Text(
                                          'Select Class / Course',
                                          style:
                                              TextStyle(fontFamily: 'Barlow'),
                                        ),
                                        isExpanded: true,
                                        // Down Arrow Icon
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        iconSize: 30,

                                        //  elevation: 16,
                                        borderRadius: BorderRadius.circular(15),

                                        dropdownColor: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        style: TextStyle(
                                            fontFamily: 'Barlow',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),

                                        // Array list of items
                                        items: null,
                                      ),
                                    ),
                                  ));
                                }
                              },
                            ),

                            //Fom Widget
                            formBuild()
                          ],
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

// Form Build

  formBuild() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                validator: (value) {
                  return value!.isEmpty ? 'pleaseEnterName' : null;
                },
                controller: studentNameController,
                hintText: "Student Name",
                icon: const Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
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
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                controller: emailController,
                // onChanged: (_) =>
                //     _formKey.currentState?.validate(),
                validator: (value) {
                  return value!.isEmpty
                      ? 'pleaseEnterEmailAddress'
                      : AppConstants.emailRegex.hasMatch(value)
                          ? null
                          : 'invalidEmailAddress';
                },
                hintText: "Email",
                icon: const Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                  color: AppColors.textFiledColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Container(
                    child: TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: pickImage,
                        child: const Text('Choose File')),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 230,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Barlow'),
                      imageChosenString,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Addressbox(
                controller: adresssNameController,
                validator: (value) {
                  return value!.isEmpty ? 'please Enter the address' : null;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                hintText: "Guardian Name",
                controller: guardianNameController,
                validator: (value) {
                  return value!.isEmpty ? 'please enter guardian name' : null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
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
            ),
            SizedBox(
              height: 5,
            ),
            const Text(
              "Student Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            RegTextFiled(
              validator: (value) {
                return value!.isEmpty ? "please enter the username" : null;
              },
              hintText: 'User Name',
              controller: usenamecontroller,
            ),
            SizedBox(
              height: 20,
            ),
            RegTextFiled(
              // onChanged: (_) =>
              //     _formKey.currentState?.validate(),
              validator: (value) {
                return value!.isEmpty ? "please enter the password" : null;
              },
              hintText: 'Password',
              obscureText: true,
              controller: passwordController,
            ),
            SizedBox(
              height: 20,
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
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
