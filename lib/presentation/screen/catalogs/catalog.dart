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
    return GestureDetector(
      onTap: () {
        AppNavigator.navigateTo(context, AppPath.unsplash);
      },
      child: Container(
        margin: _getMargin(index),
        decoration: BoxDecoration(
            color: Palette.retroYellow04Dark,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            appScreen.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _getMargin(int index) {
    if (index % 2 == 0) {
      return const EdgeInsets.only(left: 5, right: 2.5, bottom: 5);
    }

    return const EdgeInsets.only(left: 2.5, right: 5, bottom: 5);
  }
}
