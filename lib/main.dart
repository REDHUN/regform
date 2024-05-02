import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regform/features/student_reg/presentation/pages/home/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XFF7a00eb), //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
