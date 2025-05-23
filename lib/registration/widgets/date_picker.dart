
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DatePickerWidget extends StatefulWidget {
  DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String label;

  DatePickerWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.label,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: widget.selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() {
            widget.selectedDate = date;
          });
          widget.onDateSelected(date);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedDate != null
                  ? '${widget.selectedDate!.day}/${widget.selectedDate!.month}/${widget.selectedDate!.year}'
                  : widget.label,
              style: TextStyle(
                color:
                    widget.selectedDate != null
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Icon(
              Icons.calendar_month,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
