import 'package:flutter/material.dart';
import 'package:rasidtasks/core/constants/defaults.dart';

class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  // final Color backgroundColor;
  final Color textColor;
  final bool isOutlined;
  final double borderRadius;

  const StyledButton({
    super.key,
    required this.label,
    required this.onPressed,
    // this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.isOutlined = false,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding16),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding16),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
