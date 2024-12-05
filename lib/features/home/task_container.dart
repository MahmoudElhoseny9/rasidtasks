import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:rasidtasks/core/utils/colors.dart';

class TaskContainer extends StatelessWidget {
  final String taskName;
  final VoidCallback goToTask;

  const TaskContainer({
    super.key,
    required this.taskName,
    required this.goToTask,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToTask,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          width: double.infinity,
          child: AutoSizeText(
            taskName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
