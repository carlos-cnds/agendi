import 'package:flutter/material.dart';

class TimeSelection {
  static Future<TimeOfDay?> getTime(
      {required BuildContext context, required String initialTime}) async {
    int hour = 0;
    int minute = 0;
    if (initialTime.isNotEmpty) {
      var splt = initialTime.split(':');
      hour = int.parse(splt[0]);
      minute = int.parse(splt[1]);
    }

    TimeOfDay? range = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: hour, minute: minute));
    return range;
  }
}
