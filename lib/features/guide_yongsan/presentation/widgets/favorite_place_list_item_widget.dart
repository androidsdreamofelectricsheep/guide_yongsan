import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/company_detail_info_screen.dart';

class FavoritePlaceListItemWidget extends StatefulWidget {
  final String companyId, companyName, keyWord, pointLng, pointLat, addr;
  final void Function() onChange;
  final bool value;

  const FavoritePlaceListItemWidget(
      {super.key,
      required this.companyId,
      required this.companyName,
      required this.keyWord,
      required this.pointLng,
      required this.pointLat,
      required this.addr,
      required this.onChange,
      required this.value});

  @override
  State<FavoritePlaceListItemWidget> createState() =>
      _FavoritePlaceListItemWidgetState();
}

class _FavoritePlaceListItemWidgetState
    extends State<FavoritePlaceListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: Row(children: [
            IconButton(
                onPressed: widget.onChange,
                icon: Icon(widget.value
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded)),
            Flexible(
              child: InkWell(
                onTap: () {
                  Map extra = {};
                  extra['companyId'] = widget.companyId;
                  extra['companyName'] = widget.companyName;
                  extra['pointLng'] = widget.pointLng;
                  extra['pointLat'] = widget.pointLat;
                  extra['keyWord'] = widget.keyWord;
                  extra['addr'] = widget.addr;
                  context.goNamed(CompanyDetailInfoScreen.routeName,
                      extra: extra);
                },
                child: Column(
                  children: [
                    Text(widget.companyName),
                    Text(widget.addr),
                    Text(widget.keyWord)
                  ],
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
