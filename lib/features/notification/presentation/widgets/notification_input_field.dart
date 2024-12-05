import 'package:flutter/material.dart';

class NotificationInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const NotificationInputField({
    required this.controller,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
