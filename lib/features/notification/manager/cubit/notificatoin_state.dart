

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationState {
  final List<PendingNotificationRequest> pendingNotifications;
  final bool isLoading;
  final String errorMessage;

  NotificationState({
    required this.pendingNotifications,
    required this.isLoading,
    required this.errorMessage,
  });

  NotificationState copyWith({
    List<PendingNotificationRequest>? pendingNotifications,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NotificationState(
      pendingNotifications: pendingNotifications ?? this.pendingNotifications,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
