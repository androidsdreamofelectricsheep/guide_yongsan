import 'package:flutter/material.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/layout/base_layout.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/major_category_provider.dart';
import 'package:guide_yongsan/core/util/build_grid_view.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/category_widget.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeUrl = '/';
  static const routeName = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final majorCategoryProvider =
        Provider.of<MajorCategoryProvider>(context, listen: false);
    majorCategoryProvider.eitherFailureOrMajorCategory();

    return BaseLayout(
      appBarTitle: 'Home',
      child:
          Consumer<MajorCategoryProvider>(builder: (context, provider, widget) {
        if (provider.majorCategory != null) {
          return makeList(provider.majorCategory!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  GridView makeList(List<MarjorCategoryEntity> majorCategoryList) {
    return buildGirdView(
        itemCount: majorCategoryList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 행에 아이템 갯수
            childAspectRatio: 3.0, // 아이템 크기 비율
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0),
        itemBuilder: (context, index) {
          var majorCategory = majorCategoryList[index];
          return CategoryWidget(
            majorId: majorCategory.majorId,
            majorName: majorCategory.majorName,
            mediumId: null,
            mediumName: null,
            subId: null,
            subName: null,
          );
        },
        physics: const NeverScrollableScrollPhysics());
  }
}
