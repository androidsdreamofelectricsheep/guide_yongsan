import 'package:flutter/material.dart';
import 'package:guide_yongsan/core/constants/constants.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/category_widget.dart';

class SubCategoryScreen extends StatelessWidget {
  final String majorId, mediumId, mediumName;

  const SubCategoryScreen(
      {super.key,
      required this.majorId,
      required this.mediumId,
      required this.mediumName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(mediumName)),
        body: SafeArea(child: makeList(subCategory[mediumName]!)));
  }

  GridView makeList(List<Map<String, String>> subCategoryList) {
    return GridView.builder(
        itemCount: subCategoryList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var subCategory = subCategoryList[index];

          return CategoryWidget(
            majorId: majorId,
            majorName: null,
            mediumId: mediumId,
            mediumName: mediumName,
            subId: subCategory['subId'],
            subName: subCategory['subName'],
          );
        });
  }
}
