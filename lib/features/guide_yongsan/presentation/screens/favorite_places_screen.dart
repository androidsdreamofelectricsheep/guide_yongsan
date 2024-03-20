import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/favorite_place_list_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePlacesScreen extends StatefulWidget {
  static const routeUrl = '/favorite_places';
  static const routeName = 'favorites';
  const FavoritePlacesScreen({super.key});

  @override
  State<FavoritePlacesScreen> createState() => _FavoritePlacesScreenState();
}

class _FavoritePlacesScreenState extends State<FavoritePlacesScreen> {
  late SharedPreferences sharedPreferences;
  late List favoritePlaces = [];
  late List removePlaceList = [];
  bool isSelectedAll = false;
  bool forAll = false;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setStringList(likedPlaces, []);

    if (sharedPreferences.getStringList(likedPlaces) != null) {
      final List storedLikedPlaces =
          sharedPreferences.getStringList(likedPlaces)!;
      List temp = [];

      for (var place in storedLikedPlaces) {
        Map placeMap = jsonDecode(place);
        placeMap['value'] = false; // 각각의 좋아요한 장소 체크박스값 초기화
        temp.add(placeMap);
      }

      setState(() {
        favoritePlaces.addAll(temp);
      });
    }
  }

  void initLoad() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initSharedPreferences();
    });
  }

  @override
  void initState() {
    super.initState();
    initLoad();
  }

  onSelectAllPlaces() async {
    if (favoritePlaces.isEmpty) {
      return;
    }

    // 전체 선택/해제
    setState(() {
      removePlaceList.clear(); // 중복 방지 리스트 비우기
      isSelectedAll = !isSelectedAll;
      forAll = true;
      if (isSelectedAll) {
        final deleteIdList = favoritePlaces.map((p) => p['companyId']).toList();
        removePlaceList.addAll(deleteIdList);
        print('removeList1');
        print(removePlaceList);
      } else {
        removePlaceList.clear();
        print('removeList2');
        print(removePlaceList);
      }
    });
  }

  onDeleteSelectedPlaces() async {
    if (removePlaceList.isEmpty) {
      return;
    }

    deletionModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite places'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: onSelectAllPlaces,
                    icon: Icon(isSelectedAll
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline_rounded),
                    label: const Text('Select all')),
                TextButton.icon(
                    onPressed: onDeleteSelectedPlaces,
                    icon: const Icon(Icons.delete_forever_rounded),
                    label: const Text('Delete'))
              ],
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: favoritePlaces.length,
                itemBuilder: (context, index) => FavoritePlaceListItemWidget(
                      companyId: favoritePlaces[index]['companyId'],
                      companyName: favoritePlaces[index]['companyName'],
                      keyWord: favoritePlaces[index]['keyWord'] ?? '',
                      addr: favoritePlaces[index]['addr'] ?? '',
                      pointLat: favoritePlaces[index]['pointLat'],
                      pointLng: favoritePlaces[index]['pointLng'],
                      value: forAll
                          ? favoritePlaces[index]['value'] =
                              isSelectedAll // 전체 선택 플래그 체크시 전체 선택 값, 각각의 모든 장소 체크 박스에 할당(모두 체크, 모두 해제)
                          : favoritePlaces[index]['value'],
                      onChange: () {
                        setState(() {
                          forAll = false; // 각각의 좋아요한 장소 체크박스 체크시 전체 선택 플래그 해제
                        });

                        final newValue = !favoritePlaces[index]['value'];
                        favoritePlaces[index]['value'] = newValue;

                        if (!newValue) {
                          setState(() {
                            isSelectedAll = false;
                          });
                        } else {
                          final allSelected =
                              favoritePlaces.every((place) => place['value']);

                          setState(() {
                            isSelectedAll = allSelected;
                          });
                        }

                        if (favoritePlaces[index]['value'] &&
                            !removePlaceList
                                .contains(favoritePlaces[index]['companyId'])) {
                          // 체크되었을 때 삭제 리스트에 추가
                          removePlaceList
                              .add(favoritePlaces[index]['companyId']);
                        } else {
                          // 체크 해제 시 삭제 리스트에서 제거
                          removePlaceList
                              .remove(favoritePlaces[index]['companyId']);
                        }

                        print('removeList3');
                        print(removePlaceList);
                      },
                    ))
          ]),
        ));
  }

  deletionModal() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Are you sure to delete selected place(s)?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    deleteSelectedPlaces();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'))
            ],
          );
        });
  }

  deleteSelectedPlaces() async {
    List temp = [...removePlaceList];

    for (var removeId in removePlaceList) {
      setState(() {
        favoritePlaces
            .removeWhere((element) => element['companyId'] == removeId);
        temp.remove(removeId);
      });
    }

    removePlaceList = temp;

    print('removeList5');
    print(removePlaceList);

    print('favoritePlaces');
    print(favoritePlaces);
    print(favoritePlaces.length);

    // 저장한 장소(좋아요한 장소) 삭제 후 모바일 저장소(로컬)에 변경 사항 업데이트
    final encodedLikedPlaceList =
        favoritePlaces.map((e) => jsonEncode(e)).toList();
    await sharedPreferences.setStringList(likedPlaces, encodedLikedPlaceList);
  }
}
