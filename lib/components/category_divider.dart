import 'package:flutter/material.dart';

class CategoryDivider extends StatelessWidget {
  const CategoryDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      width: 20,
      thickness: 2,
      indent: 2,
      endIndent: 2,
      color: Colors.black,
    );
  }
}
