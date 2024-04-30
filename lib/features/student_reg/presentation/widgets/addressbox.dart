import 'package:flutter/material.dart';

class Addressbox extends StatelessWidget {
  const Addressbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(12),
        height: 6 * 24.0,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          maxLines: 6,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Address',
            border: InputBorder.none,
          ),
        ));
  }
}