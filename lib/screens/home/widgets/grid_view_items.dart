import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/category/category.dart';
import 'package:reminder_app/models/reminder/reminder.dart';
import 'package:reminder_app/screens/view_list/view_list_by_category_screen.dart';

class GridViewItems extends StatefulWidget {
  const GridViewItems({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  State<GridViewItems> createState() => _GridViewItemsState();
}

class _GridViewItemsState extends State<GridViewItems> {
  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 16 / 9,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: widget.categories
          .map(
            (category) => InkWell(
              onTap: getCategoryCount(
                          id: category.id, allReminders: allReminders) >
                      0
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewListByCategoryScreen(
                                    category: category,
                                  )));
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        category.icon,
                        Text(
                          getCategoryCount(
                            id: category.id,
                            allReminders: allReminders,
                          ).toString(),
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    Text(category.name)
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  int getCategoryCount({required String id, List<Reminder>? allReminders}) {
    if (id == 'all' && allReminders != null) {
      return allReminders.length;
    }
    final categories =
        allReminders?.where((reminder) => reminder.categoryId == id);
    if (categories != null) {
      return categories.length;
    }
    return 0;
  }
}
