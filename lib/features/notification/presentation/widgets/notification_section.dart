import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasidtasks/features/notification/manager/cubit/notificatoin_cubit.dart';
import 'package:rasidtasks/features/notification/presentation/widgets/pending_notificaiton_list.dart';
import '../../manager/cubit/notificatoin_state.dart';

class PendingNotificationListSection extends StatelessWidget {
  const PendingNotificationListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state.pendingNotifications.isEmpty) {
          return const Center(
            child: Text('No pending notifications.'),
          );
        } else {
          return PendingNotificationList(
            pendingNotifications: state.pendingNotifications,
            onCancel: (id) async {
              await context
                  .read<NotificationCubit>()
                  .cancelNotification(id);
            },
          );
        }
      },
    );
  }
}
