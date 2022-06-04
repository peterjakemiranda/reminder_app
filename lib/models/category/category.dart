import '../../common/widgets/category_icon.dart';

class Category {
  String id;
  String name;
  bool? isChecked;
  final CategoryIcon icon;

  Category(
      {required this.icon,
      required this.id,
      required this.name,
      this.isChecked = true});

  void toggleIsChecked() {
    this.isChecked = this.isChecked == true ? false : true;
  }
}