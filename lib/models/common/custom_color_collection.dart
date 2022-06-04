import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminder_app/models/common/custom_color.dart';

class CustomColorCollection {
  final List<CustomColor> _colors = [
    CustomColor(id: 'blue_accent', color: Colors.blueAccent),
    CustomColor(id: 'orange_accent', color: Colors.orangeAccent),
    CustomColor(id: 'red_accent', color: Colors.redAccent),
    CustomColor(id: 'light_green', color: Colors.lightGreen),
    CustomColor(id: 'deep_orange', color: Colors.deepOrange),
    CustomColor(id: 'yellow_accent', color: Colors.yellow),
  ];
  UnmodifiableListView<CustomColor> get colors => UnmodifiableListView(_colors);

  CustomColor findColorById(id) {
    return _colors.firstWhere((customColor) => customColor.id == id);
  }
}
