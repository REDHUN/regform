import 'package:flutter/material.dart';
import 'package:regform/core/appconstants/appcolors.dart';

class Addressbox extends StatelessWidget {
  final TextEditingController? controller;

  final String? Function(String?)? validator;
  const Addressbox({super.key, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(12),
        height: 6 * 20.0,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.textFiledColor,
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          validator: validator,
          maxLines: 6,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            label: Text(
              'Addresss',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Barlow'),
            ),
            border: InputBorder.none,
          ),
        ));
  }
}
