import 'package:flutter/material.dart';

class NotificationActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NotificationActionButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.notifications),
      label: const Text('Schedule Notification'),
      onPressed: onPressed,
    );
  }
}
