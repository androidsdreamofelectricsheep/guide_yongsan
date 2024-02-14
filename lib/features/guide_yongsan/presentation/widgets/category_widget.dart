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
    late String id;
    late String name;
    if (majorId != null && majorName != null) {
      id = majorId!;
      name = majorName!;
    }
    if (mediumId != null && mediumName != null) {
      id = mediumId!;
      name = mediumName!;
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            if (majorId != null && majorName != null) {
              return MediumCategoryScreen(
                majorId: majorId!,
                majorName: majorName!,
              );
            }
            return const Center(child: CircularProgressIndicator());
          }));
        },
        child: Column(children: [Text(name), Text(id)]));
  }
}
