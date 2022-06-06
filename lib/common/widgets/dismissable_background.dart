import 'package:flutter/material.dart';

class DismissableBackground extends StatelessWidget {
  const DismissableBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      color: Colors.red,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Icon(Icons.delete)),
    );
  }
}
