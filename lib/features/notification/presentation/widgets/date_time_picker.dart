import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  final DateTime? selectedDateTime;
  final Function(DateTime) onDateTimeSelected;

  const DateTimePicker({
    super.key,
    this.selectedDateTime,
    required this.onDateTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );

        if (date != null) {
          final time = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          if (time != null) {
            onDateTimeSelected(DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            ));
          }
        }
      },
      child: Text(
        selectedDateTime == null
            ? 'Select Date & Time'
            : DateFormat('yyyy-MM-dd HH:mm')
                .format(selectedDateTime!), // DateFormat usage
      ),
    );
  }
}
