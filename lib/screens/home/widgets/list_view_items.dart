import 'package:flutter/material.dart';

import '../../../models/category/category_collection.dart';

const double LIST_VIEW_HEIGHT = 70;

class ListViewItems extends StatefulWidget {
  const ListViewItems({Key? key, required this.categoryCollection})
      : super(key: key);
  final CategoryCollection categoryCollection;

  @override
  State<ListViewItems> createState() => _ListViewItemsState();
}

class _ListViewItemsState extends State<ListViewItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.categoryCollection.categories.length * LIST_VIEW_HEIGHT,
      child: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = widget.categoryCollection.removeItem(oldIndex);
            widget.categoryCollection.insert(newIndex, item);
          });
        },
        children: widget.categoryCollection.categories
            .map((category) => SizedBox(
                  key: UniqueKey(),
                  height: LIST_VIEW_HEIGHT,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        category.toggleIsChecked();
                      });
                    },
                    tileColor: Colors.grey[700],
                    leading: Container(
                      decoration: BoxDecoration(
                        border: category.isChecked == false
                            ? Border.all(color: Colors.white)
                            : null,
                        color: category.isChecked == true
                            ? Colors.blueAccent
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check,
                          color: category.isChecked == true
                              ? Colors.white
                              : Colors.transparent),
                    ),
                    title: Row(
                      children: [
                        category.icon,
                        SizedBox(width: 10),
                        Text(category.name),
                      ],
                    ),
                    trailing: Icon(Icons.reorder),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
