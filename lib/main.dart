import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:guide_yongsan/core/util/permissions.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/company_detail_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/main_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/major_category_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/medium_category_provider.dart';

import 'package:guide_yongsan/route/router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await NaverMapSdk.instance.initialize(
      clientId: dotenv.get("NAVER_MAP_CLIENT_ID"),
      onAuthFailed: (e) {
        print(e);
      });

  runApp(const MaterialApp(home: MyApp()));
  // runApp(const MyApp());
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
  }

  @override
  Widget build(BuildContext context) {
    // Permissions.checkLoactionPermission(context);

    // showChangePermissionModal();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MajorCategoryProvider()),
        ChangeNotifierProvider(create: (context) => MediumCategoryProvider()),
        ChangeNotifierProvider(create: (context) => MainInfoProvider()),
        ChangeNotifierProvider(
            create: (context) => CompanyDetailInfoProvider()),
      ],
      child: MaterialApp.router(
        title: 'Guide Yongsan',
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        ),
        routerConfig: router,
      ),
    );
  }

  showChangePermissionModal() async {
    // Permissions.isLoactionPermissionAllowed().then((value) => value
    //     ? null
    //     : showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             content: const Text(
    //                 'If location permission is not allowed, GuideYongsan is not available. Please allow to use GuideYongsan.'),
    //             actions: [
    //               TextButton(
    //                   onPressed: () {
    //                     // Navigator.of(context).pop();
    //                     SystemNavigator.pop();
    //                   },
    //                   child: const Text('Close')),
    //               TextButton(
    //                   onPressed: () {
    //                     openAppSettings();
    //                     Navigator.of(context).pop();
    //                   },
    //                   child: const Text('To allow')),
    //             ],
    //           );
    //         }));
  }
}
