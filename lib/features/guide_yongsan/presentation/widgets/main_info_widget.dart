import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/company_detail_info_screen.dart';

class MainInfoWidget extends StatelessWidget {
  final String majorId,
      mediumId,
      minorId,
      subName,
      num,
      companyId,
      companyName,
      addr,
      addrDetail,
      keyWord,
      addrId,
      phone,
      zipCode,
      pointLng,
      pointLat;

  const MainInfoWidget({
    super.key,
    required this.majorId,
    required this.mediumId,
    required this.minorId,
    required this.subName,
    required this.num,
    required this.companyId,
    required this.companyName,
    required this.addr,
    required this.addrDetail,
    required this.keyWord,
    required this.addrId,
    required this.phone,
    required this.zipCode,
    required this.pointLng,
    required this.pointLat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Map extra = {};
          extra['companyId'] = companyId;
          extra['companyName'] = companyName;
          extra['pointLng'] = pointLng;
          extra['pointLat'] = pointLat;
          extra['keyWord'] = keyWord;
          extra['addr'] = addr;
          context.pushNamed(CompanyDetailInfoScreen.routeName, extra: extra);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(num), Text(companyName), Text(addr), Text(keyWord)],
        ));
  }
}
