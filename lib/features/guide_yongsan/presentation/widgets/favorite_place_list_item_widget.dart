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
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              IconButton(
                  // visualDensity: const VisualDensity(
                  //   // Transform.translate과 Offset(-4, 0)동일
                  //   horizontal: -4,
                  // ),
                  onPressed: widget.onChange,
                  icon: Icon(
                    widget.value
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  )),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.companyName,
                      ),
                      Text(widget.addr),
                      Text(widget.keyWord)
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
