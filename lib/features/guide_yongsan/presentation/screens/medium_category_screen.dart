import 'package:flutter/material.dart';

import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/layout/base_layout.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/medium_category_provider.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/category_widget.dart';
import 'package:provider/provider.dart';

class MediumCategoryScreen extends StatelessWidget {
  static const routeUrl = '/medium_category';
  static const routeName = 'mediumCategory';

  final String majorId, majorName;
  const MediumCategoryScreen(
      {super.key, required this.majorId, required this.majorName});

  @override
  Widget build(BuildContext context) {
    final mediumCategoryProvider =
        Provider.of<MediumCategoryProvider>(context, listen: false);
    mediumCategoryProvider.eitherFailureOrMediumCategorya(majorId: majorId);

    return BaseLayout(
      appBarTitle: majorName,
      child: Consumer<MediumCategoryProvider>(
          builder: (context, provider, widget) {
        if (provider.mediumCategory != null) {
          return makeList(provider.mediumCategory!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  GridView makeList(List<MediumCategoryEntity> mediumCategoryList) {
    return GridView.builder(
        itemCount: mediumCategoryList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var mediumCategory = mediumCategoryList[index];
          return CategoryWidget(
            majorId: majorId,
            majorName: null,
            mediumId: mediumCategory.mediumId,
            mediumName: mediumCategory.mediumName,
            subId: null,
            subName: null,
          );
        });
  }
}
