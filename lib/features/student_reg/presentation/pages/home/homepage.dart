import 'package:flutter/material.dart';
import 'package:regform/features/student_reg/presentation/pages/home/desktop/registration_form_desktop.dart';
import 'package:regform/features/student_reg/presentation/pages/home/registration.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (p0) => const RegDesktop(),
      tablet: (p0) => const RegistrationPage(),
      mobile: (p0) => const RegistrationPage(),
    );
  }
}
