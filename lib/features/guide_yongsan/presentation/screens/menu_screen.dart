import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/util/logger.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/layout/base_layout.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class MenuScreen extends StatelessWidget {
  static const routeUrl = '/menu';
  static const routeName = 'menu';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBarTitle: 'Menu',
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: menuList.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  if (index < 2) {
                    // 약관
                    context.pushNamed(MenuWidget.routeName, pathParameters: {
                      'markdown': menuList[index]['markdown']!
                    });
                  } else {
                    // 문의
                    Uri uri = Uri.parse(
                      'mailto:n01077202@humbermail.ca?subject=Hello&body=Good day!',
                    );

                    context.goNamed(MenuScreen
                        .routeName); // 메일 작성화면으로 넘어간 후 앱으로 돌아왔을 때 아무것도 없는 화면(뒤로가기 없음) 방지

                    try {
                      await launcher.launchUrl(uri);
                    } catch (e) {
                      logger.e('Mail to developer error', error: e);
                    }
                  }
                },
                child: ListTile(
                  shape: const Border(
                      bottom: BorderSide(width: 1, color: Colors.grey)),
                  title: Text(menuList[index]['mname']!),
                  trailing: Transform.translate(
                    offset: const Offset(20, 0), // 꺽쇠 아이콘 측면, 가장자리로 붙이기
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              )),
    );
  }
}
