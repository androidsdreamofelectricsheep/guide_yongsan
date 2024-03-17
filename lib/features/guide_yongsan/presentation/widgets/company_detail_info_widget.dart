import 'package:flutter/material.dart';

class CompanyDetailInfoWidget extends StatelessWidget {
  final String companyItem;
  final String companyInfo;
  const CompanyDetailInfoWidget(
      {super.key, required this.companyItem, required this.companyInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(companyItem),
              const SizedBox(
                height: 10,
              ),
              Text(companyInfo),
            ]),
      ),
    );
  }
}
