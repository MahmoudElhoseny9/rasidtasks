import 'package:flutter/material.dart';
import 'package:rasidtasks/core/constants/defaults.dart';

void showCustomDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

void showCustomBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDefaults.borderRadius)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: AppDefaults.padding24,
            left: AppDefaults.padding24,
            right: AppDefaults.padding24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: widget,
        );
      });
}
