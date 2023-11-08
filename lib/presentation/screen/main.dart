import 'package:flutter/material.dart';
import 'package:flutter_note/exports.dart';
import 'package:flutter_note/presentation/screen/ui/theme/palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
            ]
          )
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
          'Header',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget _menuCards() {
    const colors = Palette.mainColors;

    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(
          colors.length,
          growable: true,
          (index) {
            return _menuCard(index, colors[index]);
          },
        ),
      ),
    );
  }

  Widget _menuCard(int index, Color color) {
    return GestureDetector(
      onTap: () {
        AppNavigator.navigateTo(context, AppPath.unsplash);
      },
      child: Container(
        margin: _getMargin(index),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            'Test',
            textAlign: TextAlign.center,
            style: TextStyle(
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
