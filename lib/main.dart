import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:guide_yongsan/core/util/logger.dart';
import 'package:guide_yongsan/core/util/permissions.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/company_detail_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/main_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/major_category_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/medium_category_provider.dart';

import 'package:guide_yongsan/route/router.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setPreferredOrientations(// 세로 모드 고정
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  await NaverMapSdk.instance.initialize(
      clientId: dotenv.get("NAVER_MAP_CLIENT_ID"),
      onAuthFailed: (e) {
        logger.e('Naver Map auth failed', error: e);
      });

  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();

    Permissions.checkLoactionPermission(context);
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MajorCategoryProvider()),
        ChangeNotifierProvider(create: (context) => MediumCategoryProvider()),
        ChangeNotifierProvider(create: (context) => MainInfoProvider()),
        ChangeNotifierProvider(
            create: (context) => CompanyDetailInfoProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Guide Yongsan',
        theme: ThemeData(
            useMaterial3: false,
            appBarTheme: const AppBarTheme(color: Color(0xff1190CB)),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Color(0xff1190CB))),
        routerConfig: router,
      ),
    );
  }
}
