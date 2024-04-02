import 'package:flutter/material.dart';

GridView buildGirdView(
    {required int itemCount,
    required SliverGridDelegate gridDelegate,
    required Widget? Function(BuildContext, int) itemBuilder,
    ScrollPhysics? physics} // 스크롤 끔
    ) {
  return GridView.builder(
      itemCount: itemCount,
      physics: physics,
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder);
}
