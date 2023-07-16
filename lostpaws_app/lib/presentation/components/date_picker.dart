import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      shouldFillViewport: true,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronIcon: const Icon(
          Icons.chevron_left_rounded,
          color: ConstColors.mediumGreen,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right_rounded,
          color: ConstColors.mediumGreen,
        ),
        titleCentered: true,
        titleTextStyle: const LostPawsText().caption1SemiBold,
      ),
      calendarFormat: CalendarFormat.month,
      focusedDay: _focusedDay,
      firstDay: DateTime(2020),
      lastDay: DateTime.now(),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(selectedDay, _selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }

  String getSelectedDayString() {
    DateFormat formatter = DateFormat('dd MM, yyyy');

    return _selectedDay == null
        ? formatter.format(DateTime.now())
        : formatter.format(_selectedDay!);
  }
}
