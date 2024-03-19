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
  bool isAllSelected = false;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getStringList(likedPlaces) != null) {
      setState(() {
        favoritePlaces.addAll(sharedPreferences.getStringList(likedPlaces)!);
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

  onSelectAllPlaces() async {}

  onDeleteSelectedPlaces() async {
    // TODO: 팝업 'Are you sure to delete selected place(s)?'
  }

  @override
  Widget build(BuildContext context) {
    print('************');
    print(favoritePlaces);
    print('************');
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
                    icon: Icon(isAllSelected
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
                itemCount: favoritePlaces.length,
                itemBuilder: (context, index) =>
                    // const FavoritePlaceListItemWidget(companyId: ,))
                    const Text(''))
          ]),
        ));
  }
}
