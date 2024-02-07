import 'package:flutter/material.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/major_category_provider.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/category_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final majorCategoryProvider =
        Provider.of<MajorCategoryProvider>(context, listen: false);
    majorCategoryProvider.eitherFailureOrMajorCategory();

    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: SafeArea(
          child: Consumer<MajorCategoryProvider>(
              builder: (context, provider, widget) {
            if (provider.majorCategory != null) {
              return makeList(provider.majorCategory!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ));
  }

  GridView makeList(List<MarjorCategoryEntity> majorCategoryList) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var majorCategory = majorCategoryList[index];
          return CategoryWidget(
            majorId: majorCategory.majorId,
            majorName: majorCategory.majorName,
            mediumId: null,
            mediumName: null,
          );
        });
  }
}
