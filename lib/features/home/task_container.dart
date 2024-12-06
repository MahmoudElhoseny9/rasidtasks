import 'package:flutter/material.dart';
import 'package:rasidtasks/core/constants/defaults.dart';
import 'package:rasidtasks/core/constants/ghaps.dart';
import 'package:rasidtasks/theme/app_colors.dart';

class TaskContainer extends StatelessWidget {
  final String taskName;
  final VoidCallback goToTask;
  final IconData iconData;

  const TaskContainer({
    super.key,
    required this.taskName,
    required this.goToTask,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToTask,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
          ),
          elevation: AppDefaults.elevation,
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(AppDefaults.padding16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.blueAccent, AppColors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDefaults.padding16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    color: AppColors.purpleAccent,
                  ),
                ),
                gapW16,
                Expanded(
                  child: Text(
                    taskName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteText,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black26,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
