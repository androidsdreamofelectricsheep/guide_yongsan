import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String? appBarTitle;
  final List<Widget>? appBarActions;
  final Color? appBarBackgroundColor;
  final Widget? appBarleading;
  const BaseLayout(
      {super.key,
      this.appBarTitle,
      this.appBarActions,
      this.appBarBackgroundColor,
      this.appBarleading,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ));
  }

  renderAppBar() {
    return appBarTitle != null
        ? AppBar(
            centerTitle: true,
            title: Text(appBarTitle!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            actions: appBarActions,
            backgroundColor: appBarBackgroundColor,
            elevation: 0.0,
            leading: appBarleading)
        : null;
  }
}
