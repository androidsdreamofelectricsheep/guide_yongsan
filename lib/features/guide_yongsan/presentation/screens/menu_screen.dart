import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  static const routeUrl = '/menu';
  static const routeName = 'menu';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('menu')),
    );
  }
}
