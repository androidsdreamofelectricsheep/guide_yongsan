import 'package:flutter/material.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/company_detail_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/main_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/major_category_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/medium_category_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      child: MaterialApp(
        title: 'Guide Yongsan',
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
