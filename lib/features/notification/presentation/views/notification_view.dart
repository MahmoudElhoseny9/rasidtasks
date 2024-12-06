import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasidtasks/core/constants/defaults.dart';
import 'package:rasidtasks/core/constants/ghaps.dart';
import 'package:rasidtasks/features/notification/manager/cubit/notificatoin_cubit.dart';
import 'package:rasidtasks/features/notification/presentation/widgets/date_time_picker.dart';
import 'package:rasidtasks/features/notification/presentation/widgets/notification_input_field.dart';
import 'package:rasidtasks/features/notification/presentation/widgets/pending_notificaiton_list.dart';

import '../../manager/cubit/notificatoin_state.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notificationScreen';

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().init();
  }

  Future<void> scheduleNotification() async {
    final title = titleController.text.trim();
    final body = bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      showError('Title and Body are required.');
      return;
    }

    try {
      if (selectedDateTime != null) {
        await context
            .read<NotificationCubit>()
            .showScheduledNotification(title, body, selectedDateTime!);
      } else {
        await context
            .read<NotificationCubit>()
            .showInstantNotification(title, body);
      }

      resetFields();
      showSuccess('Notification scheduled successfully!');
    } catch (e) {
      showError('Failed to schedule notification.');
    }
  }

  void resetFields() {
    titleController.clear();
    bodyController.clear();
    setState(() {
      selectedDateTime = null;
    });
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.greenAccent,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            tooltip: 'Cancel All Notifications',
            onPressed: () async {
              await context.read<NotificationCubit>().cancelAllNotifications();
              showSuccess('All notifications cancelled.');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding16),
            child: Column(
              children: [
                NotificationInputField(
                    controller: titleController, label: 'Title'),
                gapH12,
                NotificationInputField(
                    controller: bodyController, label: 'Body'),
                gapH12,
                DateTimePicker(
                  selectedDateTime: selectedDateTime,
                  onDateTimeSelected: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                    });
                  },
                ),
                gapH20,
                BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    return state.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton.icon(
                            icon: const Icon(Icons.notifications),
                            label: const Text('Schedule Notification'),
                            onPressed: scheduleNotification,
                          );
                  },
                ),
                gapH20,
                BlocBuilder<NotificationCubit, NotificationState>(
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
                          showSuccess('Notification cancelled.');
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scheduleNotification,
        tooltip: 'Schedule Notification',
        child: const Icon(Icons.add),
      ),
    );
  }
}
