import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_note/exports.dart';

@immutable
class MainScreenArgs {
  final List<AppCatalog> catalogs;

  const MainScreenArgs({required this.catalogs});
}

class MainScreen extends StatefulWidget {
  final MainScreenArgs args;

  const MainScreen({
    super.key,
    required this.args,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.blueAccent,
              Colors.white,
              Colors.white,
            ])),
        child: Column(
          children: [
            _header(),
            _menuCards(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const SizedBox(
      width: double.infinity,
      height: 200,
      child: Center(
        child: Text(
          'Header',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _menuCards() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.args.catalogs.length,
        itemBuilder: (context, index) {
          return _card(index, widget.args.catalogs[index]);
        },
      ),
    );
  }

  Widget _card(int index, AppCatalog catalog) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color:
            Palette.mainColors[Random().nextInt(Palette.mainColors.length - 1)],
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {
            AppNavigator.navigateTo(
              context,
              AppPath.catalogs,
              arguments: CatalogScreenArgs(catalog: catalog)
            );
          },
          child: Center(
            child: Text(
              catalog.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
