import 'package:flutter/material.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/major_category_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/category_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MajorCategoryProvider>(context, listen: false)
        .eitherFailureOrMajorCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final majorCategoryList =
        context.watch<MajorCategoryProvider>().majorCategory;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
          child: majorCategoryList != null
              ? makeList(majorCategoryList)
              : const Center(child: CircularProgressIndicator())),
    );
  }

  GridView makeList(List<MarjorCategoryEntity> majorCategoryList) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var majorCategory = majorCategoryList[index];
          return CategoryWidget(
              majorId: majorCategory.majorId,
              majorName: majorCategory.majorName);
        });
  }
}
