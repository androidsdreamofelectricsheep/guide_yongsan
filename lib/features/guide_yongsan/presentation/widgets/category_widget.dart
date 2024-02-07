import 'package:flutter/material.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/medium_category_screen.dart';

class CategoryWidget extends StatelessWidget {
  final String? majorId;
  final String? majorName;
  final String? mediumId;
  final String? mediumName;

  const CategoryWidget(
      {super.key,
      required this.majorId,
      required this.majorName,
      required this.mediumId,
      required this.mediumName});

  @override
  Widget build(BuildContext context) {
    late String name;
    if (majorName != null) {
      name = majorName!;
    }
    if (mediumName != null) {
      name = mediumName!;
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            if (majorId != null && mediumId != null) {
              return MediumCategoryScreen(majorId: majorId!);
            }
            return MediumCategoryScreen(majorId: majorId!);
          }));
        },
        child: Column(children: [Text(name)]));
  }
}
