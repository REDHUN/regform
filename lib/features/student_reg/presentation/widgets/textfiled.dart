import 'package:flutter/material.dart';

class RegTextFiled extends StatelessWidget {
  const RegTextFiled(
      {super.key,
      this.onChanged,
      this.validator,
      this.controller,
      required this.hintText,
      this.icon,
      this.obscureText});

  final String hintText;
  final Icon? icon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(hintText),
          icon: icon,
          border: InputBorder.none,
        ),
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
