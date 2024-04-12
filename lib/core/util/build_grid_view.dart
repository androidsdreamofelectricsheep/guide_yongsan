import 'package:flutter/material.dart';
import 'package:guide_yongsan/core/util/device_checker.dart';

GridView buildGirdView(
    {required int itemCount,
    required SliverGridDelegate gridDelegate,
    required Widget? Function(BuildContext, int) itemBuilder,
    ScrollPhysics? physics} // 스크롤 끔
    ) {
  return GridView.builder(
      itemCount: itemCount,
      physics: isTablet || itemCount >= 18
          ? const RangeMaintainingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder);
}
