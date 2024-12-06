import 'package:flutter/material.dart';
import 'package:rasidtasks/core/constants/defaults.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextDirection textDirection;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.textDirection = TextDirection.ltr,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textDirection: textDirection,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
