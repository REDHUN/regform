import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regform/features/student_reg/presentation/pages/home/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}
