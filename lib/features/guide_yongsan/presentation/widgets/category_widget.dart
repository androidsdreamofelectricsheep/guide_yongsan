import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/main_info_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/medium_category_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/sub_category_screen.dart';

class CategoryWidget extends StatelessWidget {
  final String? majorId;
  final String? majorName;
  final String? mediumId;
  final String? mediumName;
  final String? subId;
  final String? subName;

  const CategoryWidget(
      {super.key,
      required this.majorId,
      required this.majorName,
      required this.mediumId,
      required this.mediumName,
      required this.subId,
      required this.subName});

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
    if (subId != null && subName != null) {
      id = subId!;
      name = subName!;
    }

    return GestureDetector(
        onTap: () {
          Map extra = {};

          if (majorId != null && majorName != null) {
            extra['majorId'] = majorId;
            extra['majorName'] = majorName;
            context.pushNamed(MediumCategoryScreen.routeName, extra: extra);
          }
          if (majorId != null &&
              mediumId != null &&
              mediumName != null &&
              subId == null &&
              subName == null) {
            extra['majorId'] = majorId;
            extra['mediumId'] = mediumId;
            extra['mediumName'] = mediumName;
            context.pushNamed(SubCategoryScreen.routeName, extra: extra);
          }
          if (majorId != null &&
              mediumId != null &&
              subId != null &&
              subName != null) {
            extra['majorId'] = majorId;
            extra['mediumId'] = mediumId;
            extra['minorId'] = subId;
            extra['subName'] = subName;
            context.pushNamed(MainInfoScreen.routeName, extra: extra);
          }
        },
        child: Column(children: [Text(name), Text(id)]));
  }
}
