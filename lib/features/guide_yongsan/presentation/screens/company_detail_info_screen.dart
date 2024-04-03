import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/util/asset.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/layout/base_layout.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/company_detail_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/company_detail_info_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyDetailInfoScreen extends StatefulWidget {
  static const routeUrl = '/company_detail_info';
  static const routeName = 'companyDetailInfo';
  final String companyId;
  final String companyName;
  final String pointLng;
  final String pointLat;
  final String keyWord;
  final String addr;

  const CompanyDetailInfoScreen({
    super.key,
    required this.companyId,
    required this.companyName,
    required this.pointLng,
    required this.pointLat,
    required this.keyWord,
    required this.addr,
  });

  @override
  State<CompanyDetailInfoScreen> createState() =>
      _CompanyDetailInfoScreenState();
}

class _CompanyDetailInfoScreenState extends State<CompanyDetailInfoScreen> {
  late SharedPreferences sharedPreferences;
  late bool isLiked = false;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    final likedPlacesList = sharedPreferences.getStringList(likedPlaces);
    if (likedPlacesList != null) {
      for (var likedPlace in likedPlacesList) {
        Map decodedLikedPlace = jsonDecode(likedPlace);

        if (decodedLikedPlace['companyId'] == widget.companyId) {
          setState(() {
            isLiked = true;
          });
        }
      }
    } else {
      await sharedPreferences.setStringList(likedPlaces, []);
    }
  }

  void initLoad() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initSharedPreferences();
      Provider.of<CompanyDetailInfoProvider>(context, listen: false)
          .eitherFailureOrCompanyDetailInfo(companyId: widget.companyId);
    });
  }

  @override
  void initState() {
    super.initState();
    initLoad();
  }

  onHeartTap() async {
    final likedPlacesList = sharedPreferences.getStringList(likedPlaces);

    Map likedPlaceInfo = {};

    if (likedPlacesList != null) {
      if (isLiked) {
        // 이미 좋아요인 상태면 좋아요 해제(리스트에서 해당 장소 제거)

        likedPlacesList.removeWhere(
            (element) => jsonDecode(element)['companyId'] == widget.companyId);
      } else {
        likedPlaceInfo['companyId'] = widget.companyId;
        likedPlaceInfo['companyName'] = widget.companyName;
        likedPlaceInfo['pointLng'] = widget.pointLng;
        likedPlaceInfo['pointLat'] = widget.pointLat;
        likedPlaceInfo['keyWord'] = widget.keyWord;
        likedPlaceInfo['addr'] = widget.addr;

        likedPlacesList.add(jsonEncode(likedPlaceInfo));
      }
      await sharedPreferences.setStringList(likedPlaces, likedPlacesList);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBarTitle: widget.companyName,
      appBarActions: [
        IconButton(
            onPressed: onHeartTap,
            icon: Icon(isLiked
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded))
      ],
      child: FutureBuilder(
          future: getLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NaverMap(
                options: NaverMapViewOptions(
                  mapType: NMapType.basic,
                  locale: const Locale('en'),
                  activeLayerGroups: [
                    NLayerGroup.building,
                    NLayerGroup.transit
                  ],
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(double.parse(widget.pointLat),
                        double.parse(widget.pointLng)),
                    // zoom: 17,
                    zoom: 11,
                    bearing: 0,
                    tilt: 0,
                  ),
                  pickTolerance: 8,
                  extent: const NLatLngBounds(
                    // 지도 영역을 한반도 인근으로 제한
                    southWest: NLatLng(31.43, 122.37),
                    northEast: NLatLng(44.35, 132.0),
                  ),
                ),
                onMapReady: (controller) {
                  final companyMarker = NMarker(
                    id: widget.companyId,
                    position: NLatLng(double.parse(widget.pointLat),
                        double.parse(widget.pointLng)),
                  );

                  final userMarker = NMarker(
                      id: 'userMarker',
                      position: NLatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                      icon:
                          const NOverlayImage.fromAssetImage(Asset.userMarker),
                      size: const Size(45, 45));

                  controller.addOverlayAll({companyMarker, userMarker});

                  final companyMarkerInfoWindow = NInfoWindow.onMarker(
                      id: companyMarker.info.id, text: widget.companyName);
                  companyMarker.openInfoWindow(companyMarkerInfoWindow);

                  final userMarkerInfoWindow =
                      NInfoWindow.onMarker(id: 'userMarker', text: 'Me');
                  userMarker.openInfoWindow(userMarkerInfoWindow);

                  companyMarker.setOnTapListener((overlay) async {
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        // isScrollControlled: true, // 바텀시트가 화면 전체를 덮어버림
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (BuildContext context) {
                          return makeList();
                        });
                  });
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget makeList() {
    return Consumer<CompanyDetailInfoProvider>(
        builder: (context, provider, widget) {
      if (provider.companyDetailInfo != null) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: provider.companyDetailInfo?.length,
            itemBuilder: (context, index) => CompanyDetailInfoWidget(
                companyItem: provider.companyDetailInfo![index].companyItem,
                companyInfo:
                    provider.companyDetailInfo![index].companyInfo ?? '-'));
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
