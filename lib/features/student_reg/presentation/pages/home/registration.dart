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

  late TextEditingController studentNameController = TextEditingController();
  late TextEditingController whatsappNumberController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController adresssNameController = TextEditingController();
  late TextEditingController guardianNameController = TextEditingController();
  late TextEditingController contactNumercontroller = TextEditingController();
  late TextEditingController usenamecontroller = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController conformPasswordcontroller =
      TextEditingController();

  String imageChosenString = 'No file chosen';
  var academicYear;
  var selectedClass;

  int academicYearId = -1;

  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image == null) return;
      imageChosenString = image.path.split('/').last;
    });
  }

  submitDetails() async {
    if (_formKey.currentState!.validate() &&
        academicYear != -1 &&
        selectedClass != null) {
      try {
        final url = Uri.https(
            'llabdemo.orell.com', 'api/userService/anonymous/saveUser');

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

        if (response.statusCode == 200) {
          print(response.body);
          // passwordController.clear();
          // studentNameController.clear();
          // whatsappNumberController.clear();
          // emailController.clear();
          // adresssNameController.clear();
          // guardianNameController.clear();
          // contactNumercontroller.clear();
          // usenamecontroller.clear();
          // passwordController.clear();
          // conformPasswordcontroller.clear();
          // adresssNameController.clear();
          setState(() {
            academicYear = null;
            selectedClass = null;
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
            margin: EdgeInsets.only(bottom: 30.0, right: 10, left: 10),
          ),
        );
      }
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration UnSucessfull'),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 30.0, right: 10, left: 10),
      ));
    }
  }

  @override
  void initState() {
    //initializeControllers();

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 60,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: submitDetails,
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: AppColors.appBarColor),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                  margin: const EdgeInsets.only(left: 15, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Academic Year',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Barlow'),
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
                                  fontFamily: 'Barlow', color: Colors.black),
                            ),
                            isExpanded: true,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,

                            elevation: 16,
                            borderRadius: BorderRadius.circular(15),

                            dropdownColor: Colors.white,

                            padding: const EdgeInsets.all(10),
                            style: const TextStyle(
                                fontFamily: 'Barlow',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),

                            // Down Arrow Icon

                            // Array list of items
                            items: snapshot.data!.map((item) {
                              return DropdownMenuItem(
                                value: item.academicYearId,
                                child: Text(item.academicYear.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              academicYear = value;

                              setState(() {
                                Student data = snapshot.data!.firstWhere(
                                    (element) =>
                                        element.academicYearId == value);
                                academicYearId = data.academicYearId!;
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
                              'Unable fetch data !!',
                              style: TextStyle(fontFamily: 'Barlow'),
                            ),
                            isExpanded: true,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,

                            //  elevation: 16,
                            borderRadius: BorderRadius.circular(15),

                            dropdownColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            style: const TextStyle(
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
                  margin: const EdgeInsets.symmetric(horizontal: 15),
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
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            color: AppColors.textFiledColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            // Initial Value
                            value: selectedClass,

                            hint: const Text(
                              'Select Class / Course',
                              style: TextStyle(fontFamily: 'Barlow'),
                            ),
                            isExpanded: true,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,

                            //  elevation: 16,
                            borderRadius: BorderRadius.circular(15),

                            dropdownColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            style: const TextStyle(
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

                              setState(() {});
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
                              'Unable to fetch data',
                              style: TextStyle(fontFamily: 'Barlow'),
                            ),
                            isExpanded: true,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,

                            //  elevation: 16,
                            borderRadius: BorderRadius.circular(15),

                            dropdownColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            style: const TextStyle(
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
                formBuild(),

                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

// Form Build

  formBuild() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
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
            const SizedBox(
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
                inputType: TextInputType.number,
                hintText: "Whatsapp Number",
                icon: const Icon(Icons.phone),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                controller: emailController,
                inputType: TextInputType.emailAddress,
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
            const SizedBox(
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
                  TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: pickImage,
                      child: const Text('Choose File')),
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
            const SizedBox(
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
            const SizedBox(
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                hintText: "Contact Number",
                inputType: TextInputType.phone,
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
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Student Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                validator: (value) {
                  return value!.isEmpty ? "please enter the username" : null;
                },
                hintText: 'User Name',
                controller: usenamecontroller,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                validator: (value) {
                  return value!.isEmpty ? "please enter the password" : null;
                },
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
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
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
