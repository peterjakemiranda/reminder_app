import 'package:flutter/material.dart';
import 'package:reminder_app/models/category/category.dart';

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
            (category) => Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF1A191D),
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
                        '0',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                  Text(category.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
