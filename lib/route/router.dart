import 'package:go_router/go_router.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/company_detail_info_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/favorite_places_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/home_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/main_info_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/medium_category_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/menu_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/sub_category_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/menu_widget.dart';

final router = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) {
        return BottomNavigationBarWidget(
          child: child,
        );
      },
      routes: [
        GoRoute(
            name: HomeScreen.routeName,
            path: HomeScreen.routeUrl,
            builder: (_, state) => const HomeScreen()),
        GoRoute(
            name: FavoritePlacesScreen.routeName,
            path: FavoritePlacesScreen.routeUrl,
            builder: (_, state) => const FavoritePlacesScreen()),
        GoRoute(
            name: MenuScreen.routeName,
            path: MenuScreen.routeUrl,
            builder: (_, state) => const MenuScreen()),
        GoRoute(
            name: MainInfoScreen.routeName,
            path: MainInfoScreen.routeUrl,
            builder: (context, state) {
              final extra = state.extra as Map;
              return MainInfoScreen(
                  majorId: extra['majorId'],
                  mediumId: extra['mediumId'],
                  minorId: extra['minorId'],
                  subName: extra['subName']);
            }),
        GoRoute(
            name: MediumCategoryScreen.routeName,
            path: MediumCategoryScreen.routeUrl,
            builder: (context, state) {
              final extra = state.extra as Map;
              return MediumCategoryScreen(
                  majorId: extra['majorId'], majorName: extra['majorName']);
            }),
        GoRoute(
            name: SubCategoryScreen.routeName,
            path: SubCategoryScreen.routeUrl,
            builder: (context, state) {
              final extra = state.extra as Map;
              return SubCategoryScreen(
                  majorId: extra['majorId'],
                  mediumId: extra['mediumId'],
                  mediumName: extra['mediumName']);
            }),
        GoRoute(
            name: CompanyDetailInfoScreen.routeName,
            path: CompanyDetailInfoScreen.routeUrl,
            builder: (context, state) {
              final extra = state.extra as Map;
              return CompanyDetailInfoScreen(
                  companyId: extra['companyId'],
                  companyName: extra['companyName'],
                  pointLng: extra['pointLng'],
                  pointLat: extra['pointLat'],
                  keyWord: extra['keyWord'],
                  addr: extra['addr']);
            }),
        GoRoute(
            name: MenuWidget.routeName,
            path: '/menu_widget/:markdown',
            builder: (context, state) {
              final markdown = state.pathParameters['markdown']!;
              return MenuWidget(markdown: markdown);
            }),
      ])
]);
