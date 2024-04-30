import 'package:flutter/material.dart';

class RegTextFiled extends StatelessWidget {
  const RegTextFiled({
    super.key,
    required this.hintText,
    this.icon,
  });

  final String hintText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          icon: icon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
