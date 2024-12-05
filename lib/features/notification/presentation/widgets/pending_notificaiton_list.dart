import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PendingNotificationList extends StatelessWidget {
  final List<PendingNotificationRequest> pendingNotifications;
  final Function(int) onCancel;

  const PendingNotificationList({
    super.key,
    required this.pendingNotifications,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return pendingNotifications.isEmpty
        ? const Center(child: Text('No Pending Notifications'))
        : ListView.builder(
            shrinkWrap: true, 
            itemCount: pendingNotifications.length,
            itemBuilder: (context, index) {
              final notification = pendingNotifications[index];

              return Card(
                child: ListTile(
                  title: Text(notification.title ?? 'No Title'),
                  subtitle: Text(notification.body ?? 'No Body'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onCancel(notification.id),
                  ),
                ),
              );
            },
          );
  }
}
