import 'package:flutter/material.dart';
import 'package:regform/core/appconstants/appcolors.dart';

class RegTextFiled extends StatelessWidget {
  const RegTextFiled(
      {super.key,
      this.onChanged,
      this.inputType,
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
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          color: AppColors.textFiledColor,
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            hintText,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Barlow'),
          ),
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
