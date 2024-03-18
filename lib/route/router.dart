import 'package:go_router/go_router.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/company_detail_info_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/home_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/main_info_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/medium_category_screen.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/sub_category_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routeUrl,
      builder: (context, state) => const HomeScreen()),
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
            pointLat: extra['pointLat']);
      }),
]);
