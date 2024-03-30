import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/layout/base_layout.dart';

class MenuWidget extends StatelessWidget {
  static const routeName = 'menu_widget';

  final String markdown;
  const MenuWidget({super.key, required this.markdown});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBarTitle: '',
      appBarBackgroundColor: Colors.transparent,
      appBarleading: const BackButton(color: Colors.grey),
      child: FutureBuilder(
        future: rootBundle.loadString(markdown),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
