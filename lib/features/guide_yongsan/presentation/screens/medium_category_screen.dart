import 'package:flutter/material.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/major_category_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/medium_category_provider.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/category_widget.dart';
import 'package:provider/provider.dart';

class MediumCategoryScreen extends StatelessWidget {
  final String majorId;
  const MediumCategoryScreen({super.key, required this.majorId});

  @override
  Widget build(BuildContext context) {
    print('mediumCategory majorId');
    print(majorId);
    final mediumCategoryProvider =
        Provider.of<MediumCategoryProvider>(context, listen: false);
    // mediumCategoryProvider.eitherFailureOrMajorCategory();
    mediumCategoryProvider.eitherFailureOrMediumCategorya(majorId: majorId);

    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: SafeArea(
          child: Consumer<MediumCategoryProvider>(
              builder: (context, provider, widget) {
            if (provider.mediumCategory != null) {
              return makeList(provider.mediumCategory!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ));
  }

  GridView makeList(List<MediumCategoryEntity> mediumCategoryList) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var mediumCategory = mediumCategoryList[index];
          return CategoryWidget(
            majorId: majorId,
            majorName: null,
            mediumId: mediumCategory.mediumId,
            mediumName: mediumCategory.mediumName,
          );
        });
  }
}
