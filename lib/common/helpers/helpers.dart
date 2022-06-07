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

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      '$message',
      style: TextStyle(color: Theme.of(context).accentColor),
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Theme.of(context).cardColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
