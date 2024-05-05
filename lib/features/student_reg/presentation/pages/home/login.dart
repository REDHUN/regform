import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:regform/core/appconstants/appcolors.dart';
import 'package:regform/features/student_reg/presentation/pages/home/registration.dart';
import 'package:regform/features/student_reg/presentation/widgets/textfiled.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  login() async {
    http.Response data = await http
        .post(Uri.parse('https://reqres.in/api/login'), body: {
      'email': nameController.text,
      'password': passwordController.text
    });
    print(data.body);
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();

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
            onPressed: login,
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: AppColors.appBarColor),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Barlow',
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    formBuild(),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationPage()));
                          },
                          child: Text('No account create')),
                    ),
                  ],
                ),
              ),

              //Fom Widget
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: RegTextFiled(
                validator: (value) {
                  return value!.isEmpty ? 'pleaseEnterName' : null;
                },
                controller: nameController,
                hintText: "Student Name",
                icon: const Icon(Icons.person),
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
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
