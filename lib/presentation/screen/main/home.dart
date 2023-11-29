import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_note/exports.dart';

@immutable
class HomeScreenArgs {
  final List<AppCatalog> catalogs;

  const HomeScreenArgs({required this.catalogs});
}

class HomeScreen extends StatefulWidget {
  final HomeScreenArgs args;

  const HomeScreen({
    super.key,
    required this.args,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            ],
          ),
        ),
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
          'Home',
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
    const colors = Palette.mainColors;
    final color = colors[Random().nextInt(colors.length)];

    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {
            AppNavigator.navigateTo(context, AppPath.catalogs,
                arguments: CatalogScreenArgs(catalog: catalog));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Text(
                    catalog.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                  child: VerticalDivider(
                    width: 1,
                    color: Colors.white,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Text(
                    catalog.description,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
