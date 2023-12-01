import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_note/exports.dart';

@immutable
class CatalogScreenArgs {
  final AppCatalog catalog;

  const CatalogScreenArgs({required this.catalog});
}

class CatalogScreen extends StatelessWidget {
  final CatalogScreenArgs args;

  const CatalogScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.catalog.title),
      ),
      body: SingleChildScrollView(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(
            args.catalog.screens.length,
            (index) {
              return _menuCard(
                context,
                index,
                args.catalog.screens[index],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context,
    int index,
    AppScreen appScreen,
  ) {
    const colors = Palette.mainColors;
    final color = colors[Random().nextInt(colors.length)];

    return GestureDetector(
      onTap: () {
        switch (appScreen.type) {
          case AppScreenType.unsplashDemo:
            AppNavigator.navigateTo(context, AppPath.unsplash);
          case AppScreenType.customChart:
            AppNavigator.navigateTo(context, AppPath.customChart);
          case AppScreenType.notificationCenter:
            AppNavigator.navigateTo(context, AppPath.notificationCenter);
        }
      },
      child: Container(
        margin: _getMargin(index),
        decoration: BoxDecoration(
          color: Palette
              .mainColors[Random().nextInt(Palette.mainColors.length - 1)],
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color.withOpacity(0.8),
              Colors.white,
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                appScreen.title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const Divider(
                height: 20,
                color: Colors.white,
              ),
              Text(
                appScreen.description,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets _getMargin(int index) {
    if (index % 2 == 0) {
      return const EdgeInsets.only(left: 5, right: 2.5, top: 5);
    }

    return const EdgeInsets.only(left: 2.5, right: 5, top: 5);
  }
}
