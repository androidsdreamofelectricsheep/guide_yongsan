import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String majorId, majorName;

  const CategoryWidget(
      {super.key, required this.majorId, required this.majorName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(children: [Text(majorName)]),
    );
  }
}
