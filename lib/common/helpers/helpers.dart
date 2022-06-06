import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(int dateFromMillisecondsSinceEpoch) {
  return DateFormat.yMMMd()
      .format(
          DateTime.fromMillisecondsSinceEpoch(dateFromMillisecondsSinceEpoch))
      .toString();
}

String formatTime(BuildContext context, int hour, int minutes) {
  return TimeOfDay(hour: hour, minute: minutes).format(context).toString();
}
