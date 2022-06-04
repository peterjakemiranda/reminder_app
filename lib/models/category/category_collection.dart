import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/category_icon.dart';
import 'category.dart';

class CategoryCollection {
  final List<Category> _categories = [
    Category(
        id: 'today',
        name: 'Today',
        icon: CategoryIcon(
          bgColor: CupertinoColors.systemBlue,
          iconData: CupertinoIcons.calendar_today,
        )),
    Category(
        id: 'scheduled',
        name: 'Scheduled',
        icon: CategoryIcon(
          bgColor: CupertinoColors.systemRed,
          iconData: CupertinoIcons.calendar,
        )),
    Category(
        id: 'all',
        name: 'All',
        icon: CategoryIcon(
          bgColor: CupertinoColors.systemGrey,
          iconData: Icons.inbox_rounded,
        )),
    Category(
        id: 'flagged',
        name: 'Flagged',
        icon: CategoryIcon(
          bgColor: CupertinoColors.systemYellow,
          iconData: CupertinoIcons.flag_fill,
        )),
  ];

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  List<Category> get selectedCategories =>
      _categories.where((category) => category.isChecked == true).toList();

  Category removeItem(index) {
    return _categories.removeAt(index);
  }

  void insert(index, item) {
    _categories.insert(index, item);
  }
}
