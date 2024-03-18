import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/favorite_places_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/home_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/menu_screen.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final Widget child;

  const BottomNavigationBarWidget({super.key, required this.child});

  int getIndex(BuildContext context) {
    if (GoRouter.of(context).routeInformationProvider.value.uri.toString() ==
        HomeScreen.routeUrl) {
      return 0;
    } else if (GoRouter.of(context)
            .routeInformationProvider
            .value
            .uri
            .toString() ==
        FavoritePlacesScreen.routeUrl) {
      return 1;
    } else if (GoRouter.of(context)
            .routeInformationProvider
            .value
            .uri
            .toString() ==
        MenuScreen.routeUrl) {
      return 2;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: getIndex(context),
          onTap: (index) {
            if (index == 0) {
              context.goNamed(HomeScreen.routeName);
            } else if (index == 1) {
              context.goNamed(FavoritePlacesScreen.routeName);
            } else {
              context.goNamed(MenuScreen.routeName);
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'home',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded),
                label: 'favorites',
                activeIcon: Icon(Icons.favorite_rounded)),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'menu',
                activeIcon: Icon(Icons.menu_rounded)),
          ]),
    );
  }
}
