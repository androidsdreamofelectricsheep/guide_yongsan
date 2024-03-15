import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/util/asset.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/company_detail_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyDetailInfoScreen extends StatefulWidget {
  final String companyId;
  final String companyName;
  final String pointLng;
  final String pointLat;

  const CompanyDetailInfoScreen({
    super.key,
    required this.companyId,
    required this.companyName,
    required this.pointLng,
    required this.pointLat,
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
      if (likedPlacesList.contains(widget.companyId)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await sharedPreferences.setStringList(likedPlaces, []);
    }
  }

  void initLoad() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initSharedPreferences();
      context
          .read<CompanyDetailInfoProvider>()
          .eitherFailureOrMediumCategorya(companyId: widget.companyId);
    });
  }

  @override
  void initState() {
    super.initState();
    initLoad();
  }

  onHeartTap() async {
    final likedPlacesList = sharedPreferences.getStringList(likedPlaces);
    if (likedPlacesList != null) {
      if (isLiked) {
        likedPlacesList.remove(widget.companyId);
      } else {
        likedPlacesList.add(widget.companyId);
      }
      await sharedPreferences.setStringList(likedPlaces, likedPlacesList);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.companyName),
          actions: [
            IconButton(
                onPressed: onHeartTap,
                icon: Icon(isLiked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded))
          ],
          centerTitle: true),
      body: FutureBuilder(
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
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (BuildContext context) {
                          return const Text('까꿍');
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

  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
